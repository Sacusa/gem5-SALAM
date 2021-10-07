#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "runtime.h"

#define NUM_FRAMES 10
#define SEQ_LENGTH 1
#define ENABLE_FORWARDING
//#define VERIFY

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

float *fg_weight;
float *fg_bias;
float *ig_weight1;
float *ig_bias1;
float *ig_weight2;
float *ig_bias2;
float *og_weight;
float *og_bias;

task_struct_t *retval[3];

void init_weights()
{
    int size = NUM_PIXELS * 4;

    fg_weight  = (float*) get_memory(size);
    fg_bias    = (float*) get_memory(size);
    ig_weight1 = (float*) get_memory(size);
    ig_bias1   = (float*) get_memory(size);
    ig_weight2 = (float*) get_memory(size);
    ig_bias2   = (float*) get_memory(size);
    og_weight  = (float*) get_memory(size);
    og_bias    = (float*) get_memory(size);

    for (int i = 0; i < NUM_PIXELS; i++) {
        fg_weight[i] = (i % IMG_WIDTH) / 700000.0;
        fg_bias[i]   = (i % IMG_WIDTH) / 100.0;

        ig_weight1[i] = ((i % IMG_WIDTH) + 1) / 700000.0;
        ig_bias1[i]   = ((i % IMG_WIDTH) + 1) / 100.0;
        ig_weight2[i] = ((i % IMG_WIDTH) + 2) / 700000.0;
        ig_bias2[i]   = ((i % IMG_WIDTH) + 2) / 100.0;

        og_weight[i] = ((i % IMG_WIDTH) + 3) / 700000.0;
        og_bias[i]   = ((i % IMG_WIDTH) + 3) / 100.0;
    }
}

void init_cell_data(lstm_cell_data_t *cell, task_struct_t **nodes,
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
            (((elem_matrix_args*)(retval[2]->acc_args))->output);
        cell->hidden_state_input = (float*)
            (((elem_matrix_args*)(retval[3]->acc_args))->output);
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
        task->producer[0] = retval[3];
        task->status = REQ_STATUS_WAITING;
        retval[3]->children[0] = task;
    }
    task->producer[1] = NULL;
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->completed_parents = 0;

    nodes[node_index] = task;

    retval[0] = task;
}

void forget_gate(lstm_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_first)
{
    task_struct_t *task[4];
    elem_matrix_args *args[4];

    for (int i = 0; i < 4; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    int size = NUM_PIXELS * 4;

    args[0]->arg1 = (float*)(cell->cell_input);
    args[0]->arg2 = fg_weight;
    args[0]->output = (float*)(cell->fg_weighted_input);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->fg_weighted_input);
    args[1]->arg2 = fg_bias;
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
    task[0]->producer[0] = retval[0];

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
        task[3]->producer[0] = retval[2];
        retval[2]->children[1] = task[3];
    }
    task[3]->producer[1] = task[2];

    retval[0]->children[0] = task[0];
    retval[1] = task[3];
}

void input_gate(lstm_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_last)
{
    task_struct_t *task[8];
    elem_matrix_args *args[8];

    for (int i = 0; i < 8; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    int size = NUM_PIXELS * 4;

    args[0]->arg1 = (float*)(cell->cell_input);
    args[0]->arg2 = ig_weight1;
    args[0]->output = (float*)(cell->ig_weighted_input1);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->ig_weighted_input1);
    args[1]->arg2 = ig_bias1;
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
    args[3]->arg2 = ig_weight2;
    args[3]->output = (float*)(cell->ig_weighted_input2);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = MUL;
    args[3]->do_one_minus = 0;

    args[4]->arg1 = (float*)(cell->ig_weighted_input2);
    args[4]->arg2 = ig_bias2;
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
    task[0]->producer[0] = retval[0];

    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];

    task[2]->children[0] = task[6];
    task[2]->producer[0] = task[1];

    task[3]->children[0] = task[4];
    task[3]->producer[0] = retval[0];

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
    task[7]->producer[0] = retval[1];
    task[7]->producer[1] = task[6];

    retval[0]->children[1] = task[0];
    retval[0]->children[2] = task[3];
    retval[1]->children[0] = task[7];
    retval[2] = task[7];
}

void output_gate(lstm_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_last)
{
    task_struct_t *task[5];
    elem_matrix_args *args[5];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 5; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    args[0]->arg1 = (float*)(cell->cell_input);
    args[0]->arg2 = og_weight;
    args[0]->output = (float*)(cell->og_weighted_input);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->og_weighted_input);
    args[1]->arg2 = og_bias;
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
    task[0]->producer[0] = retval[0];

    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];

    task[2]->children[0] = task[4];
    task[2]->producer[0] = task[1];

    task[3]->children[0] = task[4];
    task[3]->producer[0] = retval[2];

    if (is_last) {
        task[4]->num_children = 0;
    }
    else {
        task[4]->num_children = 1;
    }
    task[4]->num_parents = 2;
    task[4]->producer[0] = task[3];
    task[4]->producer[1] = task[2];

    retval[0]->children[3] = task[0];
    retval[2]->children[0] = task[3];
    retval[3] = task[4];
}

void gedf(task_struct_t ***nodes)
{
    task_struct_t ****run_queue = (task_struct_t****)
        get_memory(NUM_ACCS * sizeof(task_struct_t***));
    int **run_queue_size = (int**) get_memory(NUM_ACCS * sizeof(int*));

    for (int i = 0; i < NUM_ACCS; i++) {
        run_queue[i] = (task_struct_t***)
            get_memory(MAX_ACC_INSTANCES * sizeof(task_struct_t**));
        run_queue_size[i] = (int*)
            get_memory(MAX_ACC_INSTANCES * sizeof(int));

        for (int j = 0; j < MAX_ACC_INSTANCES; j++) {
            run_queue[i][j] = (task_struct_t**)
                get_memory(MAX_NODES * sizeof(task_struct_t*));
        }
    }

    run_queue_size[0][0] = 0;
    run_queue_size[1][0] = 0;
    run_queue_size[1][1] = 0;
    run_queue_size[2][0] = 0;
    run_queue_size[3][0] = 45;
    run_queue[3][0][0] = nodes[0][0];
    run_queue[3][0][1] = nodes[4][0];
    run_queue[3][0][2] = nodes[8][0];
    run_queue[3][0][3] = nodes[0][8];
    run_queue[3][0][4] = nodes[2][1];
    run_queue[3][0][5] = nodes[3][5];
    run_queue[3][0][6] = nodes[4][8];
    run_queue[3][0][7] = nodes[6][1];
    run_queue[3][0][8] = nodes[7][5];
    run_queue[3][0][9] = nodes[8][8];
    run_queue[3][0][10] = nodes[0][2];
    run_queue[3][0][11] = nodes[1][6];
    run_queue[3][0][12] = nodes[2][9];
    run_queue[3][0][13] = nodes[4][2];
    run_queue[3][0][14] = nodes[5][6];
    run_queue[3][0][15] = nodes[6][9];
    run_queue[3][0][16] = nodes[8][2];
    run_queue[3][0][17] = nodes[9][6];
    run_queue[3][0][18] = nodes[1][7];
    run_queue[3][0][19] = nodes[2][10];
    run_queue[3][0][20] = nodes[4][3];
    run_queue[3][0][21] = nodes[5][7];
    run_queue[3][0][22] = nodes[6][10];
    run_queue[3][0][23] = nodes[8][3];
    run_queue[3][0][24] = nodes[9][7];
    run_queue[3][0][25] = nodes[2][13];
    run_queue[3][0][26] = nodes[6][13];
    run_queue[3][0][27] = nodes[0][4];
    run_queue[3][0][28] = nodes[2][4];
    run_queue[3][0][29] = nodes[4][4];
    run_queue[3][0][30] = nodes[6][4];
    run_queue[3][0][31] = nodes[8][4];
    run_queue[3][0][32] = nodes[0][14];
    run_queue[3][0][33] = nodes[4][14];
    run_queue[3][0][34] = nodes[8][14];
    run_queue[3][0][35] = nodes[2][12];
    run_queue[3][0][36] = nodes[6][12];
    run_queue[3][0][37] = nodes[0][15];
    run_queue[3][0][38] = nodes[2][15];
    run_queue[3][0][39] = nodes[6][15];
    run_queue[3][0][40] = nodes[0][16];
    run_queue[3][0][41] = nodes[4][16];
    run_queue[3][0][42] = nodes[8][16];
    run_queue[3][0][43] = nodes[2][17];
    run_queue[3][0][44] = nodes[6][17];
    run_queue_size[3][1] = 45;
    run_queue[3][1][0] = nodes[1][0];
    run_queue[3][1][1] = nodes[5][0];
    run_queue[3][1][2] = nodes[9][0];
    run_queue[3][1][3] = nodes[1][1];
    run_queue[3][1][4] = nodes[2][5];
    run_queue[3][1][5] = nodes[3][8];
    run_queue[3][1][6] = nodes[5][1];
    run_queue[3][1][7] = nodes[6][5];
    run_queue[3][1][8] = nodes[7][8];
    run_queue[3][1][9] = nodes[9][1];
    run_queue[3][1][10] = nodes[0][6];
    run_queue[3][1][11] = nodes[1][9];
    run_queue[3][1][12] = nodes[3][2];
    run_queue[3][1][13] = nodes[4][6];
    run_queue[3][1][14] = nodes[5][9];
    run_queue[3][1][15] = nodes[7][2];
    run_queue[3][1][16] = nodes[8][6];
    run_queue[3][1][17] = nodes[9][9];
    run_queue[3][1][18] = nodes[1][10];
    run_queue[3][1][19] = nodes[3][3];
    run_queue[3][1][20] = nodes[4][7];
    run_queue[3][1][21] = nodes[5][10];
    run_queue[3][1][22] = nodes[7][3];
    run_queue[3][1][23] = nodes[8][7];
    run_queue[3][1][24] = nodes[9][10];
    run_queue[3][1][25] = nodes[3][13];
    run_queue[3][1][26] = nodes[7][13];
    run_queue[3][1][27] = nodes[0][11];
    run_queue[3][1][28] = nodes[2][11];
    run_queue[3][1][29] = nodes[4][11];
    run_queue[3][1][30] = nodes[6][11];
    run_queue[3][1][31] = nodes[8][11];
    run_queue[3][1][32] = nodes[1][14];
    run_queue[3][1][33] = nodes[5][14];
    run_queue[3][1][34] = nodes[9][14];
    run_queue[3][1][35] = nodes[3][12];
    run_queue[3][1][36] = nodes[7][12];
    run_queue[3][1][37] = nodes[1][15];
    run_queue[3][1][38] = nodes[3][15];
    run_queue[3][1][39] = nodes[7][15];
    run_queue[3][1][40] = nodes[1][16];
    run_queue[3][1][41] = nodes[5][16];
    run_queue[3][1][42] = nodes[9][16];
    run_queue[3][1][43] = nodes[3][17];
    run_queue[3][1][44] = nodes[7][17];
    run_queue_size[3][2] = 45;
    run_queue[3][2][0] = nodes[2][0];
    run_queue[3][2][1] = nodes[6][0];
    run_queue[3][2][2] = nodes[0][1];
    run_queue[3][2][3] = nodes[1][5];
    run_queue[3][2][4] = nodes[2][8];
    run_queue[3][2][5] = nodes[4][1];
    run_queue[3][2][6] = nodes[5][5];
    run_queue[3][2][7] = nodes[6][8];
    run_queue[3][2][8] = nodes[8][1];
    run_queue[3][2][9] = nodes[9][5];
    run_queue[3][2][10] = nodes[0][9];
    run_queue[3][2][11] = nodes[2][2];
    run_queue[3][2][12] = nodes[3][6];
    run_queue[3][2][13] = nodes[4][9];
    run_queue[3][2][14] = nodes[6][2];
    run_queue[3][2][15] = nodes[7][6];
    run_queue[3][2][16] = nodes[8][9];
    run_queue[3][2][17] = nodes[0][3];
    run_queue[3][2][18] = nodes[0][10];
    run_queue[3][2][19] = nodes[2][3];
    run_queue[3][2][20] = nodes[3][7];
    run_queue[3][2][21] = nodes[4][10];
    run_queue[3][2][22] = nodes[6][3];
    run_queue[3][2][23] = nodes[7][7];
    run_queue[3][2][24] = nodes[8][10];
    run_queue[3][2][25] = nodes[0][13];
    run_queue[3][2][26] = nodes[4][13];
    run_queue[3][2][27] = nodes[8][13];
    run_queue[3][2][28] = nodes[1][4];
    run_queue[3][2][29] = nodes[3][4];
    run_queue[3][2][30] = nodes[5][4];
    run_queue[3][2][31] = nodes[7][4];
    run_queue[3][2][32] = nodes[9][4];
    run_queue[3][2][33] = nodes[2][14];
    run_queue[3][2][34] = nodes[6][14];
    run_queue[3][2][35] = nodes[0][12];
    run_queue[3][2][36] = nodes[4][12];
    run_queue[3][2][37] = nodes[8][12];
    run_queue[3][2][38] = nodes[4][15];
    run_queue[3][2][39] = nodes[8][15];
    run_queue[3][2][40] = nodes[2][16];
    run_queue[3][2][41] = nodes[6][16];
    run_queue[3][2][42] = nodes[0][17];
    run_queue[3][2][43] = nodes[4][17];
    run_queue[3][2][44] = nodes[8][17];
    run_queue_size[3][3] = 45;
    run_queue[3][3][0] = nodes[3][0];
    run_queue[3][3][1] = nodes[7][0];
    run_queue[3][3][2] = nodes[0][5];
    run_queue[3][3][3] = nodes[1][8];
    run_queue[3][3][4] = nodes[3][1];
    run_queue[3][3][5] = nodes[4][5];
    run_queue[3][3][6] = nodes[5][8];
    run_queue[3][3][7] = nodes[7][1];
    run_queue[3][3][8] = nodes[8][5];
    run_queue[3][3][9] = nodes[9][8];
    run_queue[3][3][10] = nodes[1][2];
    run_queue[3][3][11] = nodes[2][6];
    run_queue[3][3][12] = nodes[3][9];
    run_queue[3][3][13] = nodes[5][2];
    run_queue[3][3][14] = nodes[6][6];
    run_queue[3][3][15] = nodes[7][9];
    run_queue[3][3][16] = nodes[9][2];
    run_queue[3][3][17] = nodes[0][7];
    run_queue[3][3][18] = nodes[1][3];
    run_queue[3][3][19] = nodes[2][7];
    run_queue[3][3][20] = nodes[3][10];
    run_queue[3][3][21] = nodes[5][3];
    run_queue[3][3][22] = nodes[6][7];
    run_queue[3][3][23] = nodes[7][10];
    run_queue[3][3][24] = nodes[9][3];
    run_queue[3][3][25] = nodes[1][13];
    run_queue[3][3][26] = nodes[5][13];
    run_queue[3][3][27] = nodes[9][13];
    run_queue[3][3][28] = nodes[1][11];
    run_queue[3][3][29] = nodes[3][11];
    run_queue[3][3][30] = nodes[5][11];
    run_queue[3][3][31] = nodes[7][11];
    run_queue[3][3][32] = nodes[9][11];
    run_queue[3][3][33] = nodes[3][14];
    run_queue[3][3][34] = nodes[7][14];
    run_queue[3][3][35] = nodes[1][12];
    run_queue[3][3][36] = nodes[5][12];
    run_queue[3][3][37] = nodes[9][12];
    run_queue[3][3][38] = nodes[5][15];
    run_queue[3][3][39] = nodes[9][15];
    run_queue[3][3][40] = nodes[3][16];
    run_queue[3][3][41] = nodes[7][16];
    run_queue[3][3][42] = nodes[1][17];
    run_queue[3][3][43] = nodes[5][17];
    run_queue[3][3][44] = nodes[9][17];
    run_queue_size[4][0] = 0;
    run_queue_size[5][0] = 0;
    run_queue_size[6][0] = 0;
#ifdef ENABLE_FORWARDING
    nodes[0][0]->producer_forward[0] = 0;
    nodes[0][0]->producer_forward[1] = 0;
    nodes[4][0]->producer_forward[0] = 0;
    nodes[4][0]->producer_forward[1] = 0;
    nodes[8][0]->producer_forward[0] = 0;
    nodes[8][0]->producer_forward[1] = 0;
    nodes[0][8]->producer_forward[0] = 0;
    nodes[0][8]->producer_forward[1] = 0;
    nodes[2][1]->producer_forward[0] = 0;
    nodes[2][1]->producer_forward[1] = 0;
    nodes[3][5]->producer_forward[0] = 0;
    nodes[3][5]->producer_forward[1] = 0;
    nodes[4][8]->producer_forward[0] = 0;
    nodes[4][8]->producer_forward[1] = 0;
    nodes[6][1]->producer_forward[0] = 0;
    nodes[6][1]->producer_forward[1] = 0;
    nodes[7][5]->producer_forward[0] = 0;
    nodes[7][5]->producer_forward[1] = 0;
    nodes[8][8]->producer_forward[0] = 0;
    nodes[8][8]->producer_forward[1] = 0;
    nodes[0][2]->producer_forward[0] = 0;
    nodes[0][2]->producer_forward[1] = 0;
    nodes[1][6]->producer_forward[0] = 0;
    nodes[1][6]->producer_forward[1] = 0;
    nodes[2][9]->producer_forward[0] = 0;
    nodes[2][9]->producer_forward[1] = 0;
    nodes[4][2]->producer_forward[0] = 0;
    nodes[4][2]->producer_forward[1] = 0;
    nodes[5][6]->producer_forward[0] = 0;
    nodes[5][6]->producer_forward[1] = 0;
    nodes[6][9]->producer_forward[0] = 0;
    nodes[6][9]->producer_forward[1] = 0;
    nodes[8][2]->producer_forward[0] = 0;
    nodes[8][2]->producer_forward[1] = 0;
    nodes[9][6]->producer_forward[0] = 0;
    nodes[9][6]->producer_forward[1] = 0;
    nodes[1][7]->producer_forward[0] = 0;
    nodes[2][10]->producer_forward[0] = 0;
    nodes[4][3]->producer_forward[0] = 0;
    nodes[5][7]->producer_forward[0] = 0;
    nodes[6][10]->producer_forward[0] = 0;
    nodes[8][3]->producer_forward[0] = 0;
    nodes[9][7]->producer_forward[0] = 0;
    nodes[2][13]->producer_forward[0] = 0;
    nodes[2][13]->producer_forward[1] = 0;
    nodes[6][13]->producer_forward[0] = 0;
    nodes[6][13]->producer_forward[1] = 0;
    nodes[0][4]->producer_forward[0] = 0;
    nodes[0][4]->producer_forward[1] = 0;
    nodes[2][4]->producer_forward[0] = 0;
    nodes[2][4]->producer_forward[1] = 0;
    nodes[4][4]->producer_forward[0] = 0;
    nodes[4][4]->producer_forward[1] = 0;
    nodes[6][4]->producer_forward[0] = 0;
    nodes[6][4]->producer_forward[1] = 0;
    nodes[8][4]->producer_forward[0] = 0;
    nodes[8][4]->producer_forward[1] = 0;
    nodes[0][14]->producer_forward[0] = 0;
    nodes[0][14]->producer_forward[1] = 0;
    nodes[4][14]->producer_forward[0] = 0;
    nodes[4][14]->producer_forward[1] = 0;
    nodes[8][14]->producer_forward[0] = 0;
    nodes[8][14]->producer_forward[1] = 0;
    nodes[2][12]->producer_forward[0] = 0;
    nodes[2][12]->producer_forward[1] = 0;
    nodes[6][12]->producer_forward[0] = 0;
    nodes[6][12]->producer_forward[1] = 0;
    nodes[0][15]->producer_forward[0] = 0;
    nodes[2][15]->producer_forward[0] = 0;
    nodes[6][15]->producer_forward[0] = 0;
    nodes[0][16]->producer_forward[0] = 0;
    nodes[4][16]->producer_forward[0] = 0;
    nodes[8][16]->producer_forward[0] = 0;
    nodes[2][17]->producer_forward[0] = 0;
    nodes[2][17]->producer_forward[1] = 0;
    nodes[6][17]->producer_forward[0] = 0;
    nodes[6][17]->producer_forward[1] = 0;
    nodes[1][0]->producer_forward[0] = 0;
    nodes[1][0]->producer_forward[1] = 0;
    nodes[5][0]->producer_forward[0] = 0;
    nodes[5][0]->producer_forward[1] = 0;
    nodes[9][0]->producer_forward[0] = 0;
    nodes[9][0]->producer_forward[1] = 0;
    nodes[1][1]->producer_forward[0] = 0;
    nodes[1][1]->producer_forward[1] = 0;
    nodes[2][5]->producer_forward[0] = 0;
    nodes[2][5]->producer_forward[1] = 0;
    nodes[3][8]->producer_forward[0] = 0;
    nodes[3][8]->producer_forward[1] = 0;
    nodes[5][1]->producer_forward[0] = 0;
    nodes[5][1]->producer_forward[1] = 0;
    nodes[6][5]->producer_forward[0] = 0;
    nodes[6][5]->producer_forward[1] = 0;
    nodes[7][8]->producer_forward[0] = 0;
    nodes[7][8]->producer_forward[1] = 0;
    nodes[9][1]->producer_forward[0] = 0;
    nodes[9][1]->producer_forward[1] = 0;
    nodes[0][6]->producer_forward[0] = 0;
    nodes[0][6]->producer_forward[1] = 0;
    nodes[1][9]->producer_forward[0] = 0;
    nodes[1][9]->producer_forward[1] = 0;
    nodes[3][2]->producer_forward[0] = 0;
    nodes[3][2]->producer_forward[1] = 0;
    nodes[4][6]->producer_forward[0] = 0;
    nodes[4][6]->producer_forward[1] = 0;
    nodes[5][9]->producer_forward[0] = 0;
    nodes[5][9]->producer_forward[1] = 0;
    nodes[7][2]->producer_forward[0] = 0;
    nodes[7][2]->producer_forward[1] = 0;
    nodes[8][6]->producer_forward[0] = 0;
    nodes[8][6]->producer_forward[1] = 0;
    nodes[9][9]->producer_forward[0] = 0;
    nodes[9][9]->producer_forward[1] = 0;
    nodes[1][10]->producer_forward[0] = 0;
    nodes[3][3]->producer_forward[0] = 0;
    nodes[4][7]->producer_forward[0] = 0;
    nodes[5][10]->producer_forward[0] = 0;
    nodes[7][3]->producer_forward[0] = 0;
    nodes[8][7]->producer_forward[0] = 0;
    nodes[9][10]->producer_forward[0] = 0;
    nodes[3][13]->producer_forward[0] = 0;
    nodes[3][13]->producer_forward[1] = 0;
    nodes[7][13]->producer_forward[0] = 0;
    nodes[7][13]->producer_forward[1] = 0;
    nodes[0][11]->producer_forward[0] = 0;
    nodes[0][11]->producer_forward[1] = 0;
    nodes[2][11]->producer_forward[0] = 0;
    nodes[2][11]->producer_forward[1] = 0;
    nodes[4][11]->producer_forward[0] = 0;
    nodes[4][11]->producer_forward[1] = 0;
    nodes[6][11]->producer_forward[0] = 0;
    nodes[6][11]->producer_forward[1] = 0;
    nodes[8][11]->producer_forward[0] = 0;
    nodes[8][11]->producer_forward[1] = 0;
    nodes[1][14]->producer_forward[0] = 0;
    nodes[1][14]->producer_forward[1] = 0;
    nodes[5][14]->producer_forward[0] = 0;
    nodes[5][14]->producer_forward[1] = 0;
    nodes[9][14]->producer_forward[0] = 0;
    nodes[9][14]->producer_forward[1] = 0;
    nodes[3][12]->producer_forward[0] = 0;
    nodes[3][12]->producer_forward[1] = 0;
    nodes[7][12]->producer_forward[0] = 0;
    nodes[7][12]->producer_forward[1] = 0;
    nodes[1][15]->producer_forward[0] = 0;
    nodes[3][15]->producer_forward[0] = 0;
    nodes[7][15]->producer_forward[0] = 0;
    nodes[1][16]->producer_forward[0] = 0;
    nodes[5][16]->producer_forward[0] = 0;
    nodes[9][16]->producer_forward[0] = 0;
    nodes[3][17]->producer_forward[0] = 0;
    nodes[3][17]->producer_forward[1] = 0;
    nodes[7][17]->producer_forward[0] = 0;
    nodes[7][17]->producer_forward[1] = 0;
    nodes[2][0]->producer_forward[0] = 0;
    nodes[2][0]->producer_forward[1] = 0;
    nodes[6][0]->producer_forward[0] = 0;
    nodes[6][0]->producer_forward[1] = 0;
    nodes[0][1]->producer_forward[0] = 0;
    nodes[0][1]->producer_forward[1] = 0;
    nodes[1][5]->producer_forward[0] = 0;
    nodes[1][5]->producer_forward[1] = 0;
    nodes[2][8]->producer_forward[0] = 0;
    nodes[2][8]->producer_forward[1] = 0;
    nodes[4][1]->producer_forward[0] = 0;
    nodes[4][1]->producer_forward[1] = 0;
    nodes[5][5]->producer_forward[0] = 0;
    nodes[5][5]->producer_forward[1] = 0;
    nodes[6][8]->producer_forward[0] = 0;
    nodes[6][8]->producer_forward[1] = 0;
    nodes[8][1]->producer_forward[0] = 0;
    nodes[8][1]->producer_forward[1] = 0;
    nodes[9][5]->producer_forward[0] = 0;
    nodes[9][5]->producer_forward[1] = 0;
    nodes[0][9]->producer_forward[0] = 0;
    nodes[0][9]->producer_forward[1] = 0;
    nodes[2][2]->producer_forward[0] = 0;
    nodes[2][2]->producer_forward[1] = 0;
    nodes[3][6]->producer_forward[0] = 0;
    nodes[3][6]->producer_forward[1] = 0;
    nodes[4][9]->producer_forward[0] = 0;
    nodes[4][9]->producer_forward[1] = 0;
    nodes[6][2]->producer_forward[0] = 0;
    nodes[6][2]->producer_forward[1] = 0;
    nodes[7][6]->producer_forward[0] = 0;
    nodes[7][6]->producer_forward[1] = 0;
    nodes[8][9]->producer_forward[0] = 0;
    nodes[8][9]->producer_forward[1] = 0;
    nodes[0][3]->producer_forward[0] = 0;
    nodes[0][10]->producer_forward[0] = 0;
    nodes[2][3]->producer_forward[0] = 0;
    nodes[3][7]->producer_forward[0] = 0;
    nodes[4][10]->producer_forward[0] = 0;
    nodes[6][3]->producer_forward[0] = 0;
    nodes[7][7]->producer_forward[0] = 0;
    nodes[8][10]->producer_forward[0] = 0;
    nodes[0][13]->producer_forward[0] = 0;
    nodes[0][13]->producer_forward[1] = 0;
    nodes[4][13]->producer_forward[0] = 0;
    nodes[4][13]->producer_forward[1] = 0;
    nodes[8][13]->producer_forward[0] = 0;
    nodes[8][13]->producer_forward[1] = 0;
    nodes[1][4]->producer_forward[0] = 0;
    nodes[1][4]->producer_forward[1] = 0;
    nodes[3][4]->producer_forward[0] = 0;
    nodes[3][4]->producer_forward[1] = 0;
    nodes[5][4]->producer_forward[0] = 0;
    nodes[5][4]->producer_forward[1] = 0;
    nodes[7][4]->producer_forward[0] = 0;
    nodes[7][4]->producer_forward[1] = 0;
    nodes[9][4]->producer_forward[0] = 0;
    nodes[9][4]->producer_forward[1] = 0;
    nodes[2][14]->producer_forward[0] = 0;
    nodes[2][14]->producer_forward[1] = 0;
    nodes[6][14]->producer_forward[0] = 0;
    nodes[6][14]->producer_forward[1] = 0;
    nodes[0][12]->producer_forward[0] = 0;
    nodes[0][12]->producer_forward[1] = 0;
    nodes[4][12]->producer_forward[0] = 0;
    nodes[4][12]->producer_forward[1] = 0;
    nodes[8][12]->producer_forward[0] = 0;
    nodes[8][12]->producer_forward[1] = 0;
    nodes[4][15]->producer_forward[0] = 0;
    nodes[8][15]->producer_forward[0] = 0;
    nodes[2][16]->producer_forward[0] = 0;
    nodes[6][16]->producer_forward[0] = 0;
    nodes[0][17]->producer_forward[0] = 0;
    nodes[0][17]->producer_forward[1] = 0;
    nodes[4][17]->producer_forward[0] = 0;
    nodes[4][17]->producer_forward[1] = 0;
    nodes[8][17]->producer_forward[0] = 0;
    nodes[8][17]->producer_forward[1] = 0;
    nodes[3][0]->producer_forward[0] = 0;
    nodes[3][0]->producer_forward[1] = 0;
    nodes[7][0]->producer_forward[0] = 0;
    nodes[7][0]->producer_forward[1] = 0;
    nodes[0][5]->producer_forward[0] = 0;
    nodes[0][5]->producer_forward[1] = 0;
    nodes[1][8]->producer_forward[0] = 0;
    nodes[1][8]->producer_forward[1] = 0;
    nodes[3][1]->producer_forward[0] = 0;
    nodes[3][1]->producer_forward[1] = 0;
    nodes[4][5]->producer_forward[0] = 0;
    nodes[4][5]->producer_forward[1] = 0;
    nodes[5][8]->producer_forward[0] = 0;
    nodes[5][8]->producer_forward[1] = 0;
    nodes[7][1]->producer_forward[0] = 0;
    nodes[7][1]->producer_forward[1] = 0;
    nodes[8][5]->producer_forward[0] = 0;
    nodes[8][5]->producer_forward[1] = 0;
    nodes[9][8]->producer_forward[0] = 0;
    nodes[9][8]->producer_forward[1] = 0;
    nodes[1][2]->producer_forward[0] = 0;
    nodes[1][2]->producer_forward[1] = 0;
    nodes[2][6]->producer_forward[0] = 0;
    nodes[2][6]->producer_forward[1] = 0;
    nodes[3][9]->producer_forward[0] = 0;
    nodes[3][9]->producer_forward[1] = 0;
    nodes[5][2]->producer_forward[0] = 0;
    nodes[5][2]->producer_forward[1] = 0;
    nodes[6][6]->producer_forward[0] = 0;
    nodes[6][6]->producer_forward[1] = 0;
    nodes[7][9]->producer_forward[0] = 0;
    nodes[7][9]->producer_forward[1] = 0;
    nodes[9][2]->producer_forward[0] = 0;
    nodes[9][2]->producer_forward[1] = 0;
    nodes[0][7]->producer_forward[0] = 0;
    nodes[1][3]->producer_forward[0] = 0;
    nodes[2][7]->producer_forward[0] = 0;
    nodes[3][10]->producer_forward[0] = 0;
    nodes[5][3]->producer_forward[0] = 0;
    nodes[6][7]->producer_forward[0] = 0;
    nodes[7][10]->producer_forward[0] = 0;
    nodes[9][3]->producer_forward[0] = 0;
    nodes[1][13]->producer_forward[0] = 0;
    nodes[1][13]->producer_forward[1] = 0;
    nodes[5][13]->producer_forward[0] = 0;
    nodes[5][13]->producer_forward[1] = 0;
    nodes[9][13]->producer_forward[0] = 0;
    nodes[9][13]->producer_forward[1] = 0;
    nodes[1][11]->producer_forward[0] = 0;
    nodes[1][11]->producer_forward[1] = 0;
    nodes[3][11]->producer_forward[0] = 0;
    nodes[3][11]->producer_forward[1] = 0;
    nodes[5][11]->producer_forward[0] = 0;
    nodes[5][11]->producer_forward[1] = 0;
    nodes[7][11]->producer_forward[0] = 0;
    nodes[7][11]->producer_forward[1] = 0;
    nodes[9][11]->producer_forward[0] = 0;
    nodes[9][11]->producer_forward[1] = 0;
    nodes[3][14]->producer_forward[0] = 0;
    nodes[3][14]->producer_forward[1] = 0;
    nodes[7][14]->producer_forward[0] = 0;
    nodes[7][14]->producer_forward[1] = 0;
    nodes[1][12]->producer_forward[0] = 0;
    nodes[1][12]->producer_forward[1] = 0;
    nodes[5][12]->producer_forward[0] = 0;
    nodes[5][12]->producer_forward[1] = 0;
    nodes[9][12]->producer_forward[0] = 0;
    nodes[9][12]->producer_forward[1] = 0;
    nodes[5][15]->producer_forward[0] = 0;
    nodes[9][15]->producer_forward[0] = 0;
    nodes[3][16]->producer_forward[0] = 0;
    nodes[7][16]->producer_forward[0] = 0;
    nodes[1][17]->producer_forward[0] = 0;
    nodes[1][17]->producer_forward[1] = 0;
    nodes[5][17]->producer_forward[0] = 0;
    nodes[5][17]->producer_forward[1] = 0;
    nodes[9][17]->producer_forward[0] = 0;
    nodes[9][17]->producer_forward[1] = 0;
#endif

    schedule(run_queue, run_queue_size);
}

void aprx(task_struct_t ***nodes)
{
    task_struct_t ****run_queue = (task_struct_t****)
        get_memory(NUM_ACCS * sizeof(task_struct_t***));
    int **run_queue_size = (int**) get_memory(NUM_ACCS * sizeof(int*));

    for (int i = 0; i < NUM_ACCS; i++) {
        run_queue[i] = (task_struct_t***)
            get_memory(MAX_ACC_INSTANCES * sizeof(task_struct_t**));
        run_queue_size[i] = (int*)
            get_memory(MAX_ACC_INSTANCES * sizeof(int));

        for (int j = 0; j < MAX_ACC_INSTANCES; j++) {
            run_queue[i][j] = (task_struct_t**)
                get_memory(MAX_NODES * sizeof(task_struct_t*));
        }
    }

    schedule(run_queue, run_queue_size);
}

int main(int argc, char *argv[])
{
    m5_reset_stats();

    lstm_cell_data_t *cells = (lstm_cell_data_t*)
        get_memory(NUM_FRAMES * SEQ_LENGTH * sizeof(lstm_cell_data_t));
    task_struct_t ***nodes = (task_struct_t***)
        get_memory(MAX_DAGS * sizeof(task_struct_t**));
    for (int i = 0; i < MAX_DAGS; i++) {
        nodes[i] = (task_struct_t **)
            get_memory(MAX_NODES * sizeof(task_struct_t*));
    }

    init_weights();

    for (int i = 0; i < NUM_FRAMES; i++) {
        for (int j = 0; j < SEQ_LENGTH; j++) {
            int cell_index = (i * SEQ_LENGTH) + j;

            init_cell_data(&(cells[cell_index]), nodes[i], 0, cell_index,
                    j == 0);

            forget_gate(&(cells[cell_index]), nodes[i], 1, j == 0);

            input_gate(&(cells[cell_index]), nodes[i], 5,
                    j == (SEQ_LENGTH - 1));

            output_gate(&(cells[cell_index]), nodes[i], 13,
                    j == (SEQ_LENGTH - 1));
        }
    }

    gedf(nodes);
    //aprx(nodes);

#ifdef VERIFY
    for (int i = 0; i < NUM_FRAMES; i++) {
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Frame %2d, pixel %2d, value = %f\n", i, j,
                    cells[i].og_output[j]);
        }
    }
#endif

    m5_dump_stats();
    m5_exit();
}
