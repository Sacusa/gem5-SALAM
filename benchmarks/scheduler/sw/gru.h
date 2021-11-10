#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

typedef struct {
    float data_input[NUM_PIXELS];
    float *hidden_state_input;
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
} gru_cell_data_t;

float *gru_ug_weight;
float *gru_ug_bias;
float *gru_rg_weight1;
float *gru_rg_bias1;
float *gru_rg_weight2;
float *gru_rg_bias2;
task_struct_t *gru_retval[5];

void gru_cell_init(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
        int input_seed, bool is_first)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    if (is_first) {
        cell->hidden_state_input = (float*) get_memory(NUM_PIXELS * 4);
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
    if (is_first) {
        task->num_parents = 0;
        task->producer[0] = NULL;
        task->status = REQ_STATUS_READY;
    }
    else {
        task->num_parents = 1;
        task->producer[0] = gru_retval[4];
        task->status = REQ_STATUS_WAITING;
        gru_retval[4]->children[0] = task;
    }
    task->producer[1] = NULL;
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->completed_parents = 0;

    nodes[node_index] = task;

    gru_retval[0] = task;
}

void gru_update_gate(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_first)
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
        task[i]->num_parents = 1;
        task[i]->producer[0] = NULL;
        task[i]->producer[1] = NULL;
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;

        nodes[node_index + i] = task[i];
    }

    task[0]->children[0] = task[1];
    task[0]->producer[0] = gru_retval[0];

    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];

    task[2]->num_children = 2;
    task[2]->children[0] = task[3];
    task[2]->producer[0] = task[1];

    if (is_first) {
        task[3]->producer[1] = task[2];
    } else {
        task[3]->num_parents = 2;
        task[3]->producer[0] = gru_retval[4];
        task[3]->producer[1] = task[2];
        gru_retval[4]->children[1] = task[3];
    }

    gru_retval[0]->children[0] = task[0];
    gru_retval[1] = task[2];
    gru_retval[2] = task[3];
}

void gru_reset_gate(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_first)
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
        task[i]->producer[0] = NULL;
        task[i]->producer[1] = NULL;
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;

        nodes[node_index + i] = task[i];
    }

    task[0]->children[0] = task[1];
    task[0]->num_parents = 1;
    task[0]->producer[0] = gru_retval[0];

    task[1]->children[0] = task[2];
    task[1]->num_parents = 1;
    task[1]->producer[0] = task[0];

    task[2]->children[0] = task[3];
    task[2]->num_parents = 1;
    task[2]->producer[0] = task[1];

    task[3]->children[0] = task[4];
    if (is_first) {
        task[3]->num_parents = 1;
        task[3]->producer[0] = task[2];
    }
    else {
        task[3]->num_parents = 2;
        task[3]->producer[0] = task[2];
        task[3]->producer[1] = gru_retval[4];
        gru_retval[4]->children[2] = task[3];
    }

    task[4]->children[0] = task[5];
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[3];

    task[5]->children[0] = task[6];
    task[5]->num_parents = 1;
    task[5]->producer[0] = task[4];

    task[6]->children[0] = task[7];
    task[6]->num_parents = 1;
    task[6]->producer[0] = task[5];

    task[7]->children[0] = task[8];
    task[7]->num_parents = 1;
    task[7]->producer[0] = task[6];

    gru_retval[0]->children[1] = task[0];
    gru_retval[3] = task[7];
}

void gru_cell_output(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_last)
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
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;

        nodes[node_index + i] = task[i];
    }

    task[0]->num_children = 1;
    task[0]->children[0] = task[1];
    task[0]->producer[0] = gru_retval[1];
    task[0]->producer[1] = gru_retval[3];

    if (is_last) {
        task[1]->num_children = 0;
    } else {
        task[1]->num_children = 3;
    }
    task[1]->producer[0] = gru_retval[2];
    task[1]->producer[1] = task[0];

    gru_retval[1]->children[1] = task[0];
    gru_retval[2]->children[0] = task[1];
    gru_retval[3]->children[0] = task[0];
    gru_retval[4] = task[1];
}

void init_gru()
{
    int size = NUM_PIXELS * 4;

    gru_ug_weight  = (float*) get_memory(size);
    gru_ug_bias    = (float*) get_memory(size);
    gru_rg_weight1 = (float*) get_memory(size);
    gru_rg_bias1   = (float*) get_memory(size);
    gru_rg_weight2 = (float*) get_memory(size);
    gru_rg_bias2   = (float*) get_memory(size);

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
}

void add_gru_dag(task_struct_t ***nodes, int num_frames, int seq_length)
{
    const int nodes_per_cell = 15;

    gru_cell_data_t *cells = (gru_cell_data_t*)
        get_memory(num_frames * seq_length * sizeof(gru_cell_data_t));

    for (int i = 0; i < num_frames; i++) {
        for (int j = 0; j < seq_length; j++) {
            int cell_index = (i * seq_length) + j;
            int node_index = j * nodes_per_cell;

            gru_cell_init(&(cells[cell_index]), nodes[i], node_index,
                    cell_index, j == 0);

            gru_update_gate(&(cells[cell_index]), nodes[i], node_index + 1,
                    j == 0);

            gru_reset_gate(&(cells[cell_index]), nodes[i], node_index + 5,
                    j == 0);

            gru_cell_output(&(cells[cell_index]), nodes[i], node_index + 13,
                    j == (seq_length - 1));
        }
    }
}

void print_gru_output(task_struct_t ***nodes, int num_frames, int seq_length)
{
    printf("Printing gru results\n");
    printf("====================\n");
    int node_index = (15 * seq_length) - 1;

    for (int i = 0; i < num_frames; i++) {
        float *final_state =
            ((elem_matrix_args*)(nodes[i][node_index]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Frame %2d, pixel %2d, value = %f\n", i, j,
                    final_state[j]);
        }
    }
}
