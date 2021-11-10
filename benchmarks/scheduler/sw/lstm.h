#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

typedef struct {
    float data_input[NUM_PIXELS];
    float *cell_state_input;
    float *hidden_state_input;
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

void lstm_init_cell_data(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, int input_seed, bool is_first)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    int size = NUM_PIXELS * 4;

    if (is_first) {
        cell->cell_state_input = (float*) get_memory(size);
        cell->hidden_state_input = (float*) get_memory(size);
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
    if (is_first) {
        task->num_parents = 0;
        task->producer[0] = NULL;
        task->status = REQ_STATUS_READY;
    }
    else {
        task->num_parents = 1;
        task->producer[0] = lstm_retval[3];
        task->status = REQ_STATUS_WAITING;
        lstm_retval[3]->children[0] = task;
    }
    task->producer[1] = NULL;
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->completed_parents = 0;

    nodes[node_index] = task;

    lstm_retval[0] = task;
}

void lstm_forget_gate(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_first)
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
    task[0]->producer[0] = lstm_retval[0];

    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];

    task[2]->children[0] = task[3];
    task[2]->producer[0] = task[1];

    if (is_first) {
        task[3]->num_parents = 1;
        task[3]->producer[0] = NULL;
    }
    else {
        task[3]->num_parents = 2;
        task[3]->producer[0] = lstm_retval[2];
        lstm_retval[2]->children[1] = task[3];
    }
    task[3]->producer[1] = task[2];

    lstm_retval[0]->children[0] = task[0];
    lstm_retval[1] = task[3];
}

void lstm_input_gate(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_last)
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
    task[0]->producer[0] = lstm_retval[0];

    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];

    task[2]->children[0] = task[6];
    task[2]->producer[0] = task[1];

    task[3]->children[0] = task[4];
    task[3]->producer[0] = lstm_retval[0];

    task[4]->children[0] = task[5];
    task[4]->producer[0] = task[3];

    task[5]->children[0] = task[6];
    task[5]->producer[0] = task[4];

    task[6]->children[0] = task[7];
    task[6]->num_parents = 2;
    task[6]->producer[0] = task[2];
    task[6]->producer[1] = task[5];

    if (is_last) {
        task[7]->num_children = 1;
    }
    else {
        task[7]->num_children = 2;
    }
    task[7]->num_parents = 2;
    task[7]->producer[0] = lstm_retval[1];
    task[7]->producer[1] = task[6];

    lstm_retval[0]->children[1] = task[0];
    lstm_retval[0]->children[2] = task[3];
    lstm_retval[1]->children[0] = task[7];
    lstm_retval[2] = task[7];
}

void lstm_output_gate(lstm_cell_data_t *cell, task_struct_t **nodes,
        int node_index, bool is_last)
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
    task[0]->producer[0] = lstm_retval[0];

    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];

    task[2]->children[0] = task[4];
    task[2]->producer[0] = task[1];

    task[3]->children[0] = task[4];
    task[3]->producer[0] = lstm_retval[2];

    if (is_last) {
        task[4]->num_children = 0;
    }
    else {
        task[4]->num_children = 1;
    }
    task[4]->num_parents = 2;
    task[4]->producer[0] = task[3];
    task[4]->producer[1] = task[2];

    lstm_retval[0]->children[3] = task[0];
    lstm_retval[2]->children[0] = task[3];
    lstm_retval[3] = task[4];
}

void init_lstm()
{
    int size = NUM_PIXELS * 4;

    lstm_fg_weight  = (float*) get_memory(size);
    lstm_fg_bias    = (float*) get_memory(size);
    lstm_ig_weight1 = (float*) get_memory(size);
    lstm_ig_bias1   = (float*) get_memory(size);
    lstm_ig_weight2 = (float*) get_memory(size);
    lstm_ig_bias2   = (float*) get_memory(size);
    lstm_og_weight  = (float*) get_memory(size);
    lstm_og_bias    = (float*) get_memory(size);

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

void add_lstm_dag(task_struct_t ***nodes, int num_frames, int seq_length)
{
    const int nodes_per_cell = 18;

    lstm_cell_data_t *cells = (lstm_cell_data_t*)
        get_memory(num_frames * seq_length * sizeof(lstm_cell_data_t));

    for (int i = 0; i < num_frames; i++) {
        for (int j = 0; j < seq_length; j++) {
            int cell_index = (i * seq_length) + j;
            int node_index = j * nodes_per_cell;

            lstm_init_cell_data(&(cells[cell_index]), nodes[i], node_index,
                    cell_index, j == 0);

            lstm_forget_gate(&(cells[cell_index]), nodes[i], node_index + 1,
                    j == 0);

            lstm_input_gate(&(cells[cell_index]), nodes[i], node_index + 5,
                    j == (seq_length - 1));

            lstm_output_gate(&(cells[cell_index]), nodes[i], node_index + 13,
                    j == (seq_length - 1));
        }
    }
}

void print_lstm_output(task_struct_t ***nodes, int num_frames, int seq_length)
{
    printf("Printing lstm results\n");
    printf("=====================\n");
    int node_index = (18 * seq_length) - 1;

    for (int i = 0; i < num_frames; i++) {
        float *final_state =
            ((elem_matrix_args*)(nodes[i][node_index]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Frame %2d, pixel %2d, value = %f\n", i, j,
                    final_state[j]);
        }
    }
}
