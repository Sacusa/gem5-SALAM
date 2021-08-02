#include "scheduler.h"

int acc_instances[NUM_ACCS] = {
    /* ACC_CANNY_NON_MAX  */ 1,
    /* ACC_CONVOLUTION    */ 2,
    /* ACC_EDGE_TRACKING  */ 1,
    /* ACC_ELEM_MATRIX    */ 4,
    /* ACC_GRAYSCALE      */ 1,
    /* ACC_HARRIS_NON_MAX */ 1,
    /* ACC_ISP            */ 1
};

int acc_mmr_offset[NUM_ACCS] = {
    CNM0_MMR - CNM0_BASE,
    CONVOLUTION0_MMR - CONVOLUTION0_BASE,
    EDGE_TRACKING0_MMR - EDGE_TRACKING0_BASE,
    ELEM_MATRIX0_MMR - ELEM_MATRIX0_BASE,
    GRAYSCALE0_MMR - GRAYSCALE0_BASE,
    HNM0_MMR - HNM0_BASE,
    ISP0_MMR - ISP0_BASE
};

int acc_output_spm_offset[NUM_ACCS][2] = {
    {CNM0_OUTPUT0_SPM - CNM0_BASE, CNM0_OUTPUT1_SPM - CNM0_BASE},
    {CONVOLUTION0_OUTPUT0_SPM - CONVOLUTION0_BASE,
        CONVOLUTION0_OUTPUT1_SPM - CONVOLUTION0_BASE},
    {EDGE_TRACKING0_OUTPUT0_SPM - EDGE_TRACKING0_BASE,
        EDGE_TRACKING0_OUTPUT1_SPM - EDGE_TRACKING0_BASE},
    {ELEM_MATRIX0_OUTPUT0_SPM - ELEM_MATRIX0_BASE,
        ELEM_MATRIX0_OUTPUT1_SPM - ELEM_MATRIX0_BASE},
    {GRAYSCALE0_OUTPUT0_SPM - GRAYSCALE0_BASE,
        GRAYSCALE0_OUTPUT1_SPM - GRAYSCALE0_BASE},
    {HNM0_OUTPUT0_SPM - HNM0_BASE, HNM0_OUTPUT1_SPM - HNM0_BASE},
    {ISP0_OUTPUT0_SPM - ISP0_BASE, ISP0_OUTPUT1_SPM - ISP0_BASE}
};

acc_state_t acc_state[NUM_ACCS][MAX_ACC_INSTANCES];
int device_id[NUM_ACCS][MAX_ACC_INSTANCES];

void init_task_struct(task_struct_t *task_struct)
{
    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        task_struct->producer_forward[i] = 0;
    }

    task_struct->status = REQ_STATUS_WAITING;
    task_struct->completed_parents = 0;
}

/**
 * Functions for running each accelerator
 */

void run_accelerator(int acc_id, int device_id, task_struct_t *req,
        acc_state_t *acc)
{
    // return if there are pending reads from the output partition
    if (acc->spm_pending_reads[acc->curr_spm_part]) {
        printf("%d:%d has %d pending reads\n", acc_id, device_id,
                acc->spm_pending_reads[acc->curr_spm_part]);
    }

    acc->status = ACC_STATUS_RUNNING;
    acc->running_req = req;

    // set the number of pending reads
    for (int c = 0; c < req->num_children; c++) {
        task_struct_t *child = req->children[c];
        for (int a = 0; a < MAX_ACC_ARGS; a++) {
            if (child->producer[a] == req) {
                acc->spm_pending_reads[acc->curr_spm_part]++;
            }
        }
    }

    // accelerator specific parsing and driver code
    switch (acc_id) {
        case ACC_CANNY_NON_MAX:
            run_canny_non_max(device_id, req, acc);
            break;
        case ACC_CONVOLUTION:
            run_convolution(device_id, req, acc);
            break;
        case ACC_EDGE_TRACKING:
            run_edge_tracking(device_id, req, acc);
            break;
        case ACC_ELEM_MATRIX:
            run_elem_matrix(device_id, req, acc);
            break;
        case ACC_GRAYSCALE:
            run_grayscale(device_id, req, acc);
            break;
        case ACC_HARRIS_NON_MAX:
            run_harris_non_max(device_id, req, acc);
            break;
        case ACC_ISP:
            run_isp(device_id, req, acc);
            break;
    }
}

void run_canny_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    uint32_t hypo_addr, theta_addr;

    // check if we need to forward hypotenuse
    if (req->producer_forward[0]) {
        hypo_addr =
            req->producer_acc[0]->output_spm[req->producer_spm_part[0]];
    } else {
        hypo_addr = (uint32_t) args->hypotenuse;
    }

    // check if we need to forward theta
    if (req->producer_forward[1]) {
        theta_addr =
            req->producer_acc[1]->output_spm[req->producer_spm_part[1]];
    } else {
        theta_addr = (uint32_t) args->theta;
    }

    printf("CNM: running driver\n");
    canny_non_max_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, hypo_addr,
            theta_addr, 0, acc->curr_spm_part);

    // reduce pending reads for the hypotenuse producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    // reduce pending reads for the theta producer
    if (req->producer_forward[1]) {
        req->producer_acc[1]->spm_pending_reads[req->producer_spm_part[1]]--;
    }
}

void run_convolution(int device_id, task_struct_t *req, acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    uint32_t input_addr, kernel_addr = (uint32_t) args->kernel;

    // check if we need to forward the input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->output_spm[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    convolution_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr,
            kernel_addr, args->kern_height, args->kern_width,
            args->mod_and_floor, 0, acc->curr_spm_part);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }
}

void run_edge_tracking(int device_id, task_struct_t *req, acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    uint32_t input_addr;

    // check if we need to forward the input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->output_spm[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    edge_tracking_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr,
            args->thr_weak_ratio, args->thr_strong_ratio, 0,
            acc->curr_spm_part);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }
}

void run_elem_matrix(int device_id, task_struct_t *req, acc_state_t *acc)
{
    elem_matrix_args *args = (elem_matrix_args*) req->acc_args;
    uint32_t arg1_addr, arg2_addr;

    // check if we need to forward arg1
    if (req->producer_forward[0]) {
        arg1_addr =
            req->producer_acc[0]->output_spm[req->producer_spm_part[0]];
    } else {
        arg1_addr = (uint32_t) args->arg1;
    }

    // check if we need to forward arg2
    if (req->producer_forward[1]) {
        arg2_addr =
            req->producer_acc[1]->output_spm[req->producer_spm_part[1]];
    } else {
        arg2_addr = (uint32_t) args->arg2;
    }

    elem_matrix_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, arg1_addr,
            arg2_addr, args->is_arg2_scalar, args->op, args->do_one_minus, 0,
            acc->curr_spm_part);

    // reduce pending reads for the arg1 producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    // reduce pending reads for the arg2 producer
    if (req->producer_forward[1]) {
        req->producer_acc[1]->spm_pending_reads[req->producer_spm_part[1]]--;
    }
}

void run_grayscale(int device_id, task_struct_t *req, acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    uint32_t input_addr;

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->output_spm[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    grayscale_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->curr_spm_part);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }
}

void run_harris_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    uint32_t input_addr;

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->output_spm[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    harris_non_max_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->curr_spm_part);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }
}

void run_isp(int device_id, task_struct_t *req, acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    uint32_t input_addr;

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->output_spm[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    isp_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->curr_spm_part);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }
}

/**
 * Functions for copying accelerator outputs
 */

void finish_accelerator(int acc_id, int device_id, task_struct_t *req,
        acc_state_t *acc)
{
    // we need to dump output to memory if even one of the children nodes is
    // not pipelined
    uint8_t perform_mem_write = 0;

    if (!req->num_children) {
        perform_mem_write = 1;
    }

    for (int c = 0; (c < req->num_children) && !perform_mem_write; c++) {
        task_struct_t *child = req->children[c];
        for (int a = 0; a < MAX_ACC_ARGS; a++) {
            if ((child->producer[a] == req) && !child->producer_forward[a]) {
                perform_mem_write = 1;
                break;
            }
        }
    }

    if (perform_mem_write) {
        switch (acc_id) {
            case ACC_CANNY_NON_MAX:
                finish_canny_non_max(device_id, req, acc);
                break;
            case ACC_CONVOLUTION:
                finish_convolution(device_id, req, acc);
                break;
            case ACC_EDGE_TRACKING:
                finish_edge_tracking(device_id, req, acc);
                break;
            case ACC_ELEM_MATRIX:
                finish_elem_matrix(device_id, req, acc);
                break;
            case ACC_GRAYSCALE:
                finish_grayscale(device_id, req, acc);
                break;
            case ACC_HARRIS_NON_MAX:
                finish_harris_non_max(device_id, req, acc);
                break;
            case ACC_ISP:
                finish_isp(device_id, req, acc);
                break;
        }
    }

    *(acc->flags) = 0;
    acc->status = ACC_STATUS_IDLE;
    acc->running_req = NULL;
    acc->curr_spm_part ^= 1;
}

void finish_canny_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    canny_non_max_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0,
            (uint32_t) args->output, acc->curr_spm_part);
}

void finish_convolution(int device_id, task_struct_t *req, acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    convolution_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, acc->curr_spm_part);
}

void finish_edge_tracking(int device_id, task_struct_t *req, acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    edge_tracking_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0,
            (uint32_t) args->output, acc->curr_spm_part);
}

void finish_elem_matrix(int device_id, task_struct_t *req, acc_state_t *acc)
{
    elem_matrix_args *args = (elem_matrix_args*) req->acc_args;
    elem_matrix_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, acc->curr_spm_part);
}

void finish_grayscale(int device_id, task_struct_t *req, acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    grayscale_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->curr_spm_part);
}

void finish_harris_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    harris_non_max_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->curr_spm_part);
}

void finish_isp(int device_id, task_struct_t *req, acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    isp_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->curr_spm_part);
}

/**
 * Scheduling functions
 */

void __attribute__((optimize("O0"))) schedule(
        task_struct_t *run_queue[NUM_ACCS][MAX_ACC_INSTANCES][MAX_NODES],
        int run_queue_size[NUM_ACCS][MAX_ACC_INSTANCES])
{
    int run_queue_index[NUM_ACCS][MAX_ACC_INSTANCES];

    // Initialize structures
    for (int i = 0; i < NUM_ACCS; i++) {
        for (int j = 0; j < acc_instances[i]; j++) {
            uint32_t acc_base = 0x20000000 + ((i+1) << 24) + (j << 20);

            acc_state[i][j].flags = (uint8_t*) (acc_base + acc_mmr_offset[i]);
            acc_state[i][j].output_spm[0] = acc_base +
                acc_output_spm_offset[i][0];
            acc_state[i][j].output_spm[1] = acc_base +
                acc_output_spm_offset[i][1];

            acc_state[i][j].status = ACC_STATUS_IDLE;
            acc_state[i][j].running_req = NULL;
            acc_state[i][j].curr_spm_part = 1;

            run_queue_index[i][j] = 0;
        }
    }

    bool is_exec_complete = false;

    while (1) {
        is_exec_complete = true;

        for (int i = 0; i < NUM_ACCS; i++) {
            for (int j = 0; j < acc_instances[i]; j++) {
                printf("ACC_%d ID_%d=%d/%d\n", i, j, run_queue_index[i][j], run_queue_size[i][j]);
                if (run_queue_index[i][j] == run_queue_size[i][j]) {
                    continue;
                }

                is_exec_complete = false;
                task_struct_t *curr_req =
                    run_queue[i][j][run_queue_index[i][j]];

                // Launch the ready request for this accelerator
                if ((acc_state[i][j].status == ACC_STATUS_IDLE) && \
                    (curr_req->status == REQ_STATUS_READY)) {

                    run_accelerator(i, j, curr_req, &acc_state[i][j]);
                    curr_req->status = REQ_STATUS_COMPLETED;
                    run_queue_index[i][j]++;
                }
            }
        }

        if (is_exec_complete) {
            printf("Execution complete\n");
            break;
        }

        bool exit_loop = false;

        while (!exit_loop) {
            printf("Waiting for an accelerator to finish...\n");
            for (int i = 0; (i < NUM_ACCS) && (!exit_loop); i++) {
                for (int j = 0; j < acc_instances[i]; j++) {

                    if ((*acc_state[i][j].flags & DEV_INTR) == DEV_INTR) {
                        task_struct_t *node = acc_state[i][j].running_req;

                        for (int c = 0; c < node->num_children; c++) {
                            task_struct_t *child = node->children[c];

                            child->completed_parents++;

                            if (child->completed_parents == \
                                child->num_parents) {
                                child->status = REQ_STATUS_READY;

                                // set parent SPM partitions if forwarding data
                                for (int a = 0; a < MAX_ACC_ARGS; a++) {
                                    if ((child->producer[a] == node) &&
                                        child->producer_forward[a]) {
                                        child->producer_spm_part[a] =
                                            acc_state[i][j].curr_spm_part;
                                        child->producer_acc[a] =
                                            &acc_state[i][j];
                                    }
                                }
                            }
                        }

                        finish_accelerator(i, j, node, &acc_state[i][j]);

                        exit_loop = true;
                        break;
                    }

                }
            }
        }
    }
}
