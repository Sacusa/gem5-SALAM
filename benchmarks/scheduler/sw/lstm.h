#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

#define LSTM_DEADLINE     7000
#define LSTM_CELL_RUNTIME 421
#define LSTM_SEQ_LENGTH   8
#define LSTM_NUM_NODES    (LSTM_SEQ_LENGTH * 18)

typedef struct {
    float data_input[NUM_PIXELS];
    float cell_input[NUM_PIXELS];

    // Forget gate
    float fg_weighted_input[NUM_PIXELS];
    float fg_biased_input[NUM_PIXELS];
    float fg_sigmoid_out[NUM_PIXELS];
    float fg_output[NUM_PIXELS];

    // Input gate
    float ig_weighted_input1[NUM_PIXELS], ig_weighted_input2[NUM_PIXELS];
    float ig_biased_input1[NUM_PIXELS], ig_biased_input2[NUM_PIXELS];
    float ig_sigmoid_out[NUM_PIXELS];
    float ig_tanh_out[NUM_PIXELS];

    float ig_mult_out[NUM_PIXELS];
    float ig_output[NUM_PIXELS];

    // Output gate
    float og_weighted_input[NUM_PIXELS];
    float og_biased_input[NUM_PIXELS];
    float og_sigmoid_out[NUM_PIXELS];

    float og_tanh_out[NUM_PIXELS];
    float og_output[NUM_PIXELS];

    float *cell_state_input;
    float *hidden_state_input;
} lstm_cell_data_t;

float *lstm_fg_weight;
float *lstm_fg_bias;
float *lstm_ig_weight1;
float *lstm_ig_bias1;
float *lstm_ig_weight2;
float *lstm_ig_bias2;
float *lstm_og_weight;
float *lstm_og_bias;
task_struct_t *lstm_retval[3];

// Dummy tasks with output sizes in the name
task_struct_t *lstm_task_65536;

void lstm_init_cell_data(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, int input_seed, bool is_first, uint32_t earliest_start,
        int rep_count)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    int size = NUM_PIXELS * 4;

    if (is_first) {
        cell->cell_state_input = (float*) get_memory_aligned(size,
                CACHELINE_SIZE);
        cell->hidden_state_input = (float*) get_memory_aligned(size,
                CACHELINE_SIZE);

        dcache_flush((uint32_t) cell->cell_state_input,   size);
        dcache_flush((uint32_t) cell->hidden_state_input, size);
    }
    else {
        cell->cell_state_input = (float*)
            (((elem_matrix_args*)(lstm_retval[2]->acc_args))->output);
        cell->hidden_state_input = (float*)
            (((elem_matrix_args*)(lstm_retval[3]->acc_args))->output);
    }

    for (int i = 0; i < NUM_PIXELS; i++) {
        cell->data_input[i] = (input_seed % IMG_WIDTH) + 1;
        input_seed++;

        if (is_first) {
            cell->cell_state_input[i] = 0;
            cell->hidden_state_input[i] = 0;
        }
    }

    args->arg1 = cell->hidden_state_input;
    args->arg2 = (float*)(cell->data_input);
    args->output = (float*)(cell->cell_input);
    args->is_arg2_scalar = 0;
    args->op = ADD;
    args->do_one_minus = 0;

    task->acc_id = ACC_ELEM_MATRIX;
    task->acc_args = (void*) args;
    task->num_children = 4;
    task->num_parents = 2;
    if (is_first && (rep_count == 0)) {
        task->producer[0] = lstm_task_65536;
        task->status = REQ_STATUS_READY;
        task->completed_parents = 2;
    }
    else {
        task->producer[0] = lstm_retval[3];
        task->status = REQ_STATUS_WAITING;
        task->completed_parents = 1;
        lstm_retval[3]->children[0] = task;
    }
    task->producer[1] = lstm_task_65536;

    task->is_first_node = is_first;
    task->output_size = 65536;
    task->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task->dag_deadline = (rep_count + 1) * LSTM_DEADLINE;
    task->node_deadline = (rep_count * LSTM_DEADLINE) + earliest_start + 55;
    task->sd = (55.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * LSTM_DEADLINE;

    nodes[(rep_count * LSTM_NUM_NODES) + node_index] = task;

    lstm_retval[0] = task;
}

void lstm_forget_gate(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_first, uint32_t earliest_start, int rep_count)
{
    task_struct_t *task[4];
    elem_matrix_args *args[4];

    for (int i = 0; i < 4; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    int size = NUM_PIXELS * 4;

    args[0]->arg1 = (float*)(cell->cell_input);
    args[0]->arg2 = lstm_fg_weight;
    args[0]->output = (float*)(cell->fg_weighted_input);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->fg_weighted_input);
    args[1]->arg2 = lstm_fg_bias;
    args[1]->output = (float*)(cell->fg_biased_input);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = ADD;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = (float*)(cell->fg_biased_input);
    args[2]->output = (float*)(cell->fg_sigmoid_out);
    args[2]->is_arg2_scalar = 0;
    args[2]->op = SIGMOID;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = cell->cell_state_input;
    args[3]->arg2 = (float*)(cell->fg_sigmoid_out);
    args[3]->output = (float*)(cell->fg_output);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = MUL;
    args[3]->do_one_minus = 0;

    for (int i = 0; i < 4; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 1;
        task[i]->is_first_node = false;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->dag_deadline = (rep_count + 1) * LSTM_DEADLINE;

        nodes[(rep_count * LSTM_NUM_NODES) + node_index + i] = task[i];
    }

    task[0]->num_parents = 2;
    task[0]->children[0] = task[1];
    task[0]->producer[0] = lstm_retval[0];
    task[0]->producer[1] = lstm_task_65536;
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[0]->completed_parents = 1;
    task[0]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 112;
    task[0]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[1]->num_parents = 2;
    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];
    task[1]->producer[1] = lstm_task_65536;
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[1]->completed_parents = 1;
    task[1]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 169;
    task[1]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[2]->num_parents = 1;
    task[2]->children[0] = task[3];
    task[2]->producer[0] = task[1];
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_SIGMOID;
    task[2]->completed_parents = 0;
    task[2]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 209;
    task[2]->sd = (40.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[3]->num_parents = 2;
    if (is_first) {
        task[3]->producer[0] = lstm_task_65536;
        task[3]->completed_parents = 1;
    }
    else {
        task[3]->producer[0] = lstm_retval[2];
        task[3]->completed_parents = 0;
        lstm_retval[2]->children[1] = task[3];
    }
    task[3]->producer[1] = task[2];
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[3]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 266;
    task[3]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    lstm_retval[0]->children[0] = task[0];
    lstm_retval[1] = task[3];
}

void lstm_input_gate(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_last, uint32_t earliest_start, int rep_count)
{
    task_struct_t *task[8];
    elem_matrix_args *args[8];

    for (int i = 0; i < 8; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    int size = NUM_PIXELS * 4;

    args[0]->arg1 = (float*)(cell->cell_input);
    args[0]->arg2 = lstm_ig_weight1;
    args[0]->output = (float*)(cell->ig_weighted_input1);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->ig_weighted_input1);
    args[1]->arg2 = lstm_ig_bias1;
    args[1]->output = (float*)(cell->ig_biased_input1);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = ADD;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = (float*)(cell->ig_biased_input1);
    args[2]->output = (float*)(cell->ig_sigmoid_out);
    args[2]->is_arg2_scalar = 0;
    args[2]->op = SIGMOID;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = (float*)(cell->cell_input);
    args[3]->arg2 = lstm_ig_weight2;
    args[3]->output = (float*)(cell->ig_weighted_input2);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = MUL;
    args[3]->do_one_minus = 0;

    args[4]->arg1 = (float*)(cell->ig_weighted_input2);
    args[4]->arg2 = lstm_ig_bias2;
    args[4]->output = (float*)(cell->ig_biased_input2);
    args[4]->is_arg2_scalar = 0;
    args[4]->op = ADD;
    args[4]->do_one_minus = 0;

    args[5]->arg1 = (float*)(cell->ig_biased_input2);
    args[5]->output = (float*)(cell->ig_tanh_out);
    args[5]->is_arg2_scalar = 0;
    args[5]->op = TANH;
    args[5]->do_one_minus = 0;

    args[6]->arg1 = (float*)(cell->ig_sigmoid_out);
    args[6]->arg2 = (float*)(cell->ig_tanh_out);
    args[6]->output = (float*)(cell->ig_mult_out);
    args[6]->is_arg2_scalar = 0;
    args[6]->op = MUL;
    args[6]->do_one_minus = 0;

    args[7]->arg1 = (float*)(cell->fg_output);
    args[7]->arg2 = (float*)(cell->ig_mult_out);
    args[7]->output = (float*)(cell->ig_output);
    args[7]->is_arg2_scalar = 0;
    args[7]->op = ADD;
    args[7]->do_one_minus = 0;

    for (int i = 0; i < 8; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 1;
        task[i]->is_first_node = false;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->dag_deadline = (rep_count + 1) * LSTM_DEADLINE;

        nodes[(rep_count * LSTM_NUM_NODES) + node_index + i] = task[i];
    }

    task[0]->num_parents = 2;
    task[0]->children[0] = task[1];
    task[0]->producer[0] = lstm_retval[0];
    task[0]->producer[1] = lstm_task_65536;
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[0]->completed_parents = 1;
    task[0]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 112;
    task[0]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[1]->num_parents = 2;
    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];
    task[1]->producer[1] = lstm_task_65536;
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[1]->completed_parents = 1;
    task[1]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 169;
    task[1]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[2]->num_parents = 1;
    task[2]->children[0] = task[6];
    task[2]->producer[0] = task[1];
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_SIGMOID;
    task[2]->completed_parents = 0;
    task[2]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 209;
    task[2]->sd = (40.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[3]->num_parents = 2;
    task[3]->children[0] = task[4];
    task[3]->producer[0] = lstm_retval[0];
    task[3]->producer[1] = lstm_task_65536;
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[3]->completed_parents = 1;
    task[3]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 112;
    task[3]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[4]->num_parents = 2;
    task[4]->children[0] = task[5];
    task[4]->producer[0] = task[3];
    task[4]->producer[1] = lstm_task_65536;
    task[4]->output_size = 65536;
    task[4]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[4]->completed_parents = 1;
    task[4]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 169;
    task[4]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[5]->num_parents = 1;
    task[5]->children[0] = task[6];
    task[5]->producer[0] = task[4];
    task[5]->output_size = 65536;
    task[5]->compute_time = RUNTIME_ELEM_MATRIX_TANH;
    task[5]->completed_parents = 0;
    task[5]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 209;
    task[5]->sd = (40.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[6]->num_parents = 2;
    task[6]->children[0] = task[7];
    task[6]->producer[0] = task[2];
    task[6]->producer[1] = task[5];
    task[6]->output_size = 65536;
    task[6]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[6]->completed_parents = 0;
    task[6]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 266;
    task[6]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    task[7]->num_parents = 2;
    if (is_last) {
        task[7]->num_children = 1;
    }
    else {
        task[7]->num_children = 2;
    }
    task[7]->producer[0] = lstm_retval[1];
    task[7]->producer[1] = task[6];
    task[7]->output_size = 65536;
    task[7]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[7]->completed_parents = 0;
    task[7]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 323;
    task[7]->sd = (57.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    lstm_retval[0]->children[1] = task[0];
    lstm_retval[0]->children[2] = task[3];
    lstm_retval[1]->children[0] = task[7];
    lstm_retval[2] = task[7];
}

void lstm_output_gate(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_last, uint32_t earliest_start, int rep_count,
        bool is_last_rep)
{
    task_struct_t *task[5];
    elem_matrix_args *args[5];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 5; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    args[0]->arg1 = (float*)(cell->cell_input);
    args[0]->arg2 = lstm_og_weight;
    args[0]->output = (float*)(cell->og_weighted_input);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->og_weighted_input);
    args[1]->arg2 = lstm_og_bias;
    args[1]->output = (float*)(cell->og_biased_input);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = ADD;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = (float*)(cell->og_biased_input);
    args[2]->output = (float*)(cell->og_sigmoid_out);
    args[2]->is_arg2_scalar = 0;
    args[2]->op = SIGMOID;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = (float*)(cell->ig_output);
    args[3]->output = (float*)(cell->og_tanh_out);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = TANH;
    args[3]->do_one_minus = 0;

    args[4]->arg1 = (float*)(cell->og_tanh_out);
    args[4]->arg2 = (float*)(cell->og_sigmoid_out);
    args[4]->output = (float*)(cell->og_output);
    args[4]->is_arg2_scalar = 0;
    args[4]->op = MUL;
    args[4]->do_one_minus = 0;

    for (int i = 0; i < 5; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 1;
        task[i]->is_first_node = false;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->dag_deadline = (rep_count + 1) * LSTM_DEADLINE;

        nodes[(rep_count * LSTM_NUM_NODES) + node_index + i] = task[i];
    }

    task[0]->num_parents = 2;
    task[0]->children[0] = task[1];
    task[0]->producer[0] = lstm_retval[0];
    task[0]->producer[1] = lstm_task_65536;
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[0]->completed_parents = 1;
    task[0]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 266;
    task[0]->sd = (57.0 / 154) * (1.0 / LSTM_SEQ_LENGTH) * LSTM_DEADLINE;

    task[1]->num_parents = 2;
    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];
    task[1]->producer[1] = lstm_task_65536;
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[1]->completed_parents = 1;
    task[1]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 323;
    task[1]->sd = (57.0 / 154) * (1.0 / LSTM_SEQ_LENGTH) * LSTM_DEADLINE;

    task[2]->num_parents = 1;
    task[2]->children[0] = task[4];
    task[2]->producer[0] = task[1];
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_SIGMOID;
    task[2]->completed_parents = 0;
    task[2]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 362;
    task[2]->sd = (40.0 / 154) * (1.0 / LSTM_SEQ_LENGTH) * LSTM_DEADLINE;

    task[3]->num_parents = 1;
    task[3]->children[0] = task[4];
    task[3]->producer[0] = lstm_retval[2];
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_ELEM_MATRIX_TANH;
    task[3]->completed_parents = 0;
    task[3]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 362;
    task[3]->sd = (40.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    if (is_last && is_last_rep) {
        task[4]->num_children = 0;
    }
    else {
        task[4]->num_children = 1;
    }
    task[4]->num_parents = 2;
    task[4]->producer[0] = task[3];
    task[4]->producer[1] = task[2];
    task[4]->output_size = 65536;
    task[4]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[4]->completed_parents = 0;
    task[4]->node_deadline = (rep_count*LSTM_DEADLINE) + earliest_start + 421;
    task[4]->sd = (58.0 / (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH)) * \
                  LSTM_DEADLINE;

    lstm_retval[0]->children[3] = task[0];
    lstm_retval[2]->children[0] = task[3];
    lstm_retval[3] = task[4];
}

void init_lstm()
{
    int size = NUM_PIXELS * 4;

    lstm_fg_weight  = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    lstm_fg_bias    = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    lstm_ig_weight1 = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    lstm_ig_bias1   = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    lstm_ig_weight2 = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    lstm_ig_bias2   = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    lstm_og_weight  = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    lstm_og_bias    = (float*) get_memory_aligned(size, CACHELINE_SIZE);

    lstm_task_65536 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    lstm_task_65536->output_size = 65536;
    lstm_task_65536->status = REQ_STATUS_COMPLETED;

    dcache_flush((uint32_t) lstm_fg_weight,  size);
    dcache_flush((uint32_t) lstm_fg_bias,    size);
    dcache_flush((uint32_t) lstm_ig_weight1, size);
    dcache_flush((uint32_t) lstm_ig_bias1,   size);
    dcache_flush((uint32_t) lstm_ig_weight2, size);
    dcache_flush((uint32_t) lstm_ig_bias2,   size);
    dcache_flush((uint32_t) lstm_og_weight,  size);
    dcache_flush((uint32_t) lstm_og_bias,    size);

#ifdef VERIFY
    // the weight matter only if we are verifying the output
    for (int i = 0; i < NUM_PIXELS; i++) {
        lstm_fg_weight[i] = (i % IMG_WIDTH) / 700000.0;
        lstm_fg_bias[i]   = (i % IMG_WIDTH) / 100.0;

        lstm_ig_weight1[i] = ((i % IMG_WIDTH) + 1) / 700000.0;
        lstm_ig_bias1[i]   = ((i % IMG_WIDTH) + 1) / 100.0;
        lstm_ig_weight2[i] = ((i % IMG_WIDTH) + 2) / 700000.0;
        lstm_ig_bias2[i]   = ((i % IMG_WIDTH) + 2) / 100.0;

        lstm_og_weight[i] = ((i % IMG_WIDTH) + 3) / 700000.0;
        lstm_og_bias[i]   = ((i % IMG_WIDTH) + 3) / 100.0;
    }
#endif
}

void add_lstm_dag(task_struct_t ***nodes, int *num_nodes, int num_frames)
{
    const int nodes_per_cell = 18;

    for (int i = 0; i < num_frames; i++) {
        for (int rep = 0; rep < NUM_REPEATS; rep++) {
            uint32_t earliest_start = LSTM_DEADLINE - \
                                      (LSTM_CELL_RUNTIME * LSTM_SEQ_LENGTH);

            for (int j = 0; j < LSTM_SEQ_LENGTH; j++) {
                int cell_index = (i * LSTM_SEQ_LENGTH) + j;
                int node_index = j * nodes_per_cell;
                lstm_cell_data_t *cell = (lstm_cell_data_t *) \
                        get_memory_aligned(sizeof(lstm_cell_data_t),
                                CACHELINE_SIZE);

                lstm_init_cell_data(cell, nodes[i], node_index,
                        cell_index, j == 0, earliest_start, rep);

                lstm_forget_gate(cell, nodes[i], node_index + 1, j == 0,
                        earliest_start, rep);

                lstm_input_gate(cell, nodes[i], node_index + 5,
                        j == (LSTM_SEQ_LENGTH - 1), earliest_start, rep);

                lstm_output_gate(cell, nodes[i], node_index + 13,
                        j == (LSTM_SEQ_LENGTH - 1), earliest_start, rep,
                        rep == (NUM_REPEATS - 1));

                dcache_flush((uint32_t) cell, sizeof(lstm_cell_data_t));

                earliest_start += LSTM_CELL_RUNTIME;
            }
        }

        num_nodes[i] = LSTM_NUM_NODES * NUM_REPEATS;
    }
}

void print_lstm_output(task_struct_t ***nodes, int num_frames)
{
    printf("Printing lstm results\n");
    printf("=====================\n");
    int node_index = (18 * LSTM_SEQ_LENGTH) - 1;

    for (int i = 0; i < num_frames; i++) {
        float *final_state =
            ((elem_matrix_args*)(nodes[i][node_index]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Frame %2d, pixel %2d, value = %f\n", i, j,
                    final_state[j]);
        }
    }
}
