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

#define MAX_ACC_INSTANCES   10
#define MAX_ACC_ARGS        5
#define MAX_ACC_SPM_PARTS   5
#define MAX_CHILDREN        50
#define MAX_DAGS            50
#define MAX_NODES           500
#define MAX_READY_QUEUE_SIZE 500
//#define VERIFY

/* Enable gem5 timers for the following functions:
 * Timer 0: push_request()
 * Timer 1: sort_requests()
 * Timer 2: update_mem_time_predictor()
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
    LAX,
    ELF
};

enum mem_predictor_t {
    MEM_PRED_LAST_VAL = 0,
    MEM_PRED_AVERAGE,
    MEM_PRED_EWMA
};

/**
 * Structures for statistics
 */
enum m5_stat_t {
    DEGREE_OF_PARALLELISM = 0,
    DAG_DEADLINES_MET,
    NODE_DEADLINES_MET,
    PREDICTED_RUNTIME
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

    uint32_t input_size;
    uint32_t output_size;
    uint32_t compute_time;
    uint32_t runtime;
    uint32_t dag_deadline;
    uint32_t node_deadline;

    /**
     * Scheduler sets the following fields
     */
    uint8_t producer_forward[MAX_ACC_ARGS]; // bit vector with value set to 1
                                            // if the corresponding entry in
                                            // arg_producer will forward data

    /**
     * The following fields are for use by the runtime
     */
    req_status_t status;
    uint32_t orig_node_deadline;
    uint32_t laxity;
    bool laxity_initialized;

    uint16_t completed_parents;
    uint8_t producer_spm_part[MAX_ACC_ARGS];    // partition of the producer's
                                                // output SPM to read from
    volatile acc_state_t *producer_acc[MAX_ACC_ARGS];   // producer accelerator
};

struct acc_state_t {
    /**
     * Physical address of accelerator registers/memory
     */
    volatile uint8_t *flags;
    volatile uint8_t *dma;
    uint32_t spm_part[MAX_ACC_SPM_PARTS];

    /**
     * Bookkeeping structures
     */
    uint8_t status;
    volatile task_struct_t *running_req;
    uint8_t curr_spm_out_part;
    uint8_t spm_pending_reads[MAX_ACC_SPM_PARTS];
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
void runtime(task_struct_t ***, int, int [MAX_DAGS], scheduling_policy_t);

// helper methods
void assertf(bool, const char*, ...);
void enable_interrupts();
void disable_interrupts();

#endif /* _SCHEDULER_H_ */
