#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

#define GRU_DEADLINE     7000
#define GRU_CELL_RUNTIME 592
#define GRU_SEQ_LENGTH   8
#define GRU_NUM_NODES    (GRU_SEQ_LENGTH * 15)

typedef struct {
    float data_input[NUM_PIXELS];
    float cell_state[NUM_PIXELS];

    // Update gate
    float ug_weighted_state[NUM_PIXELS];
    float ug_biased_state[NUM_PIXELS];
    float ug_sigmoid_out[NUM_PIXELS];
    float ug_output[NUM_PIXELS];

    // Reset gate
    float rg_weighted_state[NUM_PIXELS];
    float rg_biased_state[NUM_PIXELS];
    float rg_sigmoid_out[NUM_PIXELS];

    float rg_mult_out1[NUM_PIXELS];
    float rg_add_out1[NUM_PIXELS];
    float rg_mult_out2[NUM_PIXELS];
    float rg_add_out2[NUM_PIXELS];
    float rg_output[NUM_PIXELS];

    // Final cell output
    float ug_rg_mult[NUM_PIXELS];
    float cell_output[NUM_PIXELS];

    // Need to put this here to make sure rest of the struct members are
    // cache-aligned
    float *hidden_state_input;
} gru_cell_data_t;

float *gru_ug_weight;
float *gru_ug_bias;
float *gru_rg_weight1;
float *gru_rg_bias1;
float *gru_rg_weight2;
float *gru_rg_bias2;
task_struct_t *gru_retval[5];

// Dummy tasks with output sizes in the name
task_struct_t *gru_task_65536;

void gru_cell_init(gru_cell_data_t *cell, task_struct_t **nodes,
        int node_index, int input_seed, bool is_first, uint32_t earliest_start,
        int rep_count)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    if (is_first) {
        cell->hidden_state_input = (float*) get_memory_aligned(NUM_PIXELS * 4,
                CACHELINE_SIZE);

        dcache_flush((uint32_t) (cell->hidden_state_input), NUM_PIXELS * 4);
    }
    else {
        cell->hidden_state_input = (float*)
            (((elem_matrix_args*)(gru_retval[4]->acc_args))->output);
    }

    for (int i = 0; i < NUM_PIXELS; i++) {
        cell->data_input[i] = (input_seed % IMG_WIDTH) + 1;
        input_seed++;

        if (is_first) {
            cell->hidden_state_input[i] = 0;
        }
    }

    args->arg1 = cell->hidden_state_input;
    args->arg2 = (float*)(cell->data_input);
    args->output = (float*)(cell->cell_state);
    args->is_arg2_scalar = 0;
    args->op = ADD;
    args->do_one_minus = 0;

    task->acc_id = ACC_ELEM_MATRIX;
    task->acc_args = (void*) args;
    task->num_children = 2;
    task->num_parents = 2;
    if (is_first && (rep_count == 0)) {
        task->producer[0] = gru_task_65536;
        task->status = REQ_STATUS_READY;
        task->completed_parents = 2;
    }
    else {
        task->producer[0] = gru_retval[4];
        task->status = REQ_STATUS_WAITING;
        task->completed_parents = 1;
        gru_retval[4]->children[0] = task;
    }
    task->producer[1] = gru_task_65536;

    task->is_first_node = is_first;
    task->output_size = 65536;
    task->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task->dag_deadline = (rep_count + 1) * GRU_DEADLINE;
    task->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 57;
    task->sd = (57.0 / (GRU_CELL_RUNTIME * GRU_SEQ_LENGTH)) * GRU_DEADLINE;

    nodes[(rep_count * GRU_NUM_NODES) + node_index] = task;

    gru_retval[0] = task;
}

void gru_update_gate(gru_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_first, uint32_t earliest_start, int rep_count)
{
    task_struct_t *task[4];
    elem_matrix_args *args[4];

    for (int i = 0; i < 4; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    if (!is_first) {
        cell->hidden_state_input =
            ((elem_matrix_args*)(gru_retval[3]->acc_args))->output;
    }

    args[0]->arg1 = cell->hidden_state_input;
    args[0]->arg2 = gru_ug_weight;
    args[0]->output = (float*)(cell->ug_weighted_state);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->ug_weighted_state);
    args[1]->arg2 = gru_ug_bias;
    args[1]->output = (float*)(cell->ug_biased_state);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = ADD;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = (float*)(cell->ug_biased_state);
    args[2]->output = (float*)(cell->ug_sigmoid_out);
    args[2]->is_arg2_scalar = 0;
    args[2]->op = SIGMOID;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = cell->hidden_state_input;
    args[3]->arg2 = (float*)(cell->ug_sigmoid_out);
    args[3]->output = (float*)(cell->ug_output);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = MUL;
    args[3]->do_one_minus = 1;

    for (int i = 0; i < 4; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 1;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->dag_deadline = (rep_count + 1) * GRU_DEADLINE;

        nodes[(rep_count * GRU_NUM_NODES) + node_index + i] = task[i];
    }

    task[0]->children[0] = task[1];
    task[0]->num_parents = 2;
    task[0]->producer[0] = gru_retval[0];
    task[0]->producer[1] = gru_task_65536;
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[0]->completed_parents = 1;
    task[0]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 382;
    task[0]->sd = (57.0 / 210) * (1.0 / GRU_SEQ_LENGTH) * GRU_DEADLINE;

    task[1]->children[0] = task[2];
    task[1]->num_parents = 2;
    task[1]->producer[0] = task[0];
    task[1]->producer[1] = gru_task_65536;
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[1]->completed_parents = 1;
    task[1]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 439;
    task[1]->sd = (57.0 / 210) * (1.0 / GRU_SEQ_LENGTH) * GRU_DEADLINE;

    task[2]->num_children = 2;
    task[2]->children[0] = task[3];
    task[2]->num_parents = 1;
    task[2]->producer[0] = task[1];
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_SIGMOID;
    task[2]->completed_parents = 0;
    task[2]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 478;
    task[2]->sd = (39.0 / 210) * (1.0 / GRU_SEQ_LENGTH) * GRU_DEADLINE;

    task[3]->num_parents = 2;
    if (is_first) {
        task[3]->producer[0] = gru_task_65536;
        task[3]->producer[1] = task[2];
        task[3]->completed_parents = 1;
    } else {
        task[3]->producer[0] = gru_retval[4];
        task[3]->producer[1] = task[2];
        gru_retval[4]->children[1] = task[3];
        task[3]->completed_parents = 0;
    }
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[3]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 535;
    task[3]->sd = (57.0 / 210) * (1.0 / GRU_SEQ_LENGTH) * GRU_DEADLINE;

    gru_retval[0]->children[0] = task[0];
    gru_retval[1] = task[2];
    gru_retval[2] = task[3];
}

void gru_reset_gate(gru_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_first, uint32_t earliest_start, int rep_count)
{
    task_struct_t *task[8];
    elem_matrix_args *args[8];

    for (int i = 0; i < 8; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    if (!is_first) {
        cell->hidden_state_input =
            ((elem_matrix_args*)(gru_retval[3]->acc_args))->output;
    }

    args[0]->arg1 = (float*)(cell->cell_state);
    args[0]->arg2 = gru_rg_weight1;
    args[0]->output = (float*)(cell->rg_weighted_state);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->rg_weighted_state);
    args[1]->arg2 = gru_rg_bias1;
    args[1]->output = (float*)(cell->rg_biased_state);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = ADD;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = (float*)(cell->rg_biased_state);
    args[2]->output = (float*)(cell->rg_sigmoid_out);
    args[2]->is_arg2_scalar = 0;
    args[2]->op = SIGMOID;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = (float*)(cell->rg_sigmoid_out);
    args[3]->arg2 = cell->hidden_state_input;
    args[3]->output = (float*)(cell->rg_mult_out1);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = MUL;
    args[3]->do_one_minus = 0;

    args[4]->arg1 = (float*)(cell->rg_mult_out1);
    args[4]->arg2 = (float*)(cell->data_input);
    args[4]->output = (float*)(cell->rg_add_out1);
    args[4]->is_arg2_scalar = 0;
    args[4]->op = ADD;
    args[4]->do_one_minus = 0;

    args[5]->arg1 = (float*)(cell->rg_add_out1);
    args[5]->arg2 = gru_rg_weight2;
    args[5]->output = (float*)(cell->rg_mult_out2);
    args[5]->is_arg2_scalar = 0;
    args[5]->op = MUL;
    args[5]->do_one_minus = 0;

    args[6]->arg1 = (float*)(cell->rg_mult_out2);
    args[6]->arg2 = gru_rg_bias2;
    args[6]->output = (float*)(cell->rg_add_out2);
    args[6]->is_arg2_scalar = 0;
    args[6]->op = ADD;
    args[6]->do_one_minus = 0;

    args[7]->arg1 = (float*)(cell->rg_add_out2);
    args[7]->output = (float*)(cell->rg_output);
    args[7]->is_arg2_scalar = 0;
    args[7]->op = TANH;
    args[7]->do_one_minus = 0;

    for (int i = 0; i < 8; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 1;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;
        task[i]->dag_deadline = (rep_count + 1) * GRU_DEADLINE;

        nodes[(rep_count * GRU_NUM_NODES) + node_index + i] = task[i];
    }

    task[0]->children[0] = task[1];
    task[0]->num_parents = 2;
    task[0]->producer[0] = gru_retval[0];
    task[0]->producer[1] = gru_task_65536;
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[0]->completed_parents = 1;
    task[0]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 114;
    task[0]->sd = (57.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    task[1]->children[0] = task[2];
    task[1]->num_parents = 2;
    task[1]->producer[0] = task[0];
    task[1]->producer[1] = gru_task_65536;
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[1]->completed_parents = 1;
    task[1]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 171;
    task[1]->sd = (57.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    task[2]->children[0] = task[3];
    task[2]->num_parents = 1;
    task[2]->producer[0] = task[1];
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_SIGMOID;
    task[2]->completed_parents = 0;
    task[2]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 210;
    task[2]->sd = (39.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    task[3]->children[0] = task[4];
    task[3]->num_parents = 2;
    if (is_first) {
        task[3]->producer[0] = task[2];
        task[3]->producer[1] = gru_task_65536;
        task[3]->completed_parents = 1;
    }
    else {
        task[3]->producer[0] = task[2];
        task[3]->producer[1] = gru_retval[4];
        gru_retval[4]->children[2] = task[3];
        task[3]->completed_parents = 0;
    }
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[3]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 267;
    task[3]->sd = (57.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    task[4]->children[0] = task[5];
    task[4]->num_parents = 2;
    task[4]->producer[0] = task[3];
    task[4]->producer[1] = gru_task_65536;
    task[4]->output_size = 65536;
    task[4]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[4]->completed_parents = 1;
    task[4]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 324;
    task[4]->sd = (57.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    task[5]->children[0] = task[6];
    task[5]->num_parents = 2;
    task[5]->producer[0] = task[4];
    task[5]->producer[1] = gru_task_65536;
    task[5]->output_size = 65536;
    task[5]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[5]->completed_parents = 1;
    task[5]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 382;
    task[5]->sd = (58.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    task[6]->children[0] = task[7];
    task[6]->num_parents = 2;
    task[6]->producer[0] = task[5];
    task[6]->producer[1] = gru_task_65536;
    task[6]->output_size = 65536;
    task[6]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[6]->completed_parents = 1;
    task[6]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 439;
    task[6]->sd = (57.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    task[7]->children[0] = task[8];
    task[7]->num_parents = 1;
    task[7]->producer[0] = task[6];
    task[7]->output_size = 65536;
    task[7]->compute_time = RUNTIME_ELEM_MATRIX_TANH;
    task[7]->completed_parents = 0;
    task[7]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 478;
    task[7]->sd = (39.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    gru_retval[0]->children[1] = task[0];
    gru_retval[3] = task[7];
}

void gru_cell_output(gru_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_last, uint32_t earliest_start, int rep_count,
        bool is_last_rep)
{
    task_struct_t *task[2];
    elem_matrix_args *args[2];

    for (int i = 0; i < 2; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    args[0]->arg1 = (float*)(cell->ug_sigmoid_out);
    args[0]->arg2 = (float*)(cell->rg_output);
    args[0]->output = (float*)(cell->ug_rg_mult);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->ug_output);
    args[1]->arg2 = (float*)(cell->ug_rg_mult);
    args[1]->output = (float*)(cell->cell_output);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = ADD;
    args[1]->do_one_minus = 0;

    for (int i = 0; i < 2; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_parents = 2;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;
        task[i]->dag_deadline = (rep_count + 1) * GRU_DEADLINE;

        nodes[(rep_count * GRU_NUM_NODES) + node_index + i] = task[i];
    }

    task[0]->num_children = 1;
    task[0]->children[0] = task[1];
    task[0]->producer[0] = gru_retval[1];
    task[0]->producer[1] = gru_retval[3];
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[0]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 535;
    task[0]->sd = (57.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    if (is_last) {
        if (is_last_rep) {
            task[1]->num_children = 0;
        }
        else {
            task[1]->num_children = 1;
        }
    } else {
        task[1]->num_children = 3;
    }
    task[1]->producer[0] = gru_retval[2];
    task[1]->producer[1] = task[0];
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[1]->node_deadline = (rep_count * GRU_DEADLINE) + earliest_start + 592;
    task[1]->sd = (57.0 / (GRU_SEQ_LENGTH * GRU_CELL_RUNTIME)) * GRU_DEADLINE;

    gru_retval[1]->children[1] = task[0];
    gru_retval[2]->children[0] = task[1];
    gru_retval[3]->children[0] = task[0];
    gru_retval[4] = task[1];
}

void init_gru()
{
    int size = NUM_PIXELS * 4;

    gru_ug_weight  = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    gru_ug_bias    = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    gru_rg_weight1 = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    gru_rg_bias1   = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    gru_rg_weight2 = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    gru_rg_bias2   = (float*) get_memory_aligned(size, CACHELINE_SIZE);

    gru_task_65536 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    gru_task_65536->output_size = 65536;
    gru_task_65536->status = REQ_STATUS_COMPLETED;

#ifdef VERIFY
    // the weight matter only if we are verifying the output
    for (int i = 0; i < NUM_PIXELS; i++) {
        gru_ug_weight[i] = (i % IMG_WIDTH) / 700000.0;
        gru_ug_bias[i]   = (i % IMG_WIDTH) / 100.0;

        gru_rg_weight1[i] = ((i % IMG_WIDTH) + 1) / 700000.0;
        gru_rg_bias1[i]   = ((i % IMG_WIDTH) + 1) / 100.0;
        gru_rg_weight2[i] = ((i % IMG_WIDTH) + 2) / 700000.0;
        gru_rg_bias2[i]   = ((i % IMG_WIDTH) + 2) / 100.0;
    }
#endif

    dcache_flush((uint32_t) gru_ug_weight  ,size);
    dcache_flush((uint32_t) gru_ug_bias    ,size);
    dcache_flush((uint32_t) gru_rg_weight1 ,size);
    dcache_flush((uint32_t) gru_rg_bias1   ,size);
    dcache_flush((uint32_t) gru_rg_weight2 ,size);
    dcache_flush((uint32_t) gru_rg_bias2   ,size);
}

void add_gru_dag(task_struct_t ***nodes, int *num_nodes, int num_frames)
{
    const int nodes_per_cell = 15;

    for (int i = 0; i < num_frames; i++) {
        for (int rep = 0; rep < NUM_REPEATS; rep++) {
            uint32_t earliest_start = GRU_DEADLINE - \
                                      (GRU_CELL_RUNTIME * GRU_SEQ_LENGTH);

            for (int j = 0; j < GRU_SEQ_LENGTH; j++) {
                int cell_index = (i * GRU_SEQ_LENGTH) + j;  // input seed
                int node_index = j * nodes_per_cell;
                gru_cell_data_t *cell = (gru_cell_data_t*) get_memory_aligned(
                        sizeof(gru_cell_data_t), CACHELINE_SIZE);

                gru_cell_init(cell, nodes[i], node_index, cell_index, j == 0,
                        earliest_start, rep);

                gru_update_gate(cell, nodes[i], node_index + 1, j == 0,
                        earliest_start, rep);

                gru_reset_gate(cell, nodes[i], node_index + 5, j == 0,
                        earliest_start, rep);

                gru_cell_output(cell, nodes[i], node_index + 13,
                        j == (GRU_SEQ_LENGTH - 1), earliest_start, rep,
                        rep == (NUM_REPEATS - 1));

                dcache_flush((uint32_t) cell, sizeof(gru_cell_data_t));

                earliest_start += GRU_CELL_RUNTIME;
            }
        }

        num_nodes[i] = GRU_NUM_NODES * NUM_REPEATS;
    }
}

void print_gru_output(task_struct_t ***nodes, int num_frames)
{
    printf("Printing gru results\n");
    printf("====================\n");
    int node_index = (15 * GRU_SEQ_LENGTH) - 1;

    for (int i = 0; i < num_frames; i++) {
        float *final_state =
            ((elem_matrix_args*)(nodes[i][node_index]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Frame %2d, pixel %2d, value = %f\n", i, j,
                    final_state[j]);
        }
    }
}
