#ifndef _SCHEDULER_H_
#define _SCHEDULER_H_

#include <assert.h>
#include <limits.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "../defines.h"

#define MAX_ACC_INSTANCES   10
#define MAX_ACC_ARGS        5
#define MAX_CHILDREN        5
#define MAX_DAGS            10
#define MAX_NODES           100

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
    ACC_STATUS_RUNNING
};

enum req_status_t {
    REQ_STATUS_WAITING = 0,
    REQ_STATUS_READY,
    REQ_STATUS_COMPLETED
};

typedef struct task_struct_t task_struct_t;
typedef struct acc_state_t acc_state_t;

struct task_struct_t {
    /**
     * User provides the following fields
     */
    int acc_id;
    void *acc_args;

    int num_children;
    int num_parents;

    task_struct_t *children[MAX_CHILDREN];
    task_struct_t *producer[MAX_ACC_ARGS];

    /**
     * Scheduler sets the following fields
     */
    int producer_forward[MAX_ACC_ARGS]; // bit vector with value set to 1 if
                                        // the corresponding entry in
                                        // arg_producer will forward data

    /**
     * The following fields are for use by the runtime
     */
    int status;
    int earliest_start;
    int deadline;

    int completed_parents;
    uint8_t producer_spm_part[MAX_ACC_ARGS];    // partition of the producer's
                                                // output SPM to read from
    acc_state_t *producer_acc[MAX_ACC_ARGS];    // producer accelerator
};

struct acc_state_t {
    /**
     * Physical address of accelerator registers/memory
     */
    volatile uint8_t *flags;
    uint32_t output_spm[2];

    /**
     * Bookkeeping structures
     */
    uint8_t status;
    task_struct_t *running_req;
    uint8_t curr_spm_part;
    uint8_t spm_pending_reads[2];
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

void init_task_struct(task_struct_t*);

/**
 * Functions for running each accelerator
 */
void run_accelerator(int, int, task_struct_t*, acc_state_t*);
void run_canny_non_max(int, task_struct_t*, acc_state_t*);
void run_convolution(int, task_struct_t*, acc_state_t*);
void run_edge_tracking(int, task_struct_t*, acc_state_t*);
void run_elem_matrix(int, task_struct_t*, acc_state_t*);
void run_grayscale(int, task_struct_t*, acc_state_t*);
void run_harris_non_max(int, task_struct_t*, acc_state_t*);
void run_isp(int, task_struct_t*, acc_state_t*);

/**
 * Functions for copying accelerator outputs
 */
void finish_accelerator(int, int, task_struct_t*, acc_state_t*);
void finish_canny_non_max(int, task_struct_t*, acc_state_t*);
void finish_convolution(int, task_struct_t*, acc_state_t*);
void finish_edge_tracking(int, task_struct_t*, acc_state_t*);
void finish_elem_matrix(int, task_struct_t*, acc_state_t*);
void finish_grayscale(int, task_struct_t*, acc_state_t*);
void finish_harris_non_max(int, task_struct_t*, acc_state_t*);
void finish_isp(int, task_struct_t*, acc_state_t*);

/**
 * Scheduling functions
 */
void set_deadline_phase1(task_struct_t *node, int parent_deadline);
int set_deadline_phase2(task_struct_t *node);

void schedule(task_struct_t *run_queue[NUM_ACCS][MAX_ACC_INSTANCES][MAX_NODES],
        int run_queue_size[NUM_ACCS][MAX_ACC_INSTANCES]);

#endif /* _SCHEDULER_H_ */
