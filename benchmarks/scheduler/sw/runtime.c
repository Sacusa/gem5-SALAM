#include "../../common/m5ops.h"
#include "runtime.h"
#include "driver.c"

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

int acc_dma_offset[NUM_ACCS] = {
    CNM0_DMA - CNM0_BASE,
    CONVOLUTION0_DMA - CONVOLUTION0_BASE,
    EDGE_TRACKING0_DMA - EDGE_TRACKING0_BASE,
    ELEM_MATRIX0_DMA - ELEM_MATRIX0_BASE,
    GRAYSCALE0_DMA - GRAYSCALE0_BASE,
    HNM0_DMA - HNM0_BASE,
    ISP0_DMA - ISP0_BASE
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

volatile acc_state_t acc_state[NUM_ACCS][MAX_ACC_INSTANCES];
volatile int num_available_instances[NUM_ACCS];
volatile task_struct_t *ready_queue[NUM_ACCS][MAX_READY_QUEUE_SIZE];
volatile int ready_queue_size[NUM_ACCS];
volatile int ready_queue_start[NUM_ACCS];
volatile int ready_queue_end[NUM_ACCS];
volatile int num_running = 0;
volatile scheduling_policy_t scheduling_policy;

void init_task_struct(task_struct_t *task_struct)
{
    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        task_struct->producer_forward[i] = 0;
    }

    task_struct->status = REQ_STATUS_WAITING;
    task_struct->completed_parents = 0;
}

void assertf(bool cond, const char * format, ...)
{
    if (!cond) {
        va_list args;
        va_start(args, format);
        vprintf(format, args);
        va_end(args);
        m5_exit();
    }
}

void enable_interrupts()
{
    __asm__ ("push {r1}");
    __asm__ ("mrs r1, CPSR");
    __asm__ ("bic r1, r1, #0x80");
    __asm__ ("msr CPSR, r1");
    __asm__ ("pop {r1}");
}

void disable_interrupts()
{
    __asm__ ("push {r1}");
    __asm__ ("mrs r1, CPSR");
    __asm__ ("orr r1, r1, #0x80");
    __asm__ ("msr CPSR, r1");
    __asm__ ("pop {r1}");
}

/**
 * Functions for running each accelerator
 */

void run_canny_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    uint32_t hypo_addr, theta_addr;
    bool has_available_part = false;

    // return if there are no available output partitions
    if (acc->status == ACC_STATUS_IDLE) {
        for (int i = 0; i < 2; i++) {
            if (acc->spm_pending_reads[i] == 0) {
                acc->curr_spm_out_part = i;
                has_available_part = true;
                break;
            }
        }

        if (!has_available_part) { return; }

        // check if we need to forward hypotenuse
        if (req->producer_forward[0]) {
            hypo_addr =
                req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
        } else {
            hypo_addr = (uint32_t) args->hypotenuse;
        }
    }

    if (acc->status == ACC_STATUS_DMA_ARG1) {
        // check if we need to forward theta
        if (req->producer_forward[1]) {
            theta_addr =
                req->producer_acc[1]->spm_part[req->producer_spm_part[1]];
        } else {
            theta_addr = (uint32_t) args->theta;
        }
    }

    canny_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, hypo_addr,
            theta_addr, 0, acc->spm_part[acc->curr_spm_out_part], acc);

    if (acc->status == ACC_STATUS_RUNNING) {
        // reduce pending reads for the hypotenuse producer
        if (req->producer_forward[0]) {
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }

        // reduce pending reads for the theta producer
        if (req->producer_forward[1]) {
            req->producer_acc[1]->spm_pending_reads[
                req->producer_spm_part[1]]--;
        }
    }
}

void run_convolution(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
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

    if (!has_available_part) { return; }

    convolution_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr,
            kernel_addr, args->kern_height, args->kern_width,
            args->mod_and_floor, 0, input_spm_addr,
            acc->spm_part[acc->curr_spm_out_part], acc);

    // reduce pending reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if (req->producer_forward[0]) {
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }
    }
}

void run_edge_tracking(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
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

    if (!has_available_part) { return; }

    // check if we need to forward the input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    edge_tracking_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr,
            args->thr_weak_ratio, args->thr_strong_ratio, 0,
            acc->spm_part[acc->curr_spm_out_part], acc);

    // reduce pending reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if (req->producer_forward[0]) {
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }
    }
}

void run_elem_matrix(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
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

    if (!has_available_part) { return; }

    elem_matrix_driver(device_id, IMG_HEIGHT, IMG_WIDTH, arg1_addr, arg2_addr,
            args->is_arg2_scalar, args->op, args->do_one_minus, 0,
            arg1_spm_addr, arg2_spm_addr,
            acc->spm_part[acc->curr_spm_out_part], acc);

    if (acc->status == ACC_STATUS_RUNNING) {
        // reduce pending reads for the arg1 producer
        if (req->producer_forward[0]) {
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }

        // reduce pending reads for the arg2 producer
        if (req->producer_forward[1]) {
            req->producer_acc[1]->spm_pending_reads[
                req->producer_spm_part[1]]--;
        }
    }
}

void run_grayscale(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
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

    if (!has_available_part) { return; }

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    grayscale_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_part[acc->curr_spm_out_part], acc);

    // reduce pending reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if (req->producer_forward[0]) {
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }
    }
}

void run_harris_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
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

    if (!has_available_part) { return; }

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    harris_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_part[acc->curr_spm_out_part], acc);

    // reduce pending reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if (req->producer_forward[0]) {
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }
    }
}

void run_isp(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
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

    if (!has_available_part) { return; }

    // check if we need to forward input
    if (req->producer_forward[0]) {
        input_addr =
            req->producer_acc[0]->spm_part[req->producer_spm_part[0]];
    } else {
        input_addr = (uint32_t) args->input;
    }

    isp_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_part[acc->curr_spm_out_part], acc);

    // reduce pending reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if (req->producer_forward[0]) {
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }
    }
}

void run_accelerator(int acc_id, int device_id,
        volatile task_struct_t *req)
{
    volatile acc_state_t *acc = &acc_state[acc_id][device_id];

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

    acc->running_req = req;
}

/**
 * Functions for copying accelerator outputs
 */

void finish_canny_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    canny_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

void finish_convolution(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    convolution_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

void finish_edge_tracking(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    edge_tracking_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

void finish_elem_matrix(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    elem_matrix_args *args = (elem_matrix_args*) req->acc_args;
    elem_matrix_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, 0,
            acc->spm_part[acc->curr_spm_out_part], acc);
}

void finish_grayscale(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    grayscale_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

void finish_harris_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    harris_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

void finish_isp(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    isp_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, (uint32_t) args->output,
            acc->spm_part[acc->curr_spm_out_part], acc);
}

void finish_accelerator(int acc_id, int device_id,
        volatile task_struct_t *req, bool perform_mem_write)
{
    volatile acc_state_t *acc = &acc_state[acc_id][device_id];

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
    else {
        acc->status = ACC_STATUS_IDLE;
    }

    *(acc->flags) = 0;
    acc->running_req = NULL;
}

/**
 * The actual runtime
 */

void push_request(task_struct_t *req)
{
    int acc_id = req->acc_id;

    if (ready_queue_size[acc_id] == MAX_READY_QUEUE_SIZE) {
        m5_fail_1();
    }

    ready_queue[acc_id][ready_queue_end[acc_id]] = req;
    ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                              MAX_READY_QUEUE_SIZE;

    ready_queue_size[acc_id]++;

#ifdef DEBUG
    printf("Pushing ready request for acc id %d\n", req->acc_id);
#endif
}

volatile task_struct_t *peek_request(int acc_id)
{
    if (ready_queue_size[acc_id] == 0) { return NULL; }

    return ready_queue[acc_id][ready_queue_start[acc_id]];
}

volatile task_struct_t *pop_request(int acc_id)
{
    volatile task_struct_t *req = peek_request(acc_id);

    if (req != NULL) {
        ready_queue_start[acc_id] = (ready_queue_start[acc_id] + 1) % \
                                    MAX_READY_QUEUE_SIZE;
        ready_queue_size[acc_id]--;
    }

    return req;
}

void launch_requests()
{
    for (int i = 0; i < NUM_ACCS; i++) {
        while ((ready_queue_size[i] > 0) && \
               (num_available_instances[i] > 0)) {
            for (int j = 0; j < acc_instances[i]; j++) {
                if (acc_state[i][j].status == ACC_STATUS_IDLE) {
                    volatile task_struct_t *req = peek_request(i);
                    run_accelerator(i, j, req);

                    if (acc_state[i][j].status == ACC_STATUS_IDLE) {
                        continue;
                    }

                    req = pop_request(i);
                    req->status = REQ_STATUS_COMPLETED;
                    num_running++;
                    num_available_instances[i]--;

                    break;
                }
            }
        }
    }
}

void schedule_fcfs()
{
    /* FCFS does not reorder requests; it just executes requests in the order
     * they become ready, so nothing to do here.
     */
    return;
}

void schedule()
{
    switch (scheduling_policy) {
        case FCFS: schedule_fcfs(); break;
        case GEDF_D:
        case GEDF_N:
        case LAX:
        case ELF: assertf(false, "Policy not implemented");
    }
}

void runtime(task_struct_t ***nodes, int num_dags, int num_nodes[MAX_DAGS],
        scheduling_policy_t policy)
{
#ifdef TIME
    m5_timer_start(0);
#endif

    // Initialize structures
    for (int i = 0; i < NUM_ACCS; i++) {
        for (int j = 0; j < acc_instances[i]; j++) {
            uint32_t acc_base = 0x20000000 + ((i+1) << 24) + (j << 20);

            acc_state[i][j].flags = (uint8_t*) (acc_base + acc_mmr_offset[i]);
            acc_state[i][j].dma = (uint8_t*) (acc_base + acc_dma_offset[i]);

            for (int k = 0; k < MAX_ACC_SPM_PARTS; k++) {
                acc_state[i][j].spm_part[k] = acc_base +
                    acc_spm_part_offset[i][k];
            }

            acc_state[i][j].status = ACC_STATUS_IDLE;
            acc_state[i][j].running_req = NULL;
            acc_state[i][j].curr_spm_out_part = 0;
        }

        ready_queue_size[i] = 0;
        ready_queue_start[i] = 0;
        ready_queue_end[i] = 0;

        num_available_instances[i] = acc_instances[i];
    }

    scheduling_policy = policy;

    for (int i = 0; i < num_dags; i++) {
        for (int j = 0; j < num_nodes[i]; j++) {
            if (nodes[i][j]->num_parents == 0) {
                push_request(nodes[i][j]);
            }
        }
    }

#ifdef TIME
    m5_timer_stop(0);
#endif

    m5_reset_stats();

#ifdef TIME
    m5_timer_start(0);
#endif

    schedule();

    // launch ready requests
    disable_interrupts();
    launch_requests(nodes);
    enable_interrupts();

    while (num_running);

#ifdef TIME
    m5_timer_stop(0);
#endif

    m5_dump_stats();
}

void isr(int i, int j)  // i = accelerator id, j = device id
{
    if ((acc_state[i][j].status == ACC_STATUS_DMA_ARG1) ||
        (acc_state[i][j].status == ACC_STATUS_DMA_ARG2)) {
        *acc_state[i][j].dma = 0;
        run_accelerator(i, j, acc_state[i][j].running_req);
    }

    else if (acc_state[i][j].status == ACC_STATUS_RUNNING) {
        *acc_state[i][j].flags = 0;

        volatile task_struct_t *node = acc_state[i][j].running_req;

        for (int c = 0; c < node->num_children; c++) {
            task_struct_t *child = node->children[c];

            child->completed_parents++;

            if (child->completed_parents == child->num_parents) {
                child->status = REQ_STATUS_READY;
                push_request(child);
            }
        }

        num_available_instances[i]++;
        schedule();

        int node_spm_out_part = acc_state[i][j].curr_spm_out_part;
        int num_forwards = 0;

        for (int c = 0; c < node->num_children; c++) {
            task_struct_t *child = node->children[c];

            int ready_queue_index = ready_queue_start[child->acc_id];

            for (int n = 0; n < num_available_instances[child->acc_id]; n++) {
                if (ready_queue[child->acc_id][ready_queue_index] == child) {
                    // The child node is among the next set of nodes to be
                    // scheduled, so update its metadata to receive data
                    // from the producer
                    for (int a = 0; a < MAX_ACC_ARGS; a++) {
                        if (child->producer[a] == node) {
                            child->producer_forward[a] = 1;
                            child->producer_acc[a] = &acc_state[i][j];
                            child->producer_spm_part[a] = node_spm_out_part;

                            break;
                        }
                    }

                    num_forwards++;
                    break;
                }

                ready_queue_index = (ready_queue_index + 1) % \
                                    MAX_READY_QUEUE_SIZE;
            }
        }

#ifdef DEBUG
        printf("ISR: number of forwards = %d\n", num_forwards);
#endif

        bool write_out_to_mem = num_forwards != node->num_children;
        finish_accelerator(i, j, node, write_out_to_mem);
        acc_state[i][j].spm_pending_reads[node_spm_out_part] = num_forwards;

        if (!write_out_to_mem) {
            num_running--;
        }
    }

    else if (acc_state[i][j].status == ACC_STATUS_DMA_OUT) {
        *acc_state[i][j].dma = 0;
        acc_state[i][j].status = ACC_STATUS_IDLE;

        num_running--;
    }

    else {
        printf("ERROR: interrupt raised by an inactive accelerator."
                " ACC_ID=%d, DEV_ID=%d\n", i, j);
        m5_exit();
    }

    launch_requests();
}

void data_abort_handler(uint32_t pc)
{
    printf("Data abort caused by instruction at pc: %x\n", pc);
    m5_exit();
}
