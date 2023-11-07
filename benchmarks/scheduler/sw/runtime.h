#ifndef _SCHEDULER_H_
#define _SCHEDULER_H_

#include <limits.h>
#include <math.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "../defines.h"

//#define SCALE_EXPERIMENT
#ifdef SCALE_EXPERIMENT
    #define MAX_ACC_INSTANCES    10
    #define MAX_ACC_ARGS         5
    #define MAX_ACC_SPM_PARTS    5
    #define MAX_CHILDREN         1500
    #define MAX_DAGS             50
    #define MAX_NODES            1500
    #define MAX_READY_QUEUE_SIZE 1500
#else
    #define MAX_ACC_INSTANCES    10
    #define MAX_ACC_ARGS         5
    #define MAX_ACC_SPM_PARTS    5
    #define MAX_CHILDREN         50
    #define MAX_DAGS             50
    #define MAX_NODES            3000
    #define MAX_READY_QUEUE_SIZE 500
#endif
//#define VERIFY
//#define PRINT_SCHEDULE
#define ENABLE_FORWARDING // DOES NOT WORK

//#define NUM_REPEATS 1
#define NUM_REPEATS 10
#define ENABLE_EARLY_EXIT
#define MIN_REPEATS 3

/* Enable gem5 timers for the following functions:
 * Timer 0: isr()
 * Timer 1: update_mem_time_predictor()
 * Timer 2: push_request()
 * Timer 3 (ELF only): sorted insertion into pipeline queue
 * Timer 4 (ELF only): get_pred_load_size()
 * Timer 5 (ELF only): get_pred_store_size()
 * Timer 6: run_accelerator()
 * Timer 7: driver()
 * Timer 8: dcache_flush()
 *
 * It also enables the collection and printing of other statistics using
 * structures and gem5 pseudo instructions.
 */
#define ENABLE_STATS

/**
 * Accelerator compute times (in microseconds)
 */
#define RUNTIME_CANNY_NON_MAX       400
#define RUNTIME_CONVOLUTION_3       637
#define RUNTIME_CONVOLUTION_5       1546
#define RUNTIME_EDGE_TRACKING       220
#define RUNTIME_ELEM_MATRIX_ADD     11
#define RUNTIME_ELEM_MATRIX_SUB     11
#define RUNTIME_ELEM_MATRIX_MUL     11
#define RUNTIME_ELEM_MATRIX_DIV     11
#define RUNTIME_ELEM_MATRIX_SQR     8
#define RUNTIME_ELEM_MATRIX_SQRT    8
#define RUNTIME_ELEM_MATRIX_ATAN2   11
#define RUNTIME_ELEM_MATRIX_TANH    8
#define RUNTIME_ELEM_MATRIX_SIGMOID 8
#define RUNTIME_GRAYSCALE           10
#define RUNTIME_HARRIS_NON_MAX      105
#define RUNTIME_ISP                 35

/**
 * Bookkeeping for accelerators
 */
enum acc_ids_t {
    ACC_CANNY_NON_MAX = 0,
    ACC_CONVOLUTION,
    ACC_EDGE_TRACKING,
    ACC_ELEM_MATRIX,
    ACC_GRAYSCALE,
    ACC_HARRIS_NON_MAX,
    ACC_ISP,
    NUM_ACCS
};

enum acc_status_t {
    ACC_STATUS_IDLE = 0,
    ACC_STATUS_DMA_ARG1,
    ACC_STATUS_DMA_ARG2,
    ACC_STATUS_RUNNING,
    ACC_STATUS_DMA_OUT
};

enum req_status_t {
    REQ_STATUS_WAITING = 0,
    REQ_STATUS_READY,
    REQ_STATUS_COMPLETED
};

/**
 * Supported scheduling policies
 */
enum scheduling_policy_t {
    FCFS = 0,
    GEDF_D,
    GEDF_N,
    LL,
    LAX,
    ELF,
    ELFD,
    HetSched
};

enum mem_predictor_t {
    MEM_PRED_LAST_VAL = 0,
    MEM_PRED_AVERAGE,
    MEM_PRED_EWMA,
    MEM_PRED_NO_PRED
};

/**
 * Structures for statistics
 */
enum m5_stat_t {
    DEGREE_OF_PARALLELISM = 0,
    NUM_FORWARDS,
    NUM_COLOCATIONS,
    DAG_DEADLINES_MET,
    NODE_DEADLINES_MET,
    DAG_ID,
    NODE_ID,
    DAG_EXEC_TIME,
    DAG_DEADLINE_DIFF,
    NODE_DEADLINE_DIFF,
    PREDICTED_COMPUTE_TIME,
    PREDICTED_MEMORY_TIME,
    PREDICTED_MEMORY_TIME_PER_BYTE,
    PREDICTED_MEMORY_SIZE,
    FINISHED_DAG_ITERS,
    DRAM_DATA_MOVEMENT,
    SPAD_DATA_MOVEMENT
};

typedef struct task_struct_t task_struct_t;
typedef struct acc_state_t acc_state_t;
typedef enum scheduling_policy_t scheduling_policy_t;
typedef enum mem_predictor_t mem_predictor_t;
typedef enum req_status_t req_status_t;
typedef enum m5_stat_t m5_stat_t;

struct task_struct_t {
    /**
     * User provides the following fields
     */
    uint8_t acc_id;
    void *acc_args;

    uint16_t num_children;
    uint16_t num_parents;

    task_struct_t *children[MAX_CHILDREN];
    task_struct_t *producer[MAX_ACC_ARGS];

    bool is_first_node;
    uint32_t output_size;
    uint32_t compute_time;
    uint32_t runtime;
    uint32_t dag_deadline;
    uint32_t node_deadline;

    /**
     * The following fields are for use by the runtime
     */
    uint16_t dag_id;
    uint16_t node_id;

    req_status_t status;
    int32_t laxity;
    bool priority_escalated;
    uint32_t sd;  // used by HetSched

    uint16_t completed_parents;
    uint8_t producer_spm_part[MAX_ACC_ARGS];    // partition of the producer's
                                                // output SPM to read from
    volatile acc_state_t *producer_acc[MAX_ACC_ARGS];   // producer accelerator

    // The following two fields don't count as "statistics" because they are
    // required for ELF's functionality
    uint32_t pred_load_size;
    uint32_t pred_store_size;

    /**
     * Fields for statistics
     */
#ifdef ENABLE_STATS
    float stat_mem_time_per_byte_pred_load;
    float stat_mem_time_pred_load;

    float stat_mem_time_per_byte_pred_store;
    float stat_mem_time_pred_store;

    float stat_mem_time_per_byte_truth_load;
    float stat_mem_time_truth_load;
    uint32_t stat_mem_size_truth_load;

    float stat_mem_time_per_byte_truth_store;
    float stat_mem_time_truth_store;
    uint32_t stat_mem_size_truth_store;
#endif
};

struct acc_state_t {
    /**
     * Physical address of accelerator registers/memory
     */
    volatile uint8_t *flags;
    volatile uint8_t *dma;
    uint32_t spm_addr[MAX_ACC_SPM_PARTS];

    /**
     * Bookkeeping structures
     */
    uint8_t status;
    volatile task_struct_t *running_req;

    uint32_t curr_spm_in_addr[MAX_ACC_ARGS];
    uint8_t curr_spm_out_part;
    uint8_t spm_ongoing_reads[MAX_ACC_SPM_PARTS];
    volatile task_struct_t *spm_results[MAX_ACC_SPM_PARTS];
};

/**
 * Accelerator arguments structs
 */
typedef struct {
    float *hypotenuse;
    float *theta;
    uint32_t *output;
} canny_non_max_args;

typedef struct {
    float *input;
    float *kernel;
    int kern_height;
    int kern_width;
    bool mod_and_floor;
    float *output;
} convolution_args;

typedef struct {
    uint32_t *input;
    float thr_weak_ratio;
    float thr_strong_ratio;
    uint8_t *output;
} edge_tracking_args;

typedef struct {
    float *arg1;
    float *arg2;
    uint8_t is_arg2_scalar;
    uint8_t op;
    uint8_t do_one_minus;
    float *output;
} elem_matrix_args;

typedef struct {
    uint8_t *input;
    float *output;
} grayscale_args;

typedef struct {
    float *input;
    uint8_t *output;
} harris_non_max_args;

typedef struct {
    uint8_t *input;
    uint8_t *output;
} isp_args;

/**
 * The actual runtime
 */
void runtime(task_struct_t ***, int, int [MAX_DAGS], scheduling_policy_t,
        mem_predictor_t, bool);

// helper methods
void dcache_flush(uint32_t, uint32_t);
void assertf(bool, const char*, ...);
void enable_interrupts();
void disable_interrupts();

#endif /* _SCHEDULER_H_ */
