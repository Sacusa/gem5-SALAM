#include "../../common/m5ops.h"
#include "runtime.h"

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

int acc_spm_part_offset[NUM_ACCS][MAX_ACC_SPM_PARTS] = {
    {CNM0_OUTPUT0_SPM - CNM0_BASE, CNM0_OUTPUT1_SPM - CNM0_BASE},
    {CONVOLUTION0_INPUT_SPM - CONVOLUTION0_BASE,
        CONVOLUTION0_OUTPUT0_SPM - CONVOLUTION0_BASE,
        CONVOLUTION0_OUTPUT1_SPM - CONVOLUTION0_BASE},
    {EDGE_TRACKING0_OUTPUT0_SPM - EDGE_TRACKING0_BASE,
        EDGE_TRACKING0_OUTPUT1_SPM - EDGE_TRACKING0_BASE},
    {ELEM_MATRIX0_ARG1_SPM - ELEM_MATRIX0_BASE,
        ELEM_MATRIX0_ARG2_SPM - ELEM_MATRIX0_BASE,
        ELEM_MATRIX0_OUTPUT0_SPM - ELEM_MATRIX0_BASE,
        ELEM_MATRIX0_OUTPUT1_SPM - ELEM_MATRIX0_BASE},
    {GRAYSCALE0_OUTPUT0_SPM - GRAYSCALE0_BASE,
        GRAYSCALE0_OUTPUT1_SPM - GRAYSCALE0_BASE},
    {HNM0_OUTPUT0_SPM - HNM0_BASE, HNM0_OUTPUT1_SPM - HNM0_BASE},
    {ISP0_OUTPUT0_SPM - ISP0_BASE, ISP0_OUTPUT1_SPM - ISP0_BASE}
};

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

int run_accelerator(int acc_id, int device_id, task_struct_t *req,
        acc_state_t *acc)
{
    int retval;

    // accelerator specific parsing and driver code
    switch (acc_id) {
        case ACC_CANNY_NON_MAX:
            retval = run_canny_non_max(device_id, req, acc);
            break;
        case ACC_CONVOLUTION:
            retval = run_convolution(device_id, req, acc);
            break;
        case ACC_EDGE_TRACKING:
            retval = run_edge_tracking(device_id, req, acc);
            break;
        case ACC_ELEM_MATRIX:
            retval = run_elem_matrix(device_id, req, acc);
            break;
        case ACC_GRAYSCALE:
            retval = run_grayscale(device_id, req, acc);
            break;
        case ACC_HARRIS_NON_MAX:
            retval = run_harris_non_max(device_id, req, acc);
            break;
        case ACC_ISP:
            retval = run_isp(device_id, req, acc);
            break;
    }

    if (retval) { return -1; }

    acc->status = ACC_STATUS_RUNNING;
    acc->running_req = req;

    // set the number of pending reads
    for (int c = 0; c < req->num_children; c++) {
        task_struct_t *child = req->children[c];
        for (int a = 0; a < MAX_ACC_ARGS; a++) {
            if ((child->producer[a] == req) && child->producer_forward[a]) {
                acc->spm_pending_reads[acc->curr_spm_out_part]++;
            }
        }
    }

    return 0;
}

int run_canny_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    uint32_t hypo_addr, theta_addr;
    bool has_available_part = false;

    // return if there are no available output partitions
    for (int i = 0; i < 2; i++) {
        if (acc->spm_pending_reads[i] == 0) {
            acc->curr_spm_out_part = i;
            has_available_part = true;
            break;
        }
    }

    if (!has_available_part) { return -1; }

    // check if we need to forward hypotenuse
    if (req->producer_forward[0]) {
        hypo_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        hypo_addr = (uint32_t) args->hypotenuse;
    }

    // check if we need to forward theta
    if (req->producer_forward[1]) {
        theta_addr =
            req->producer_acc[1]->spm_part[req->producer_spm_part[1]];
    } else {
        theta_addr = (uint32_t) args->theta;
    }

    canny_non_max_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, hypo_addr,
            theta_addr, 0, acc->spm_part[acc->curr_spm_out_part]);

    // reduce pending reads for the hypotenuse producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    // reduce pending reads for the theta producer
    if (req->producer_forward[1]) {
        req->producer_acc[1]->spm_pending_reads[req->producer_spm_part[1]]--;
    }

    return 0;
}

int run_convolution(int device_id, task_struct_t *req, acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    uint32_t input_addr = 0, kernel_addr = (uint32_t) args->kernel;
    uint32_t input_spm_addr = 0;
    bool has_available_part = false;

    // check if we need to forward the input
    if (req->producer_forward[0]) {
        if (req->producer_acc[0] == acc) {
            input_spm_addr = acc->spm_part[req->producer_spm_part[0]];
        }
        else {
            input_addr =
                req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
        }
    }
    else {
        input_addr = (uint32_t) args->input;
    }

    // allocate input/output partitions
    for (int i = 0; i < 3; i++) {
        if (acc->spm_pending_reads[i] == 0) {
            if (input_spm_addr == 0) {
                input_spm_addr = acc->spm_part[i];
            }
            else {
                acc->curr_spm_out_part = i;
                has_available_part = true;
                break;
            }
        }
    }

    if (!has_available_part) { return -1; }

    convolution_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr,
            kernel_addr, args->kern_height, args->kern_width,
            args->mod_and_floor, 0, input_spm_addr,
            acc->spm_part[acc->curr_spm_out_part]);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    return 0;
}

int run_edge_tracking(int device_id, task_struct_t *req, acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    uint32_t input_addr;
    bool has_available_part = false;

    // return if there are no available output partitions
    for (int i = 0; i < 2; i++) {
        if (acc->spm_pending_reads[i] == 0) {
            acc->curr_spm_out_part = i;
            has_available_part = true;
            break;
        }
    }

    if (!has_available_part) { return -1; }

    // check if we need to forward the input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    edge_tracking_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr,
            args->thr_weak_ratio, args->thr_strong_ratio, 0,
            acc->spm_part[acc->curr_spm_out_part]);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    return 0;
}

int run_elem_matrix(int device_id, task_struct_t *req, acc_state_t *acc)
{
    elem_matrix_args *args = (elem_matrix_args*) req->acc_args;
    uint32_t arg1_addr = 0, arg2_addr = 0;
    uint32_t arg1_spm_addr = 0, arg2_spm_addr = 0;
    bool has_arg2 = false, has_available_part = false;

    // allocate partition for arg2 only if we need it
    switch (args->op) {
        case ADD:
        case SUB:
        case MUL:
        case DIV:
        case ATAN2: has_arg2 = true;
    }

    // check if we need to forward arg1
    if (req->producer_forward[0]) {
        if (req->producer_acc[0] == acc) {
            arg1_spm_addr = acc->spm_part[req->producer_spm_part[0]];
        }
        else {
            arg1_addr =
                req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
        }
    }
    else {
        arg1_addr = (uint32_t) args->arg1;
    }

    // check if we need to forward arg2
    if (has_arg2) {
        if (req->producer_forward[1]) {
            if (req->producer_acc[1] == acc) {
                arg2_spm_addr = acc->spm_part[req->producer_spm_part[1]];
            }
            else {
                arg2_addr =
                    req->producer_acc[1]->spm_part[req->producer_spm_part[1]];
            }
        }
        else {
            arg2_addr = (uint32_t) args->arg2;
        }
    }

    // allocate input/output partitions
    for (int i = 0; i < 4; i++) {
        if (acc->spm_pending_reads[i] == 0) {
            if (arg1_spm_addr == 0) {
                arg1_spm_addr = acc->spm_part[i];
            }
            else if (has_arg2 && (arg2_spm_addr == 0)) {
                arg2_spm_addr = acc->spm_part[i];
            }
            else {
                acc->curr_spm_out_part = i;
                has_available_part = true;
                break;
            }
        }
    }

    if (!has_available_part) { return -1; }

    elem_matrix_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, arg1_addr,
            arg2_addr, args->is_arg2_scalar, args->op, args->do_one_minus, 0,
            arg1_spm_addr, arg2_spm_addr,
            acc->spm_part[acc->curr_spm_out_part]);

    // reduce pending reads for the arg1 producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    // reduce pending reads for the arg2 producer
    if (req->producer_forward[1]) {
        req->producer_acc[1]->spm_pending_reads[req->producer_spm_part[1]]--;
    }

    return 0;
}

int run_grayscale(int device_id, task_struct_t *req, acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    uint32_t input_addr;
    bool has_available_part = false;

    // return if there are no available output partitions
    for (int i = 0; i < 2; i++) {
        if (acc->spm_pending_reads[i] == 0) {
            acc->curr_spm_out_part = i;
            has_available_part = true;
            break;
        }
    }

    if (!has_available_part) { return -1; }

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    grayscale_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_part[acc->curr_spm_out_part]);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    return 0;
}

int run_harris_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    uint32_t input_addr;
    bool has_available_part = false;

    // return if there are no available output partitions
    for (int i = 0; i < 2; i++) {
        if (acc->spm_pending_reads[i] == 0) {
            acc->curr_spm_out_part = i;
            has_available_part = true;
            break;
        }
    }

    if (!has_available_part) { return -1; }

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    harris_non_max_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_part[acc->curr_spm_out_part]);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    return 0;
}

int run_isp(int device_id, task_struct_t *req, acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    uint32_t input_addr;
    bool has_available_part = false;

    // return if there are no available output partitions
    for (int i = 0; i < 2; i++) {
        if (acc->spm_pending_reads[i] == 0) {
            acc->curr_spm_out_part = i;
            has_available_part = true;
            break;
        }
    }

    if (!has_available_part) { return -1; }

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    isp_driver(device_id, 1, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_part[acc->curr_spm_out_part]);

    // reduce pending reads for the input producer
    if (req->producer_forward[0]) {
        req->producer_acc[0]->spm_pending_reads[req->producer_spm_part[0]]--;
    }

    return 0;
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
}

void finish_canny_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    canny_non_max_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part]);
}

void finish_convolution(int device_id, task_struct_t *req, acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    convolution_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, acc->spm_part[acc->curr_spm_out_part]);
}

void finish_edge_tracking(int device_id, task_struct_t *req, acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    edge_tracking_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part]);
}

void finish_elem_matrix(int device_id, task_struct_t *req, acc_state_t *acc)
{
    elem_matrix_args *args = (elem_matrix_args*) req->acc_args;
    elem_matrix_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, 0,
            acc->spm_part[acc->curr_spm_out_part]);
}

void finish_grayscale(int device_id, task_struct_t *req, acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    grayscale_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part]);
}

void finish_harris_non_max(int device_id, task_struct_t *req, acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    harris_non_max_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part]);
}

void finish_isp(int device_id, task_struct_t *req, acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    isp_driver(device_id, 0, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part]);
}

/**
 * The actual runtime
 */

void runtime(task_struct_t ****run_queue, int **run_queue_size)
{
    acc_state_t acc_state[NUM_ACCS][MAX_ACC_INSTANCES];
    int run_queue_index[NUM_ACCS][MAX_ACC_INSTANCES];

    // Initialize structures
    for (int i = 0; i < NUM_ACCS; i++) {
        for (int j = 0; j < acc_instances[i]; j++) {
            uint32_t acc_base = 0x20000000 + ((i+1) << 24) + (j << 20);

            acc_state[i][j].flags = (uint8_t*) (acc_base + acc_mmr_offset[i]);

            for (int k = 0; k < MAX_ACC_SPM_PARTS; k++) {
                acc_state[i][j].spm_part[k] = acc_base +
                    acc_spm_part_offset[i][k];
            }

            acc_state[i][j].status = ACC_STATUS_IDLE;
            acc_state[i][j].running_req = NULL;
            acc_state[i][j].curr_spm_out_part = 0;

            run_queue_index[i][j] = 0;
        }
    }

    bool is_exec_complete = false;
    int num_running = 0;

    m5_reset_stats();

    while (1) {
        is_exec_complete = true;

        // launch more ready requests
        for (int i = 0; i < NUM_ACCS; i++) {
            for (int j = 0; j < acc_instances[i]; j++) {
                if (acc_state[i][j].status == ACC_STATUS_RUNNING) {
                    is_exec_complete = false;
                }

                if (run_queue_index[i][j] == run_queue_size[i][j]) {
                    continue;
                }

                is_exec_complete = false;
                task_struct_t *curr_req =
                    run_queue[i][j][run_queue_index[i][j]];

                // Launch the ready request for this accelerator
                if ((acc_state[i][j].status == ACC_STATUS_IDLE) && \
                    (curr_req->status == REQ_STATUS_READY)) {
                    if (run_accelerator(i, j, curr_req, &acc_state[i][j])) {
                        continue;
                    }
                    curr_req->status = REQ_STATUS_COMPLETED;
                    run_queue_index[i][j]++;
                    num_running++;
                }
            }
        }

        if (is_exec_complete) {
            break;
        }

        if (num_running == 0) {
            printf("ERROR: unable to launch any more nodes\n");
            return;
        }

        bool exit_loop = false;

        while (!exit_loop) {
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
                            }

                            // set parent SPM partitions if forwarding data
                            for (int a = 0; a < MAX_ACC_ARGS; a++) {
                                if ((child->producer[a] == node) &&
                                    child->producer_forward[a]) {
                                    child->producer_spm_part[a] =
                                        acc_state[i][j].curr_spm_out_part;
                                    child->producer_acc[a] =
                                        &acc_state[i][j];
                                }
                            }
                        }

                        finish_accelerator(i, j, node, &acc_state[i][j]);
                        num_running--;

                        exit_loop = true;
                        break;
                    }

                }
            }
        }
    }

    m5_dump_stats();
}
