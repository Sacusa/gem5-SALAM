#include "../../common/m5ops.h"
#include "runtime.h"
#include "driver.c"

#define min(a,b) ((a) < (b) ? (a) : (b))

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
volatile mem_predictor_t mem_predictor;
volatile uint32_t runtime_start_time;

float mem_prediction = 0;

// Structures for statistics
volatile uint32_t stat_num_forwards = 0;
volatile uint32_t stat_num_colocations = 0;
volatile uint32_t stat_dag_deadlines_met = 0;
volatile uint32_t stat_node_deadlines_met = 0;
volatile float stat_predicted_compute_time = 0;

inline void init_task_struct(task_struct_t *task_struct)
{
    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        task_struct->producer_forward[i] = 0;
    }

    task_struct->status = REQ_STATUS_WAITING;
    task_struct->completed_parents = 0;
}

inline void assertf(bool cond, const char * format, ...)
{
    if (!cond) {
        va_list args;
        va_start(args, format);
        vprintf(format, args);
        va_end(args);
        m5_exit();
    }
}

inline void enable_interrupts()
{
    __asm__ ("push {r1}");
    __asm__ ("mrs r1, CPSR");
    __asm__ ("bic r1, r1, #0x80");
    __asm__ ("msr CPSR, r1");
    __asm__ ("pop {r1}");
}

inline void disable_interrupts()
{
    __asm__ ("push {r1}");
    __asm__ ("mrs r1, CPSR");
    __asm__ ("orr r1, r1, #0x80");
    __asm__ ("msr CPSR, r1");
    __asm__ ("pop {r1}");
}

/**
 * Predictors
 */

// Last value predictor
inline void update_last_val_predictor(uint32_t time, uint32_t size)
{
    mem_prediction = ((float)time / 1000) / size;
}

// Average predictor
#define MAX_MEM_HIST_SIZE 20
float mem_hist[MAX_MEM_HIST_SIZE];
uint8_t mem_hist_size = 0;
uint8_t mem_hist_pos = 0;

inline void update_average_predictor(uint32_t time, uint32_t size)
{
    float mem_time_per_byte = ((float)time / 1000) / size;

    mem_hist[mem_hist_pos] = mem_time_per_byte;
    mem_hist_size = min(MAX_MEM_HIST_SIZE, mem_hist_size + 1);
    mem_hist_pos = (mem_hist_pos + 1) % MAX_MEM_HIST_SIZE;

    double product = 1;
    for (int i = 0; i < mem_hist_size; i++) {
        product *= mem_hist[i];
    }

    mem_prediction = pow(product, 1.0 / mem_hist_size);
}

// EWMA predictor
const float alpha = 0.25;
bool is_first_observation = true;

inline void update_ewma_predictor(uint32_t time, uint32_t size)
{
    float mem_time_per_byte = ((float)time / 1000) / size;

    if (is_first_observation) {
        mem_prediction = mem_time_per_byte;
        is_first_observation = false;
    }
    else {
        mem_prediction = (alpha * mem_time_per_byte) + \
                         ((1 - alpha) * mem_prediction);
    }
}

inline void update_mem_time_predictor(uint32_t time, uint32_t size)
{
    // The size here is fairly random. We just want to avoid recording time
    // for convolution filter DMA transfers because they tend to be skewed.
    if (size < 512) { return; }

#ifdef ENABLE_STATS
    m5_timer_start(1);
#endif

    switch (mem_predictor) {
        case MEM_PRED_LAST_VAL: update_last_val_predictor(time, size); break;
        case MEM_PRED_AVERAGE: update_average_predictor(time, size); break;
        case MEM_PRED_EWMA: update_ewma_predictor(time, size); break;
        default:
            printf("Invalid memory time predictor selected.\n");
            m5_exit(0);
    }

#ifdef ENABLE_STATS
    m5_timer_stop(1);
#endif
}

inline float get_compute_time(volatile task_struct_t *node)
{
    return node->compute_time;
}

inline float get_memory_time(volatile task_struct_t *node)
{
    return ((node->input_size + node->output_size) * mem_prediction);
}

inline float get_runtime(volatile task_struct_t *node)
{
    return (get_compute_time(node) + get_memory_time(node));
}

/**
 * Functions for running each accelerator
 */

inline void run_canny_non_max(int device_id, volatile task_struct_t *req,
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

#ifdef ENABLE_STATS
    if (acc->status == ACC_STATUS_IDLE) {
        req->stat_mem_time_per_byte_launch = mem_prediction;
        req->stat_mem_time_launch = get_memory_time(req);
    }
#endif

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

inline void run_convolution(int device_id, volatile task_struct_t *req,
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

#ifdef ENABLE_STATS
    if (acc->status == ACC_STATUS_IDLE) {
        req->stat_mem_time_per_byte_launch = mem_prediction;
        req->stat_mem_time_launch = 0;

        if (input_spm_addr == 0) {
            req->stat_mem_time_launch += (IMG_HEIGHT * IMG_WIDTH * 4) * \
                                         mem_prediction;
        }

        req->stat_mem_time_launch += \
                ((args->kern_height * args->kern_width * 4) + \
                 req->output_size) * mem_prediction;
    }
#endif

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
#ifdef ENABLE_STATS
            if (req->producer_acc[0] == acc) {
                stat_num_colocations++;
            }
#endif
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }
    }
}

inline void run_edge_tracking(int device_id, volatile task_struct_t *req,
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

#ifdef ENABLE_STATS
    if (acc->status == ACC_STATUS_IDLE) {
        req->stat_mem_time_per_byte_launch = mem_prediction;
        req->stat_mem_time_launch = get_memory_time(req);
    }
#endif

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

inline void run_elem_matrix(int device_id, volatile task_struct_t *req,
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

#ifdef ENABLE_STATS
    if (acc->status == ACC_STATUS_IDLE) {
        req->stat_mem_time_per_byte_launch = mem_prediction;
        req->stat_mem_time_launch = 0;

        if (arg1_spm_addr == 0) {
            req->stat_mem_time_launch += (IMG_HEIGHT * IMG_WIDTH * 4) * \
                                         mem_prediction;
        }

        if (arg2_spm_addr == 0) {
            if (args->is_arg2_scalar) {
                req->stat_mem_time_launch += 4 * mem_prediction;
            } else {
                req->stat_mem_time_launch += (IMG_HEIGHT * IMG_WIDTH * 4) * \
                                             mem_prediction;
            }
        }

        req->stat_mem_time_launch += req->output_size * mem_prediction;
    }
#endif

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
#ifdef ENABLE_STATS
            if (req->producer_acc[0] == acc) {
                stat_num_colocations++;
            }
#endif
            req->producer_acc[0]->spm_pending_reads[
                req->producer_spm_part[0]]--;
        }

        // reduce pending reads for the arg2 producer
        if (req->producer_forward[1]) {
#ifdef ENABLE_STATS
            if (req->producer_acc[1] == acc) {
                stat_num_colocations++;
            }
#endif
            req->producer_acc[1]->spm_pending_reads[
                req->producer_spm_part[1]]--;
        }
    }
}

inline void run_grayscale(int device_id, volatile task_struct_t *req,
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

#ifdef ENABLE_STATS
    if (acc->status == ACC_STATUS_IDLE) {
        req->stat_mem_time_per_byte_launch = mem_prediction;
        req->stat_mem_time_launch = get_memory_time(req);
    }
#endif

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

inline void run_harris_non_max(int device_id, volatile task_struct_t *req,
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

#ifdef ENABLE_STATS
    if (acc->status == ACC_STATUS_IDLE) {
        req->stat_mem_time_per_byte_launch = mem_prediction;
        req->stat_mem_time_launch = get_memory_time(req);
    }
#endif

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

inline void run_isp(int device_id, volatile task_struct_t *req,
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

#ifdef ENABLE_STATS
    if (acc->status == ACC_STATUS_IDLE) {
        req->stat_mem_time_per_byte_launch = mem_prediction;
        req->stat_mem_time_launch = get_memory_time(req);
    }
#endif

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

inline void run_accelerator(int acc_id, int device_id,
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

inline void finish_canny_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    canny_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

inline void finish_convolution(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    convolution_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

inline void finish_edge_tracking(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    edge_tracking_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

inline void finish_elem_matrix(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    elem_matrix_args *args = (elem_matrix_args*) req->acc_args;
    elem_matrix_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, 0,
            acc->spm_part[acc->curr_spm_out_part], acc);
}

inline void finish_grayscale(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    grayscale_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

inline void finish_harris_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    harris_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_part[acc->curr_spm_out_part],
            acc);
}

inline void finish_isp(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    isp_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, (uint32_t) args->output,
            acc->spm_part[acc->curr_spm_out_part], acc);
}

inline void finish_accelerator(int acc_id, int device_id,
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
}

/**
 * The actual runtime
 */

inline bool push_request(volatile task_struct_t *req, bool try_forward)
{
#ifdef ENABLE_STATS
    m5_timer_start(0);
#endif

    int acc_id = req->acc_id;
    bool can_forward = try_forward;
    req->priority_escalated = false;

    if (ready_queue_size[acc_id] == MAX_READY_QUEUE_SIZE) {
        m5_fail_1();
    }

    switch (scheduling_policy) {
        case FCFS: {
            ready_queue[acc_id][ready_queue_end[acc_id]] = req;
            ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                      MAX_READY_QUEUE_SIZE;
            break;
        }

        case GEDF_D: {
            if (ready_queue_size[acc_id] == 0) {
                ready_queue[acc_id][ready_queue_end[acc_id]] = req;
                ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                          MAX_READY_QUEUE_SIZE;
            }
            else {
                int pos = ready_queue_end[acc_id];
                int pos_minus_1 = pos - 1;
                if (pos_minus_1 == -1) {pos_minus_1 = MAX_READY_QUEUE_SIZE-1;}

                while ((pos != ready_queue_start[acc_id]) && \
                       (ready_queue[acc_id][pos_minus_1]->dag_deadline > \
                        req->dag_deadline)) {
                    ready_queue[acc_id][pos] =
                        ready_queue[acc_id][pos_minus_1];
                    pos = pos_minus_1;
                    pos_minus_1 = pos - 1;
                    if (pos_minus_1 == -1) {
                        pos_minus_1 = MAX_READY_QUEUE_SIZE - 1;
                    }
                }

                ready_queue[acc_id][pos] = req;
                ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                          MAX_READY_QUEUE_SIZE;
            }

            break;
        }

        case GEDF_N: {
            if (ready_queue_size[acc_id] == 0) {
                ready_queue[acc_id][ready_queue_end[acc_id]] = req;
                ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                          MAX_READY_QUEUE_SIZE;
            }
            else {
                int pos = ready_queue_end[acc_id];
                int pos_minus_1 = pos - 1;
                if (pos_minus_1 == -1) {pos_minus_1 = MAX_READY_QUEUE_SIZE-1;}

                while ((pos != ready_queue_start[acc_id]) && \
                       (ready_queue[acc_id][pos_minus_1]->node_deadline > \
                        req->node_deadline)) {
                    ready_queue[acc_id][pos] =
                        ready_queue[acc_id][pos_minus_1];
                    pos = pos_minus_1;
                    pos_minus_1 = pos - 1;
                    if (pos_minus_1 == -1) {
                        pos_minus_1 = MAX_READY_QUEUE_SIZE - 1;
                    }
                }

                ready_queue[acc_id][pos] = req;
                ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                          MAX_READY_QUEUE_SIZE;
            }

            break;
        }

        case LAX: {
#ifdef ENABLE_STATS
            float compute_time = get_compute_time(req);
            float memory_time = get_memory_time(req);

            req->runtime = compute_time + memory_time;

            req->stat_mem_time_per_byte_insertion = mem_prediction;
            req->stat_mem_time_insertion = memory_time;

            stat_predicted_compute_time += compute_time;
#else
            req->runtime = get_runtime(req);
#endif

            req->laxity = req->node_deadline + runtime_start_time - \
                          req->runtime;

            if ((req->laxity - (m5_get_time() / 1000)) <= 0) {
                // De-prioritize a node if its laxity is negative. That is,
                // the node is unlikely to finish before its deadline.
                req->laxity = 0x7fffffff;

                ready_queue[acc_id][ready_queue_end[acc_id]] = req;
                ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                          MAX_READY_QUEUE_SIZE;
            }

            else {
                if (ready_queue_size[acc_id] == 0) {
                    ready_queue[acc_id][ready_queue_end[acc_id]] = req;
                    ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                              MAX_READY_QUEUE_SIZE;
                }
                else {
                    int pos = ready_queue_end[acc_id];
                    int pos_minus_1 = pos - 1;
                    if (pos_minus_1 == -1) {
                        pos_minus_1 = MAX_READY_QUEUE_SIZE - 1;
                    }

                    while ((pos != ready_queue_start[acc_id]) && \
                           (ready_queue[acc_id][pos_minus_1]->laxity > \
                            req->laxity)) {
                        ready_queue[acc_id][pos] =
                            ready_queue[acc_id][pos_minus_1];
                        pos = pos_minus_1;
                        pos_minus_1 = pos - 1;
                        if (pos_minus_1 == -1) {
                            pos_minus_1 = MAX_READY_QUEUE_SIZE - 1;
                        }
                    }

                    ready_queue[acc_id][pos] = req;
                    ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                              MAX_READY_QUEUE_SIZE;
                }
            }

            break;
        }

        case ELF: {
            if ((req->laxity - (m5_get_time() / 1000)) <= 0) {
                // De-prioritize a node if its laxity is negative. That is,
                // the node is unlikely to finish before its deadline.
                req->laxity = 0x7fffffff;

                ready_queue[acc_id][ready_queue_end[acc_id]] = req;
                ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                          MAX_READY_QUEUE_SIZE;
            }

            else {
                int pos = ready_queue_end[acc_id];
                int pos_minus_1 = pos - 1;

                if (pos_minus_1 == -1) {
                    pos_minus_1 = MAX_READY_QUEUE_SIZE - 1;
                }

                // Find the regular insertion position
                while ((pos != ready_queue_start[acc_id]) && \
                       (ready_queue[acc_id][pos_minus_1]->laxity > \
                        req->laxity)) {
                    pos = pos_minus_1;
                    pos_minus_1 = pos - 1;
                    if (pos_minus_1 == -1) {
                        pos_minus_1 = MAX_READY_QUEUE_SIZE - 1;
                    }
                }

                if (try_forward) {
                    for (int i = ready_queue_start[acc_id]; i != pos;
                            i = (i + 1) % MAX_READY_QUEUE_SIZE) {
                        int32_t laxity = ready_queue[acc_id][i]->laxity - \
                                         (m5_get_time() / 1000);

                        if (laxity > 0) {
                            can_forward = laxity >= ((int32_t)req->runtime);
                            break;
                        }
                    }
                }

                if (can_forward) {
                    int fwd_pos = ready_queue_start[acc_id];

                    // Reduce node laxities
                    for (int i = ready_queue_start[acc_id]; i != pos;
                         i = (i + 1) % MAX_READY_QUEUE_SIZE) {
                        ready_queue[acc_id][i]->laxity -= req->runtime;

                        if (ready_queue[acc_id][i]->priority_escalated) {
                            fwd_pos = (fwd_pos + 1) % MAX_READY_QUEUE_SIZE;
                        }
                    }

                    pos = fwd_pos;
                }

                // Perform sorted insertion into ready queue
                if (pos == ready_queue_start[acc_id]) {
                    ready_queue_start[acc_id] = (ready_queue_start[acc_id]==0) ? \
                                                (MAX_READY_QUEUE_SIZE - 1) : \
                                                (ready_queue_start[acc_id]-1);
                    ready_queue[acc_id][ready_queue_start[acc_id]] = req;
                }
                else {
                    if (pos != ready_queue_end[acc_id]) {
                        int i = ready_queue_end[acc_id];
                        while (i != pos) {
                            int j = i - 1;
                            if (j == -1) { j = MAX_READY_QUEUE_SIZE - 1; }
                            ready_queue[acc_id][i] = ready_queue[acc_id][j];
                            i = j;
                        }
                    }

                    ready_queue[acc_id][pos] = req;
                    ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                              MAX_READY_QUEUE_SIZE;
                }

                req->priority_escalated = can_forward;
            }
        }
    }

    ready_queue_size[acc_id]++;

#ifdef ENABLE_STATS
    m5_timer_stop(0);
#endif

    return can_forward;
}

inline volatile task_struct_t *peek_request(int acc_id)
{
    if (ready_queue_size[acc_id] == 0) { return NULL; }

    return ready_queue[acc_id][ready_queue_start[acc_id]];
}

inline volatile task_struct_t *pop_request(int acc_id)
{
    volatile task_struct_t *req = peek_request(acc_id);

    if (req != NULL) {
        ready_queue_start[acc_id] = (ready_queue_start[acc_id] + 1) % \
                                    MAX_READY_QUEUE_SIZE;
        ready_queue_size[acc_id]--;
    }

    return req;
}

inline void launch_requests()
{
    for (int i = 0; i < NUM_ACCS; i++) {
        while ((ready_queue_size[i] > 0) && \
               (num_available_instances[i] > 0)) {

            // This flag helps break out of the while loop if none of the
            // available instances are able to serve the next ready request.
            //
            // This can happen for two reasons:
            // 1) All instances are waiting for scratchpad resources.
            // 2) The only available instances is writing out its results to
            //    the main memory.
            bool unable_to_launch = true;

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

                    unable_to_launch = false;

#ifdef PRINT_SCHEDULE
                    m5_print_stat(PREDICTED_COMPUTE_TIME, req->dag_id);
                    m5_print_stat(PREDICTED_MEMORY_TIME, req->node_id);
                    m5_print_stat(NUM_FORWARDS, i);
                    m5_print_stat(NUM_COLOCATIONS, j);
#endif
                    break;
                }
            }

            if (unable_to_launch) {
                break;
            }
        }
    }
}

void runtime(task_struct_t ***nodes, int num_dags, int num_nodes[MAX_DAGS],
        scheduling_policy_t policy, mem_predictor_t predictor)
{
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
    mem_predictor = predictor;
    runtime_start_time = m5_get_time() / 1000;

    for (int i = 0; i < num_dags; i++) {
        for (int j = 0; j < num_nodes[i]; j++) {
            nodes[i][j]->dag_id = i;
            nodes[i][j]->node_id = j;

            if (nodes[i][j]->num_parents == 0) {
                push_request(nodes[i][j], false);
            }
        }
    }

    runtime_start_time = m5_get_time() / 1000;
    m5_reset_stats();

    // launch ready requests
    disable_interrupts();
    launch_requests();

#ifdef ENABLE_STATS
    m5_print_stat(DEGREE_OF_PARALLELISM, num_running);
#endif

    enable_interrupts();

    while (num_running) {
        // Put the thread to sleep until interrupted
        m5_quiesce();
    }

#ifdef ENABLE_STATS
    m5_print_stat(NUM_FORWARDS, stat_num_forwards);
    m5_print_stat(NUM_COLOCATIONS, stat_num_colocations);
    m5_print_stat(DAG_DEADLINES_MET, stat_dag_deadlines_met);
    m5_print_stat(NODE_DEADLINES_MET, stat_node_deadlines_met);
    m5_print_stat(PREDICTED_COMPUTE_TIME,
            (uint32_t)stat_predicted_compute_time);
#endif

    m5_dump_stats();
}

void isr(int i, int j)  // i = accelerator id, j = device id
{
    if ((acc_state[i][j].status == ACC_STATUS_DMA_ARG1) ||
        (acc_state[i][j].status == ACC_STATUS_DMA_ARG2)) {
        switch (scheduling_policy) {
            case LAX:
            case ELF: {
                uint32_t time = m5_get_time() - dma_start_time[i][j];
                update_mem_time_predictor(time, dma_size[i][j]);

                if (dma_size[i][j] > 512) {
                    volatile task_struct_t *req = acc_state[i][j].running_req;
                    float mem_time_per_byte = ((float)time / 1000) / \
                                              dma_size[i][j];

                    if (req->stat_mem_time_per_byte_truth_load == 0) {
                        req->stat_mem_time_per_byte_truth_load = \
                                mem_time_per_byte;
                    } else {
                        req->stat_mem_time_per_byte_truth_load = \
                                (mem_time_per_byte + \
                                 req->stat_mem_time_per_byte_truth_load) / 2;
                    }

                    req->stat_mem_time_truth_load += time / 1000;
                }
            }
        }

        *acc_state[i][j].dma = 0;
        run_accelerator(i, j, acc_state[i][j].running_req);
    }

    else if (acc_state[i][j].status == ACC_STATUS_RUNNING) {
        *acc_state[i][j].flags = 0;

        volatile task_struct_t *node = acc_state[i][j].running_req;

        volatile task_struct_t *pipeline_queue[MAX_CHILDREN];
        int pipeline_queue_size = 0;

        for (int c = 0; c < node->num_children; c++) {
            task_struct_t *child = node->children[c];

            child->completed_parents++;

            if (child->completed_parents == child->num_parents) {
                child->status = REQ_STATUS_READY;

#ifdef ENABLE_STATS
                child->stat_mem_time_per_byte_truth_load = 0;
                child->stat_mem_time_truth_load = 0;

                child->stat_mem_time_per_byte_truth_store = 0;
                child->stat_mem_time_truth_store = 0;
#endif

                if (scheduling_policy == ELF) {
#ifdef ENABLE_STATS
                    m5_timer_start(2);
#endif
                    float compute_time = get_compute_time(child);
                    float memory_time = get_memory_time(child);

                    child->runtime = compute_time + memory_time;

#ifdef ENABLE_STATS
                    child->stat_mem_time_per_byte_insertion = mem_prediction;
                    child->stat_mem_time_insertion = memory_time;

                    stat_predicted_compute_time += compute_time;
#endif

                    child->laxity = child->node_deadline + \
                                    runtime_start_time - child->runtime;

                    if (pipeline_queue_size == 0) {
                        pipeline_queue[0] = child;
                        pipeline_queue_size = 1;
                    }
                    else {
                        int pos = pipeline_queue_size;

                        while ((pos > 0) && (pipeline_queue[pos-1]->laxity > \
                                    child->laxity)) {
                            pipeline_queue[pos] = pipeline_queue[pos-1];
                            pos--;
                        }

                        pipeline_queue[pos] = child;
                        pipeline_queue_size++;
                    }

#ifdef ENABLE_STATS
                    m5_timer_stop(2);
#endif
                }

                else {
                    push_request(child, false);
                }
            }
        }

        num_available_instances[i]++;

        if (scheduling_policy == ELF) {
            int num_forwards[NUM_ACCS] = {0, 0, 0, 0, 0, 0, 0};

            for (int n = 0; n < pipeline_queue_size; n++) {
                uint8_t acc_id = pipeline_queue[n]->acc_id;

                bool is_forwarded = push_request(pipeline_queue[n],
                        num_forwards[acc_id]<num_available_instances[acc_id]);

                if (is_forwarded) {
                    num_forwards[acc_id]++;
                }
            }
        }

        int node_spm_out_part = acc_state[i][j].curr_spm_out_part;
        int num_forwards = 0;

        for (int c = 0; c < node->num_children; c++) {
            task_struct_t *child = node->children[c];

            if (child->status != REQ_STATUS_READY) { continue; }

            int ready_queue_index = ready_queue_start[child->acc_id];

            for (int n = 0; (n < num_available_instances[child->acc_id]) && \
                    (ready_queue_index != ready_queue_end[child->acc_id]);
                    n++) {
                if ((ready_queue[child->acc_id][ready_queue_index] == child) \
                        || child->priority_escalated) {
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

#ifdef ENABLE_STATS
        stat_num_forwards += num_forwards;
#endif

        bool write_out_to_mem = (node->num_children == 0) || \
                                (num_forwards != node->num_children);
        finish_accelerator(i, j, node, write_out_to_mem);
        acc_state[i][j].spm_pending_reads[node_spm_out_part] = num_forwards;

        if (write_out_to_mem) {
            num_available_instances[i]--;
        }
        else {
#ifdef ENABLE_STATS
            uint32_t curr_time = (m5_get_time() / 1000) - runtime_start_time;

            if (curr_time <= node->node_deadline) {
                stat_node_deadlines_met++;
            }

            volatile task_struct_t *req = acc_state[i][j].running_req;

            m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                    *((uint32_t*)(&req->stat_mem_time_per_byte_insertion)));
            m5_print_stat(PREDICTED_MEMORY_TIME,
                    *((uint32_t*)(&req->stat_mem_time_insertion)));

            m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                    *((uint32_t*)(&req->stat_mem_time_per_byte_launch)));
            m5_print_stat(PREDICTED_MEMORY_TIME,
                    *((uint32_t*)(&req->stat_mem_time_launch)));

            m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                    *((uint32_t*)(&req->stat_mem_time_per_byte_truth_load)));
            m5_print_stat(PREDICTED_MEMORY_TIME,
                    *((uint32_t*)(&req->stat_mem_time_truth_load)));

            m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                    *((uint32_t*)(&req->stat_mem_time_per_byte_truth_store)));
            m5_print_stat(PREDICTED_MEMORY_TIME,
                    *((uint32_t*)(&req->stat_mem_time_truth_store)));
#endif

            acc_state[i][j].running_req = NULL;
            num_running--;
        }

#ifdef SCALE_EXPERIMENT
        num_running = 0;
        return;
#endif
    }

    else if (acc_state[i][j].status == ACC_STATUS_DMA_OUT) {
        switch (scheduling_policy) {
            case LAX:
            case ELF: {
                uint32_t time = m5_get_time() - dma_start_time[i][j];
                update_mem_time_predictor(time, dma_size[i][j]);

                volatile task_struct_t *req = acc_state[i][j].running_req;

                req->stat_mem_time_per_byte_truth_store = \
                        ((float)time / 1000) / dma_size[i][j];
                req->stat_mem_time_truth_store = time / 1000;
            }
        }

        *acc_state[i][j].dma = 0;
        acc_state[i][j].status = ACC_STATUS_IDLE;

#ifdef ENABLE_STATS
        volatile task_struct_t *node = acc_state[i][j].running_req;
        uint32_t curr_time = (m5_get_time() / 1000) - runtime_start_time;

        if ((node->num_children == 0) && (curr_time <= node->dag_deadline)) {
            stat_dag_deadlines_met++;
        }

        if (curr_time <= node->node_deadline) {
            stat_node_deadlines_met++;
        }

        volatile task_struct_t *req = acc_state[i][j].running_req;

        m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                *((uint32_t*)(&req->stat_mem_time_per_byte_insertion)));
        m5_print_stat(PREDICTED_MEMORY_TIME,
                *((uint32_t*)(&req->stat_mem_time_insertion)));

        m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                *((uint32_t*)(&req->stat_mem_time_per_byte_launch)));
        m5_print_stat(PREDICTED_MEMORY_TIME,
                *((uint32_t*)(&req->stat_mem_time_launch)));

        m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                *((uint32_t*)(&req->stat_mem_time_per_byte_truth_load)));
        m5_print_stat(PREDICTED_MEMORY_TIME,
                *((uint32_t*)(&req->stat_mem_time_truth_load)));

        m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
                *((uint32_t*)(&req->stat_mem_time_per_byte_truth_store)));
        m5_print_stat(PREDICTED_MEMORY_TIME,
                *((uint32_t*)(&req->stat_mem_time_truth_store)));
#endif

        acc_state[i][j].running_req = NULL;
        num_running--;
        num_available_instances[i]++;
    }

    else {
        printf("ERROR: interrupt raised by an inactive accelerator."
                " ACC_ID=%d, DEV_ID=%d\n", i, j);
        m5_exit();
    }

    launch_requests();

#ifdef ENABLE_STATS
    m5_print_stat(DEGREE_OF_PARALLELISM, num_running);
#endif
}

void data_abort_handler(uint32_t pc)
{
    printf("Data abort caused by instruction at pc: %x\n", pc);
    m5_exit();
}
