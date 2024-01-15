#include "../../common/m5ops.h"
#include "runtime.h"
#include "driver.c"

#define min(a,b) ((a) < (b) ? (a) : (b))

int acc_instances[NUM_ACCS] = {
    /* ACC_CANNY_NON_MAX  */ 1,
    /* ACC_CONVOLUTION    */ 1,
    /* ACC_EDGE_TRACKING  */ 1,
    /* ACC_ELEM_MATRIX    */ 1,
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

int acc_spm_addr_offset[NUM_ACCS][MAX_ACC_SPM_PARTS] = {
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

volatile acc_state_t acc_state[NUM_ACCS][MAX_ACC_INSTANCES];
volatile int num_available_instances[NUM_ACCS];

volatile task_struct_t *ready_queue[NUM_ACCS][MAX_READY_QUEUE_SIZE];
volatile int ready_queue_size[NUM_ACCS];
volatile int ready_queue_start[NUM_ACCS];
volatile int ready_queue_end[NUM_ACCS];

volatile int num_running = 0;

volatile scheduling_policy_t scheduling_policy;
volatile mem_predictor_t mem_predictor;
volatile bool enable_dm_pred;
volatile uint32_t runtime_start_time;
volatile int num_dags;
volatile int num_finished_dags[MAX_DAGS];

float mem_prediction = 0;

// Structures for statistics
#ifdef ENABLE_STATS
volatile uint32_t stat_num_forwards[MAX_DAGS][NUM_REPEATS];
volatile uint32_t stat_num_colocations[MAX_DAGS][NUM_REPEATS];
volatile uint32_t stat_dram_data_movement[MAX_DAGS][NUM_REPEATS];
volatile uint32_t stat_spad_data_movement[MAX_DAGS][NUM_REPEATS];
volatile uint32_t stat_dag_deadlines_met[MAX_DAGS];
volatile uint32_t stat_node_deadlines_met[MAX_DAGS][NUM_REPEATS];
volatile float stat_predicted_compute_time = 0;
#endif

void dcache_flush(uint32_t addr, uint32_t num_bytes)
{
#ifdef ENABLE_STATS
    m5_timer_start(8);
#endif

    // only flush lines in the cacheable region
    // we assume here that the data would NOT be spread across cacheable and
    // uncacheable regions, so it is okay to just check the start address
    if (addr < UNCACHEABLE_END) {
#ifdef ENABLE_STATS
        m5_timer_stop(8);
#endif
        return;
    }

    uint32_t num_lines = num_bytes / CACHELINE_SIZE;
    if (num_bytes % CACHELINE_SIZE) {
        num_lines += 1;
    }

    for (int i = 0; i < num_lines; i++) {
        // Write-back the line if it is dirty
        __asm__ ("mcr  p15, 0, %[addr], c7, c14, 1"
                : /* no outputs */
                : [addr] "r" (addr + (i * CACHELINE_SIZE))
                : /* no clobbers */);

        // Invalidate the cache line
        __asm__ ("mcr  p15, 0, %[addr], c7, c6, 1"
                : /* no outputs */
                : [addr] "r" (addr + (i * CACHELINE_SIZE))
                : /* no clobbers */);
    }

    // Data Memory Barrier (DMB)
    __asm__ ("mcr  p15, 0, r0, c7, c10, 5"
            : /* no outputs */
            : /* no inputs */
            : /* no clobbers */);

#ifdef ENABLE_STATS
    m5_timer_stop(8);
#endif
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

#ifdef ENABLE_STATS
inline void print_pred_statistics(volatile task_struct_t *req)
{
    m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
            *((uint32_t*)(&req->stat_mem_time_per_byte_pred_load)));
    m5_print_stat(PREDICTED_MEMORY_TIME,
            *((uint32_t*)(&req->stat_mem_time_pred_load)));

    m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
            *((uint32_t*)(&req->stat_mem_time_per_byte_pred_store)));
    m5_print_stat(PREDICTED_MEMORY_TIME,
            *((uint32_t*)(&req->stat_mem_time_pred_store)));

    m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
            *((uint32_t*)(&req->stat_mem_time_per_byte_truth_load)));
    m5_print_stat(PREDICTED_MEMORY_TIME,
            *((uint32_t*)(&req->stat_mem_time_truth_load)));

    m5_print_stat(PREDICTED_MEMORY_TIME_PER_BYTE,
            *((uint32_t*)(&req->stat_mem_time_per_byte_truth_store)));
    m5_print_stat(PREDICTED_MEMORY_TIME,
            *((uint32_t*)(&req->stat_mem_time_truth_store)));

    m5_print_stat(PREDICTED_MEMORY_SIZE, req->pred_load_size);
    m5_print_stat(PREDICTED_MEMORY_SIZE, req->stat_mem_size_truth_load);

    m5_print_stat(PREDICTED_MEMORY_SIZE, req->pred_store_size);
    m5_print_stat(PREDICTED_MEMORY_SIZE, req->stat_mem_size_truth_store);
}

inline void print_final_stats()
{
    m5_dump_stats();

    for (int i = 0; i < num_dags; i++) {
        m5_print_stat(FINISHED_DAG_ITERS, num_finished_dags[i]);
        m5_print_stat(DAG_DEADLINES_MET, stat_dag_deadlines_met[i]);

        for (int j = 0; j < num_finished_dags[i]; j++) {
            m5_print_stat(NUM_FORWARDS, stat_num_forwards[i][j]);
            m5_print_stat(NUM_COLOCATIONS, stat_num_colocations[i][j]);
            m5_print_stat(DRAM_DATA_MOVEMENT, stat_dram_data_movement[i][j]);
            m5_print_stat(SPAD_DATA_MOVEMENT, stat_spad_data_movement[i][j]);
            m5_print_stat(NODE_DEADLINES_MET, stat_node_deadlines_met[i][j]);
        }
    }

    m5_print_stat(PREDICTED_COMPUTE_TIME,
            (uint32_t)stat_predicted_compute_time);

    m5_print_stat(TOTAL_RUNTIME, (m5_get_time() / 1000) - runtime_start_time);
}
#endif

/**
 * Predictors
 */

// Last value predictor
inline void update_last_val_predictor(float time, uint32_t size)
{
    mem_prediction = time / size;
}

// Average predictor
#define MAX_MEM_HIST_LEN 15
float mem_time_hist[MAX_MEM_HIST_LEN];
float mem_size_hist[MAX_MEM_HIST_LEN];
float total_time = 0;
float total_size = 0;
uint8_t mem_hist_len = 0;
uint8_t mem_hist_pos = 0;

inline void update_average_predictor(float time, uint32_t size)
{
    total_time += time;
    total_size += size;

    if (mem_hist_len == MAX_MEM_HIST_LEN) {
        total_time -= mem_time_hist[mem_hist_pos];
        total_size -= mem_size_hist[mem_hist_pos];
    }

    mem_time_hist[mem_hist_pos] = time;
    mem_size_hist[mem_hist_pos] = size;

    mem_hist_len = min(MAX_MEM_HIST_LEN, mem_hist_len + 1);
    mem_hist_pos = (mem_hist_pos + 1) % MAX_MEM_HIST_LEN;

    mem_prediction = total_time / total_size;
}

// EWMA predictor
const float alpha = 0.25;
bool is_first_observation = true;

inline void update_ewma_predictor(float time, uint32_t size)
{
    float mem_time_per_byte = time / size;

    if (is_first_observation) {
        mem_prediction = mem_time_per_byte;
        is_first_observation = false;
    }
    else {
        mem_prediction = (alpha * mem_time_per_byte) + \
                         ((1 - alpha) * mem_prediction);
    }
}

inline void update_mem_time_predictor(float time, uint32_t size)
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
        case MEM_PRED_NO_PRED: break;
        default:
            printf("Invalid memory time predictor selected.\n");
            m5_exit(0);
    }

#ifdef ENABLE_STATS
    m5_timer_stop(1);
#endif
}

inline void init_mem_time_predictor()
{
    mem_prediction = 0.00007275957;
}

/**
 * Pre-condition: the child must be ready
 */
inline bool can_colocate(volatile task_struct_t *parent,
        volatile task_struct_t *child)
{
    bool can_colocate = false;

    if (parent->acc_id == child->acc_id) {
        can_colocate = true;

        for (uint16_t c = 0; c < parent->num_children; c++) {
            if ((parent->children[c]->status != REQ_STATUS_COMPLETED) && \
                (parent->children[c]->acc_id == parent->acc_id) && \
                (parent->children[c]->node_deadline < child->node_deadline)) {
                // This parent has a child that requires the same resource and
                // has not been scheduled, but will potentially start before
                // the given child.
                can_colocate = false;
                break;
            }
        }
    }

    return can_colocate;
}

inline float get_compute_time(volatile task_struct_t *req)
{
    return req->compute_time;
}

inline float get_worst_case_load_time(volatile task_struct_t *req)
{
    uint32_t data_movement = 0;

    for (int p = 0; p < req->num_parents; p++) {
        data_movement += req->producer[p]->output_size;
    }

    return (data_movement * mem_prediction);
}

inline float get_worst_case_store_time(volatile task_struct_t *req)
{
    return (req->output_size * mem_prediction);
}

inline float get_worst_case_runtime(volatile task_struct_t *req)
{
    return (get_compute_time(req) + get_worst_case_load_time(req) + \
            get_worst_case_store_time(req));
}

inline uint32_t get_pred_load_size(volatile task_struct_t *req,
        volatile task_struct_t *finishing_producer)
{
#ifdef ENABLE_STATS
    m5_timer_start(4);
#endif

    uint32_t data_movement = 0;

    for (uint16_t p = 0; p < req->num_parents; p++) {
        if (enable_dm_pred && (req->producer[p] == finishing_producer) &&
                can_colocate(finishing_producer, req)) {
            continue;
        }
        data_movement += req->producer[p]->output_size;
    }

#ifdef ENABLE_STATS
    m5_timer_stop(4);
#endif

    return data_movement;
}

inline uint32_t get_pred_store_size(volatile task_struct_t *req)
{
#ifdef ENABLE_STATS
    m5_timer_start(5);
#endif

    bool pred_write_to_mem = true;

    if (enable_dm_pred) {
        int num_children_per_acc_id[NUM_ACCS] = {
            /* ACC_CANNY_NON_MAX  */ 0,
            /* ACC_CONVOLUTION    */ 0,
            /* ACC_EDGE_TRACKING  */ 0,
            /* ACC_ELEM_MATRIX    */ 0,
            /* ACC_GRAYSCALE      */ 0,
            /* ACC_HARRIS_NON_MAX */ 0,
            /* ACC_ISP            */ 0
        };

        for (uint16_t c = 0; c < req->num_children; c++) {
            pred_write_to_mem = false;

            volatile task_struct_t *child = req->children[c];

            num_children_per_acc_id[child->acc_id]++;

            if (num_children_per_acc_id[child->acc_id] > \
                    acc_instances[child->acc_id]) {
                // There's more children for this accelerator ID than available
                // instances, which means we will *definitely* need to perform
                // a store.
                pred_write_to_mem = true;
                break;
            }

            bool is_producer_after_req = false;

            for (uint16_t p = 0; p < child->num_parents; p++) {
                task_struct_t *producer = child->producer[p];

                if (producer == req) {
                    is_producer_after_req = true;
                    continue;
                }

                if ((producer->status == REQ_STATUS_WAITING) ||
                    ((producer->status == REQ_STATUS_READY) &&
                     ((producer->node_deadline > req->node_deadline) ||
                      ((producer->node_deadline == req->node_deadline) &&
                       is_producer_after_req)))) {
                    // This child has a parent that
                    // a) is not ready, or
                    // b) is ready, but has not been scheduled and will
                    //    potentially finish after the given parent.
                    pred_write_to_mem = true;
                    break;
                }
            }

            if (pred_write_to_mem) { break; }
        }
    }

#ifdef ENABLE_STATS
    m5_timer_stop(5);
#endif

    if (pred_write_to_mem) {
        return req->output_size;
    }
    
    return 0;
}

/**
 * Functions for running each accelerator
 */

inline void run_canny_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    uint32_t hypo_addr = 0, theta_addr = 0;

    if (acc->status == ACC_STATUS_IDLE) {
        uint8_t out_spm_part = acc->curr_spm_out_part ^ 1;
        if (acc->spm_ongoing_reads[out_spm_part] > 0) { return; }

        acc->curr_spm_out_part = out_spm_part;
        acc->spm_results[acc->curr_spm_out_part] = req;

        // check if we can forward hypotenuse
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            hypo_addr =
                req->producer_acc[0]->spm_addr[req->producer_spm_part[0]];
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]++;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_spad_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        } else {
            hypo_addr = (uint32_t) args->hypotenuse;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_dram_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        }

#ifdef ENABLE_STATS
        req->stat_mem_size_truth_load = req->producer[0]->output_size;
#endif
    }

    else if (acc->status == ACC_STATUS_DMA_ARG1) {
        // check if we can forward theta
        if ((req->producer_acc[1] != NULL) && \
            (req->producer_acc[1]->spm_results[req->producer_spm_part[1]] == \
                req->producer[1])) {
            theta_addr =
                req->producer_acc[1]->spm_addr[req->producer_spm_part[1]];
            req->producer_acc[1]->spm_ongoing_reads[\
                req->producer_spm_part[1]]++;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_spad_data_movement[dag_id][dag_inst] += \
                req->producer[1]->output_size;
#endif
        } else {
            theta_addr = (uint32_t) args->theta;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_dram_data_movement[dag_id][dag_inst] += \
                req->producer[1]->output_size;
#endif
        }

#ifdef ENABLE_STATS
        req->stat_mem_size_truth_load += req->producer[1]->output_size;
#endif
    }

    canny_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, hypo_addr,
            theta_addr, 0, acc->spm_addr[acc->curr_spm_out_part], acc);

    if (acc->status == ACC_STATUS_RUNNING) {
        // reduce current reads for the hypotenuse producer
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]--;
        }

        // reduce current reads for the theta producer
        if ((req->producer_acc[1] != NULL) && \
            (req->producer_acc[1]->spm_results[req->producer_spm_part[1]] == \
                req->producer[1])) {
            req->producer_acc[1]->spm_ongoing_reads[\
                req->producer_spm_part[1]]--;
        }
    }
}

inline void run_convolution(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    uint32_t input_addr = 0, kernel_addr = (uint32_t) args->kernel;

    if (acc->status == ACC_STATUS_IDLE) {
        uint32_t input_spm_addr = 0;
        uint8_t out_spm_part = 0;
        bool fwd_from_another_accelerator = false;

        // check if we can forward the input
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            if (req->producer_acc[0] == acc) {
                input_spm_addr = acc->spm_addr[req->producer_spm_part[0]];
                out_spm_part = req->producer_spm_part[0] ^ 1;
            }
            else {
                input_addr =
                    req->producer_acc[0]->spm_addr[req->producer_spm_part[0]];
                out_spm_part = acc->curr_spm_out_part ^ 1;
                fwd_from_another_accelerator = true;
            }
        }
        else {
            input_addr = (uint32_t) args->input;
            out_spm_part = acc->curr_spm_out_part ^ 1;
        }
        
        if (acc->spm_ongoing_reads[out_spm_part] > 0) { return; }
        acc->curr_spm_out_part = out_spm_part;
        acc->spm_results[acc->curr_spm_out_part] = req;
        
        if (input_spm_addr == 0) {
            acc->curr_spm_in_addr[0] = CONVOLUTION0_INPUT_SPM;

            if (fwd_from_another_accelerator) {
                req->producer_acc[0]->spm_ongoing_reads[\
                    req->producer_spm_part[0]]++;

#ifdef ENABLE_STATS
                int dag_id = req->dag_id;
                int dag_inst = num_finished_dags[dag_id];
                stat_num_forwards[dag_id][dag_inst]++;
                stat_spad_data_movement[dag_id][dag_inst] += \
                    req->producer[0]->output_size;
            } else {
                int dag_id = req->dag_id;
                int dag_inst = num_finished_dags[dag_id];
                stat_dram_data_movement[dag_id][dag_inst] += \
                    req->producer[0]->output_size;
            }
            
            req->stat_mem_size_truth_load = req->producer[0]->output_size;
#else
            }
#endif
        } else {
            acc->curr_spm_in_addr[0] = input_spm_addr;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_num_colocations[dag_id][dag_inst]++;
            req->stat_mem_size_truth_load = 0;
#endif
        }
    }

    if ((acc->status == ACC_STATUS_DMA_ARG1) || \
        ((acc->status == ACC_STATUS_IDLE) && (input_addr == 0))) {
#ifdef ENABLE_STATS
        int dag_id = req->dag_id;
        int dag_inst = num_finished_dags[dag_id];
        stat_dram_data_movement[dag_id][dag_inst] += \
            args->kern_height * args->kern_width * 4;
#endif
    }

    convolution_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr,
            kernel_addr, args->kern_height, args->kern_width,
            args->mod_and_floor, 0, acc->curr_spm_in_addr[0],
            acc->spm_addr[acc->curr_spm_out_part], acc);

    // reduce current reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            if (req->producer_acc[0] != acc) {
                req->producer_acc[0]->spm_ongoing_reads[\
                    req->producer_spm_part[0]]--;
            }
        }
    }
}

inline void run_edge_tracking(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    uint32_t input_addr;

    if (acc->status == ACC_STATUS_IDLE) {
        uint8_t out_spm_part = acc->curr_spm_out_part ^ 1;
        if (acc->spm_ongoing_reads[out_spm_part] > 0) { return; }

        acc->curr_spm_out_part = out_spm_part;
        acc->spm_results[acc->curr_spm_out_part] = req;

        // check if we can forward the input
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            input_addr =
                req->producer_acc[0]->spm_addr[req->producer_spm_part[0]];
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]++;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_spad_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        } else {
            input_addr = (uint32_t) args->input;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_dram_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        }

#ifdef ENABLE_STATS
        req->stat_mem_size_truth_load = req->producer[0]->output_size;
#endif
    }

    edge_tracking_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr,
            args->thr_weak_ratio, args->thr_strong_ratio, 0,
            acc->spm_addr[acc->curr_spm_out_part], acc);

    // reduce current reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            req->producer_acc[0]->spm_ongoing_reads[\
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
    bool has_arg2 = false;

    switch (args->op) {
        case ADD:
        case SUB:
        case MUL:
        case DIV:
        case ATAN2: has_arg2 = true;
    }

    if (acc->status == ACC_STATUS_IDLE) {
        // we can read and write to the same partition because elem-matrix does
        // not reuse inputs
        uint8_t out_spm_part = acc->curr_spm_out_part ^ 1;
        if (acc->spm_ongoing_reads[out_spm_part] > 0) { return; }

        acc->curr_spm_out_part = out_spm_part;
        acc->spm_results[acc->curr_spm_out_part] = req;

        bool fwd_from_another_accelerator = false;

        // check if we can forward arg1
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            if (req->producer_acc[0] == acc) {
                arg1_spm_addr = acc->spm_addr[req->producer_spm_part[0]];
            }
            else {
                arg1_addr =
                    req->producer_acc[0]->spm_addr[req->producer_spm_part[0]];
                fwd_from_another_accelerator = true;
            }
        }
        else {
            arg1_addr = (uint32_t) args->arg1;
        }
        
        if (arg1_spm_addr == 0) {
            acc->curr_spm_in_addr[0] = ELEM_MATRIX0_ARG1_SPM;

            if (fwd_from_another_accelerator) {
                req->producer_acc[0]->spm_ongoing_reads[\
                    req->producer_spm_part[0]]++;

#ifdef ENABLE_STATS
                int dag_id = req->dag_id;
                int dag_inst = num_finished_dags[dag_id];
                stat_num_forwards[dag_id][dag_inst]++;
                stat_spad_data_movement[dag_id][dag_inst] += \
                    req->producer[0]->output_size;
            } else {
                int dag_id = req->dag_id;
                int dag_inst = num_finished_dags[dag_id];
                stat_dram_data_movement[dag_id][dag_inst] += \
                    req->producer[0]->output_size;
            }
            
            req->stat_mem_size_truth_load = req->producer[0]->output_size;
#else
            }
#endif
        } else {
            acc->curr_spm_in_addr[0] = arg1_spm_addr;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_num_colocations[dag_id][dag_inst]++;
            req->stat_mem_size_truth_load = 0;
#endif
        }
    }

    if (has_arg2 && ((acc->status == ACC_STATUS_DMA_ARG1) || \
                ((acc->status == ACC_STATUS_IDLE) && (arg1_addr==0)))) {
        bool fwd_from_another_accelerator = false;

        // check if we can forward arg2
        if ((req->producer_acc[1] != NULL) && \
            (req->producer_acc[1]->spm_results[req->producer_spm_part[1]] == \
             req->producer[1])) {
            if (req->producer_acc[1] == acc) {
                arg2_spm_addr = acc->spm_addr[req->producer_spm_part[1]];
            }
            else {
                arg2_addr = req->producer_acc[1]->spm_addr[\
                    req->producer_spm_part[1]];
                fwd_from_another_accelerator = true;

#ifdef ENABLE_STATS
                req->stat_mem_size_truth_load += \
                        req->producer[1]->output_size;
#endif
            }
        }
        else {
            arg2_addr = (uint32_t) args->arg2;

#ifdef ENABLE_STATS
            req->stat_mem_size_truth_load += req->producer[1]->output_size;
#endif
        }
    
        if (arg2_spm_addr == 0) {
            acc->curr_spm_in_addr[1] = ELEM_MATRIX0_ARG2_SPM;

            if (fwd_from_another_accelerator) {
                req->producer_acc[1]->spm_ongoing_reads[\
                    req->producer_spm_part[1]]++;

#ifdef ENABLE_STATS
                int dag_id = req->dag_id;
                int dag_inst = num_finished_dags[dag_id];
                stat_num_forwards[dag_id][dag_inst]++;
                stat_spad_data_movement[dag_id][dag_inst] += \
                    req->producer[1]->output_size;
            } else {
                int dag_id = req->dag_id;
                int dag_inst = num_finished_dags[dag_id];
                stat_dram_data_movement[dag_id][dag_inst] += \
                    req->producer[1]->output_size;
            }
            
            req->stat_mem_size_truth_load = req->producer[1]->output_size;
#else
            }
#endif
        } else {
            acc->curr_spm_in_addr[1] = arg2_spm_addr;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_num_colocations[dag_id][dag_inst]++;
#endif
        }
    }

    elem_matrix_driver(device_id, IMG_HEIGHT, IMG_WIDTH, arg1_addr, arg2_addr,
            args->is_arg2_scalar, args->op, args->do_one_minus, 0,
            acc->curr_spm_in_addr[0], acc->curr_spm_in_addr[1],
            acc->spm_addr[acc->curr_spm_out_part], acc);

    if (acc->status == ACC_STATUS_RUNNING) {
        // reduce current reads for the arg1 producer
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            if (req->producer_acc[0] != acc) {
                req->producer_acc[0]->spm_ongoing_reads[\
                    req->producer_spm_part[0]]--;
            }
        }

        // reduce current reads for the arg2 producer
        if (has_arg2 && (req->producer_acc[1] != NULL) && \
            (req->producer_acc[1]->spm_results[req->producer_spm_part[1]] == \
                req->producer[1])) {
            if (req->producer_acc[1] != acc) {
                req->producer_acc[1]->spm_ongoing_reads[\
                    req->producer_spm_part[1]]--;
            }
        }
    }
}

inline void run_grayscale(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    uint32_t input_addr;

    if (acc->status == ACC_STATUS_IDLE) {
        uint8_t out_spm_part = acc->curr_spm_out_part ^ 1;
        if (acc->spm_ongoing_reads[out_spm_part] > 0) { return; }

        acc->curr_spm_out_part = out_spm_part;
        acc->spm_results[acc->curr_spm_out_part] = req;

        // check if we can forward the input
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            input_addr =
                req->producer_acc[0]->spm_addr[req->producer_spm_part[0]];
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]++;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_spad_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        } else {
            input_addr = (uint32_t) args->input;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_dram_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        }

#ifdef ENABLE_STATS
        req->stat_mem_size_truth_load = req->producer[0]->output_size;
#endif
    }

    grayscale_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_addr[acc->curr_spm_out_part], acc);

    // reduce current reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]--;
        }
    }
}

inline void run_harris_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    uint32_t input_addr;

    if (acc->status == ACC_STATUS_IDLE) {
        uint8_t out_spm_part = acc->curr_spm_out_part ^ 1;
        if (acc->spm_ongoing_reads[out_spm_part] > 0) { return; }

        acc->curr_spm_out_part = out_spm_part;
        acc->spm_results[acc->curr_spm_out_part] = req;

        // check if we can forward the input
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            input_addr =
                req->producer_acc[0]->spm_addr[req->producer_spm_part[0]];
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]++;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_spad_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        } else {
            input_addr = (uint32_t) args->input;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_dram_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        }

#ifdef ENABLE_STATS
        req->stat_mem_size_truth_load = req->producer[0]->output_size;
#endif
    }

    harris_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_addr[acc->curr_spm_out_part], acc);

    // reduce current reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]--;
        }
    }
}

inline void run_isp(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    uint32_t input_addr;

    if (acc->status == ACC_STATUS_IDLE) {
        uint8_t out_spm_part = acc->curr_spm_out_part ^ 1;
        if (acc->spm_ongoing_reads[out_spm_part] > 0) { return; }

        acc->curr_spm_out_part = out_spm_part;
        acc->spm_results[acc->curr_spm_out_part] = req;

        // check if we can forward the input
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            input_addr =
                req->producer_acc[0]->spm_addr[req->producer_spm_part[0]];
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]++;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_num_forwards[dag_id][dag_inst]++;
            stat_spad_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        } else {
            input_addr = (uint32_t) args->input;

#ifdef ENABLE_STATS
            int dag_id = req->dag_id;
            int dag_inst = num_finished_dags[dag_id];
            stat_dram_data_movement[dag_id][dag_inst] += \
                req->producer[0]->output_size;
#endif
        }

#ifdef ENABLE_STATS
        req->stat_mem_size_truth_load = req->producer[0]->output_size;
#endif
    }

    isp_driver(device_id, IMG_HEIGHT, IMG_WIDTH, input_addr, 0,
            acc->spm_addr[acc->curr_spm_out_part], acc);

    // reduce current reads for the input producer
    if (acc->status == ACC_STATUS_RUNNING) {
        if ((req->producer_acc[0] != NULL) && \
            (req->producer_acc[0]->spm_results[req->producer_spm_part[0]] == \
                req->producer[0])) {
            req->producer_acc[0]->spm_ongoing_reads[\
                req->producer_spm_part[0]]--;
        }
    }
}

inline void run_accelerator(int acc_id, int device_id,
        volatile task_struct_t *req)
{
#ifdef ENABLE_STATS
    m5_timer_start(6);
#endif

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

#ifdef ENABLE_STATS
    m5_timer_stop(6);
#endif
}

/**
 * Functions for copying accelerator outputs
 */

inline void finish_canny_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    canny_non_max_args *args = (canny_non_max_args*) req->acc_args;
    canny_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0,
            (uint32_t) args->output, acc->spm_addr[acc->curr_spm_out_part],
            acc);
}

inline void finish_convolution(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    convolution_args *args = (convolution_args*) req->acc_args;
    convolution_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, acc->spm_addr[acc->curr_spm_out_part],
            acc);
}

inline void finish_edge_tracking(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    edge_tracking_args *args = (edge_tracking_args*) req->acc_args;
    edge_tracking_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0,
            (uint32_t) args->output, acc->spm_addr[acc->curr_spm_out_part],
            acc);
}

inline void finish_elem_matrix(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    elem_matrix_args *args = (elem_matrix_args*) req->acc_args;
    elem_matrix_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, 0, 0, 0, 0,
            (uint32_t) args->output, 0, 0,
            acc->spm_addr[acc->curr_spm_out_part], acc);
}

inline void finish_grayscale(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    grayscale_args *args = (grayscale_args*) req->acc_args;
    grayscale_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_addr[acc->curr_spm_out_part],
            acc);
}

inline void finish_harris_non_max(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    harris_non_max_args *args = (harris_non_max_args*) req->acc_args;
    harris_non_max_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0,
            (uint32_t) args->output, acc->spm_addr[acc->curr_spm_out_part],
            acc);
}

inline void finish_isp(int device_id, volatile task_struct_t *req,
        volatile acc_state_t *acc)
{
    isp_args *args = (isp_args*) req->acc_args;
    isp_driver(device_id, IMG_HEIGHT, IMG_WIDTH, 0, (uint32_t) args->output,
            acc->spm_addr[acc->curr_spm_out_part], acc);
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
        
#ifdef ENABLE_STATS
        req->stat_mem_size_truth_store = req->output_size;

        int dag_id = req->dag_id;
        int dag_inst = num_finished_dags[dag_id];
        stat_dram_data_movement[dag_id][dag_inst] += req->output_size;
#endif
    }
    else {
        acc->status = ACC_STATUS_IDLE;
        
#ifdef ENABLE_STATS
        req->stat_mem_size_truth_store = 0;
#endif
    }

    *(acc->flags) = 0;
}

/**
 * The actual runtime
 */

bool push_request(volatile task_struct_t *req, bool try_forward)
{
#ifdef ENABLE_STATS
    m5_timer_start(2);
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

        case LL: {
#ifdef ENABLE_STATS
            float compute_time = get_compute_time(req);
            float load_time = get_worst_case_load_time(req);
            float store_time = get_worst_case_store_time(req);

            req->runtime = compute_time + load_time + store_time;

            req->stat_mem_time_per_byte_pred_load = mem_prediction;
            req->stat_mem_time_per_byte_pred_store = mem_prediction;
            req->stat_mem_time_pred_load = load_time;
            req->stat_mem_time_pred_store = store_time;

            stat_predicted_compute_time += compute_time;
#else
            req->runtime = get_worst_case_runtime(req);
#endif

            req->laxity = req->node_deadline + runtime_start_time - \
                          req->runtime;

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

            break;
        }

        case LAX: {
#ifdef ENABLE_STATS
            float compute_time = get_compute_time(req);
            float load_time = get_worst_case_load_time(req);
            float store_time = get_worst_case_store_time(req);

            req->runtime = compute_time + load_time + store_time;

            req->stat_mem_time_per_byte_pred_load = mem_prediction;
            req->stat_mem_time_per_byte_pred_store = mem_prediction;
            req->stat_mem_time_pred_load = load_time;
            req->stat_mem_time_pred_store = store_time;

            stat_predicted_compute_time += compute_time;
#else
            req->runtime = get_worst_case_runtime(req);
#endif

            req->laxity = req->node_deadline + runtime_start_time - \
                          req->runtime;

            if ((req->laxity - ((int32_t)m5_get_time() / 1000)) <= 0) {
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

        case ELFD: {
            if ((req->laxity - ((int32_t)m5_get_time() / 1000)) <= 0) {
                // De-prioritize a node if its laxity is negative. That is,
                // the node is unlikely to finish before its deadline.
                req->laxity = 0x7fffffff;

                ready_queue[acc_id][ready_queue_end[acc_id]] = req;
                ready_queue_end[acc_id] = (ready_queue_end[acc_id] + 1) % \
                                          MAX_READY_QUEUE_SIZE;

                req->priority_escalated = can_forward;
                break;
            }

            // else, perform regular ELF insertion
        }

        case ELF:
        case HetSched_FWD: {
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
                    if (ready_queue[acc_id][i]->priority_escalated) {continue;}

                    int32_t laxity = ready_queue[acc_id][i]->laxity - \
                                     (m5_get_time() / 1000);

                    if (laxity > 0) {
                        can_forward = laxity >= ((int32_t)req->runtime);
                        break;
#ifdef LIMIT_ESCALATIONS
                    } else {
                        if (ready_queue[acc_id][i]->num_escalations >= \
                                MAX_ESCALATIONS) {
                            can_forward = false;
                            break;
                        }
#endif
                    }
                }
            }

            if (can_forward) {
                int fwd_pos = ready_queue_start[acc_id];

                // Reduce node laxities
                for (int i = ready_queue_start[acc_id]; i != pos;
                     i = (i + 1) % MAX_READY_QUEUE_SIZE) {
#ifdef LIMIT_ESCALATIONS
                    int32_t laxity = ready_queue[acc_id][i]->laxity - \
                                     (m5_get_time() / 1000);
                    if (laxity <= 0) {
                        ready_queue[acc_id][i]->num_escalations++;
                    }
#endif

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

            break;
        }
        
        case HetSched: {
#ifdef ENABLE_STATS
            float compute_time = get_compute_time(req);
            float load_time = get_worst_case_load_time(req);
            float store_time = get_worst_case_store_time(req);

            req->runtime = compute_time + load_time + store_time;

            req->stat_mem_time_per_byte_pred_load = mem_prediction;
            req->stat_mem_time_per_byte_pred_store = mem_prediction;
            req->stat_mem_time_pred_load = load_time;
            req->stat_mem_time_pred_store = store_time;

            stat_predicted_compute_time += compute_time;
#else
            req->runtime = get_worst_case_runtime(req);
#endif

            req->laxity = req->sd + runtime_start_time - req->runtime;

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

            break;
        }
    }

    ready_queue_size[acc_id]++;

#ifdef ENABLE_STATS
    m5_timer_stop(2);
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

void runtime(task_struct_t ***nodes, int num_dags_arg, int num_nodes[MAX_DAGS],
        scheduling_policy_t policy, mem_predictor_t predictor, bool dm_pred)
{
    num_dags = num_dags_arg;

    // Initialize structures
    for (int i = 0; i < NUM_ACCS; i++) {
        for (int j = 0; j < acc_instances[i]; j++) {
            uint32_t acc_base = 0x20000000 + ((i+1) << 24) + (j << 20);

            acc_state[i][j].flags = (uint8_t*) (acc_base + acc_mmr_offset[i]);
            acc_state[i][j].dma = (uint8_t*) (acc_base + acc_dma_offset[i]);

            for (int k = 0; k < MAX_ACC_SPM_PARTS; k++) {
                acc_state[i][j].spm_addr[k] = acc_base +
                    acc_spm_addr_offset[i][k];
                acc_state[i][j].spm_ongoing_reads[k] = 0;
                acc_state[i][j].spm_results[k] = NULL;
            }

            acc_state[i][j].status = ACC_STATUS_IDLE;
            acc_state[i][j].running_req = NULL;

            for (int k = 0; k < MAX_ACC_ARGS; k++) {
                acc_state[i][j].curr_spm_in_addr[k] = 0;
            }
            acc_state[i][j].curr_spm_out_part = 0;
        }

        ready_queue_size[i] = 0;
        ready_queue_start[i] = 0;
        ready_queue_end[i] = 0;

        num_available_instances[i] = acc_instances[i];
    }

    scheduling_policy = policy;
    mem_predictor = predictor;
    enable_dm_pred = dm_pred;
    init_mem_time_predictor();

    runtime_start_time = m5_get_time() / 1000;

    for (int i = 0; i < num_dags; i++) {
        num_finished_dags[i] = 0;

        for (int j = 0; j < NUM_REPEATS; j++) {
            stat_num_forwards[i][j] = 0;
            stat_num_colocations[i][j] = 0;
            stat_dram_data_movement[i][j] = 0;
            stat_spad_data_movement[i][j] = 0;
            stat_node_deadlines_met[i][j] = 0;
        }
        
        stat_dag_deadlines_met[i] = 0;

        for (int j = 0; j < num_nodes[i]; j++) {
            volatile task_struct_t *req = nodes[i][j];

            req->dag_id = i;
            req->node_id = j;

            if (req->completed_parents == req->num_parents) {
                float compute_time = get_compute_time(req);
                float memory_time;

                if (policy == ELF) {
                    req->pred_load_size = get_pred_load_size(req, NULL);
                    req->pred_store_size = get_pred_store_size(req);

                    float pred_load_time = req->pred_load_size * \
                                           mem_prediction;
                    float pred_store_time = req->pred_store_size * \
                                            mem_prediction;
                    memory_time = pred_load_time + pred_store_time;

#ifdef ENABLE_STATS
                    req->stat_mem_time_per_byte_pred_load = mem_prediction;
                    req->stat_mem_time_per_byte_pred_store = mem_prediction;
                    req->stat_mem_time_pred_load = pred_load_time;
                    req->stat_mem_time_pred_store = pred_store_time;

                    stat_predicted_compute_time += compute_time;
#endif
                }

                else {
                    memory_time = get_worst_case_load_time(req) + \
                                  get_worst_case_store_time(req);
                }

                req->runtime = compute_time + memory_time;
                req->laxity = req->node_deadline + runtime_start_time - \
                              req->runtime;

                push_request(req, false);
            }

            req->num_escalations = 0;
        }
    }

    // Reset the start time after initialization
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
    print_final_stats();
#endif
}

void isr(int i, int j)  // i = accelerator id, j = device id
{
#ifdef ENABLE_STATS
    m5_timer_start(0);
#endif

    volatile acc_state_t *acc = &acc_state[i][j];
    volatile task_struct_t *req = acc->running_req;

    if ((acc->status == ACC_STATUS_DMA_ARG1) ||
        (acc->status == ACC_STATUS_DMA_ARG2)) {
        switch (scheduling_policy) {
            case LAX:
            case ELF: {
                float time = (m5_get_time() - dma_start_time[i][j]) / 1000.0;
                update_mem_time_predictor(time, dma_size[i][j]);

#ifdef ENABLE_STATS
                if (dma_size[i][j] > 512) {
                    float mem_time_per_byte = time / dma_size[i][j];

                    if (req->stat_mem_time_per_byte_truth_load == 0) {
                        req->stat_mem_time_per_byte_truth_load = \
                                mem_time_per_byte;
                    } else {
                        req->stat_mem_time_per_byte_truth_load = \
                                (mem_time_per_byte + \
                                 req->stat_mem_time_per_byte_truth_load) / 2;
                    }

                    req->stat_mem_time_truth_load += time;
                }
#endif
            }
        }

        *(acc->dma) = 0;
        run_accelerator(i, j, req);
    }

    else if (acc->status == ACC_STATUS_RUNNING) {
        *(acc->flags) = 0;

        volatile task_struct_t *pipeline_queue[MAX_CHILDREN];
        int pipeline_queue_size = 0;

        for (int c = 0; c < req->num_children; c++) {
            task_struct_t *child = req->children[c];

            child->completed_parents++;

            if (child->completed_parents == child->num_parents) {
                child->status = REQ_STATUS_READY;

#ifdef ENABLE_STATS
                child->stat_mem_time_per_byte_truth_load = 0;
                child->stat_mem_time_truth_load = 0;

                child->stat_mem_time_per_byte_truth_store = 0;
                child->stat_mem_time_truth_store = 0;
#endif

#ifdef ENABLE_FORWARDING
                if ((scheduling_policy == ELF) || \
                        (scheduling_policy == HetSched_FWD)) {
    #ifdef ENABLE_STATS
                    m5_timer_start(3);
    #endif

                    if (scheduling_policy == ELF) {
                        float compute_time = get_compute_time(child);

                        child->pred_load_size = get_pred_load_size(child, req);
                        child->pred_store_size = get_pred_store_size(child);

                        float pred_load_time = child->pred_load_size * \
                                               mem_prediction;
                        float pred_store_time = child->pred_store_size * \
                                                mem_prediction;

                        child->runtime = compute_time + pred_load_time + \
                                         pred_store_time;

    #ifdef ENABLE_STATS
                        child->stat_mem_time_per_byte_pred_load = \
                                mem_prediction;
                        child->stat_mem_time_per_byte_pred_store = \
                                mem_prediction;
                        child->stat_mem_time_pred_load = pred_load_time;
                        child->stat_mem_time_pred_store = pred_store_time;

                        stat_predicted_compute_time += compute_time;
    #endif

                        child->laxity = child->node_deadline + \
                                        runtime_start_time - child->runtime;
                    }

                    else {
    #ifdef ENABLE_STATS
                        float compute_time = get_compute_time(child);
                        float load_time = get_worst_case_load_time(child);
                        float store_time = get_worst_case_store_time(child);

                        child->runtime = compute_time + load_time + store_time;

                        child->stat_mem_time_per_byte_pred_load = \
                                mem_prediction;
                        child->stat_mem_time_per_byte_pred_store = \
                                mem_prediction;
                        child->stat_mem_time_pred_load = load_time;
                        child->stat_mem_time_pred_store = store_time;

                        stat_predicted_compute_time += compute_time;
    #else
                        child->runtime = get_worst_case_runtime(child);
    #endif

                        child->laxity = child->sd + runtime_start_time - \
                                        child->runtime;
                    }

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
                    m5_timer_stop(3);
    #endif
                }

                else {
                    push_request(child, false);
                }
#else
                push_request(child, false);
#endif
            }
        }

        num_available_instances[i]++;

#ifdef ENABLE_FORWARDING
        if ((scheduling_policy == ELF) || (scheduling_policy == HetSched_FWD)){
            int num_forwards[NUM_ACCS] = {0, 0, 0, 0, 0, 0, 0};

            for (int n = 0; n < pipeline_queue_size; n++) {
                volatile task_struct_t *child = pipeline_queue[n];
                uint8_t acc_id = child->acc_id;

                bool is_forwarded = push_request(child,
                        (num_forwards[acc_id] < \
                         num_available_instances[acc_id]) && \
                        !child->is_first_node);

                if (is_forwarded) {
                    num_forwards[acc_id]++;
                } else {
                    if (scheduling_policy == ELF) {
                        child->pred_load_size = get_pred_load_size(child,NULL);
                        float memory_time = (child->pred_load_size + \
                                             child->pred_store_size) * \
                                            mem_prediction;
                        child->runtime = get_compute_time(child) + memory_time;
                        child->laxity = child->node_deadline + \
                                        runtime_start_time - child->runtime;

        #ifdef ENABLE_STATS
                        child->stat_mem_time_pred_load = \
                                child->pred_load_size * mem_prediction;
        #endif
                    }
                }
            }
        }
#endif

        int num_forwards = 0;

#ifdef ENABLE_FORWARDING
        for (int c = 0; c < req->num_children; c++) {
            task_struct_t *child = req->children[c];

            if (child->is_first_node) { continue; }

            for (int p = 0; p < child->num_parents; p++) {
                if (child->producer[p] == req) {
                    child->producer_acc[p] = acc;
                    child->producer_spm_part[p] = acc->curr_spm_out_part;
                    break;
                }
            }

            if (child->status != REQ_STATUS_READY) { continue; }

            int ready_queue_index = ready_queue_start[child->acc_id];

            for (int n = 0; (n < num_available_instances[child->acc_id]) && \
                    (ready_queue_index != ready_queue_end[child->acc_id]);
                    n++) {
                if (((ready_queue[child->acc_id][ready_queue_index] == child) \
                        || child->priority_escalated) && \
                        !child->is_first_node) {
                    num_forwards++;
                    break;
                }

                ready_queue_index = (ready_queue_index + 1) % \
                                    MAX_READY_QUEUE_SIZE;
            }
        }
#endif

        bool write_out_to_mem = (req->num_children == 0) || \
                                (num_forwards != req->num_children);
        finish_accelerator(i, j, req, write_out_to_mem);

        if (write_out_to_mem) {
            num_available_instances[i]--;
        }
        else {
#ifdef ENABLE_STATS
            uint32_t curr_time = (m5_get_time() / 1000) - runtime_start_time;

            if (curr_time <= req->node_deadline) {
                stat_node_deadlines_met[req->dag_id][\
                    num_finished_dags[req->dag_id]]++;
            }

            m5_print_stat(DAG_ID, req->dag_id);
            m5_print_stat(NODE_ID, req->node_id);

            int32_t deadline_diff = (int32_t)curr_time - \
                                    (int32_t)req->node_deadline;
            m5_print_stat(NODE_DEADLINE_DIFF, *((uint32_t*)(&deadline_diff)));
            m5_print_stat(PREDICTED_COMPUTE_TIME, req->sd);

            print_pred_statistics(req);
#endif

            acc->running_req = NULL;
            num_running--;
        }
    }

    else if (acc->status == ACC_STATUS_DMA_OUT) {
        switch (scheduling_policy) {
            case LAX:
            case ELF: {
                float time = (m5_get_time() - dma_start_time[i][j]) / 1000.0;
                update_mem_time_predictor(time, dma_size[i][j]);

#ifdef ENABLE_STATS
                req->stat_mem_time_per_byte_truth_store = \
                        time / dma_size[i][j];
                req->stat_mem_time_truth_store = time;
#endif
            }
        }

        *(acc->dma) = 0;
        acc->status = ACC_STATUS_IDLE;

#ifdef ENABLE_STATS
        uint32_t curr_time = (m5_get_time() / 1000) - runtime_start_time;

        m5_print_stat(DAG_ID, req->dag_id);
        m5_print_stat(NODE_ID, req->node_id);

        if ((req->num_children == 0) || ((req->num_children == 1) && \
                    req->children[0]->is_first_node)) {
            if (curr_time <= req->dag_deadline) {
                stat_dag_deadlines_met[req->dag_id]++;
            }

            m5_print_stat(DAG_EXEC_TIME, curr_time);

            int32_t deadline_diff = (int32_t)curr_time - \
                                    (int32_t)req->dag_deadline;
            m5_print_stat(DAG_DEADLINE_DIFF, *((uint32_t*)(&deadline_diff)));
        }

        if (curr_time <= req->node_deadline) {
            stat_node_deadlines_met[req->dag_id][\
                num_finished_dags[req->dag_id]]++;
        }

        int32_t deadline_diff = (int32_t)curr_time - \
                                (int32_t)req->node_deadline;
        m5_print_stat(NODE_DEADLINE_DIFF, *((uint32_t*)(&deadline_diff)));
        m5_print_stat(PREDICTED_COMPUTE_TIME, req->sd);

        print_pred_statistics(req);
#endif

        if (req->num_children == 0) {
            num_finished_dags[req->dag_id]++;

#ifdef ENABLE_EARLY_EXIT
            // One of the DAGs finished all its iterations, so we MUST exit now
            print_final_stats();
            m5_exit();
#endif
        }

        // else
        for (int c = 0; c < req->num_children; c++) {
            task_struct_t *child = req->children[c];

            if ((child->status != REQ_STATUS_WAITING) && child->is_first_node){
                num_finished_dags[req->dag_id]++;
                break;
            }
        }

        acc->running_req = NULL;
        num_running--;
        num_available_instances[i]++;
    }

    else {
        printf("ERROR: interrupt raised by an inactive accelerator."
                " ACC_ID=%d, DEV_ID=%d\n", i, j);
        m5_exit();
    }

#ifdef ENABLE_EARLY_EXIT
    uint32_t curr_time = (m5_get_time() / 1000) - runtime_start_time;
    if (curr_time >= MAX_RUNTIME) {
        print_final_stats();
        m5_exit();
    }
#endif

    launch_requests();

#ifdef ENABLE_STATS
    m5_timer_stop(0);
    m5_print_stat(DEGREE_OF_PARALLELISM, num_running);
#endif
}

void data_abort_handler(uint32_t pc)
{
    printf("Data abort caused by instruction at pc: %x\n", pc);
    m5_exit();
}
