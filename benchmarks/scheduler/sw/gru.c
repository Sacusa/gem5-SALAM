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

task_struct_t *retval[5];

float *ug_weight;
float *ug_bias;
float *rg_weight1;
float *rg_bias1;
float *rg_weight2;
float *rg_bias2;

void init_weights()
{
    int size = NUM_PIXELS * 4;

    ug_weight  = (float*) get_memory(size);
    ug_bias    = (float*) get_memory(size);
    rg_weight1 = (float*) get_memory(size);
    rg_bias1   = (float*) get_memory(size);
    rg_weight2 = (float*) get_memory(size);
    rg_bias2   = (float*) get_memory(size);

    for (int i = 0; i < NUM_PIXELS; i++) {
        ug_weight[i] = (i % IMG_WIDTH) / 700000.0;
        ug_bias[i]   = (i % IMG_WIDTH) / 100.0;

        rg_weight1[i] = ((i % IMG_WIDTH) + 1) / 700000.0;
        rg_bias1[i]   = ((i % IMG_WIDTH) + 1) / 100.0;
        rg_weight2[i] = ((i % IMG_WIDTH) + 2) / 700000.0;
        rg_bias2[i]   = ((i % IMG_WIDTH) + 2) / 100.0;
    }
}

void cell_init(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
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
            (((elem_matrix_args*)(retval[4]->acc_args))->output);
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
        task->producer[0] = retval[4];
        task->status = REQ_STATUS_WAITING;
        retval[4]->children[0] = task;
    }
    task->producer[1] = NULL;
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->completed_parents = 0;

    nodes[node_index] = task;

    retval[0] = task;
}

void update_gate(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
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
            ((elem_matrix_args*)(retval[3]->acc_args))->output;
    }

    args[0]->arg1 = cell->hidden_state_input;
    args[0]->arg2 = ug_weight;
    args[0]->output = (float*)(cell->ug_weighted_state);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->ug_weighted_state);
    args[1]->arg2 = ug_bias;
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
    task[0]->producer[0] = retval[0];

    task[1]->children[0] = task[2];
    task[1]->producer[0] = task[0];

    task[2]->num_children = 2;
    task[2]->children[0] = task[3];
    task[2]->producer[0] = task[1];

    if (is_first) {
        task[3]->producer[1] = task[2];
    } else {
        task[3]->num_parents = 2;
        task[3]->producer[0] = retval[4];
        task[3]->producer[1] = task[2];
        retval[4]->children[1] = task[3];
    }

    retval[0]->children[0] = task[0];
    retval[1] = task[2];
    retval[2] = task[3];
}

void reset_gate(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
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
            ((elem_matrix_args*)(retval[3]->acc_args))->output;
    }

    args[0]->arg1 = (float*)(cell->cell_state);
    args[0]->arg2 = rg_weight1;
    args[0]->output = (float*)(cell->rg_weighted_state);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->rg_weighted_state);
    args[1]->arg2 = rg_bias1;
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
    args[5]->arg2 = rg_weight2;
    args[5]->output = (float*)(cell->rg_mult_out2);
    args[5]->is_arg2_scalar = 0;
    args[5]->op = MUL;
    args[5]->do_one_minus = 0;

    args[6]->arg1 = (float*)(cell->rg_mult_out2);
    args[6]->arg2 = rg_bias2;
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
    task[0]->producer[0] = retval[0];

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
        task[3]->producer[1] = retval[4];
        retval[4]->children[2] = task[3];
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

    retval[0]->children[1] = task[0];
    retval[3] = task[7];
}

void cell_output(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
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
    task[0]->producer[0] = retval[1];
    task[0]->producer[1] = retval[3];

    if (is_last) {
        task[1]->num_children = 0;
    } else {
        task[1]->num_children = 3;
    }
    task[1]->producer[0] = retval[2];
    task[1]->producer[1] = task[0];

    retval[1]->children[1] = task[0];
    retval[2]->children[0] = task[1];
    retval[3]->children[0] = task[0];
    retval[4] = task[1];
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
    run_queue_size[3][0] = 37;
    run_queue[3][0][0] = nodes[0][0];
    run_queue[3][0][1] = nodes[4][0];
    run_queue[3][0][2] = nodes[8][0];
    run_queue[3][0][3] = nodes[2][5];
    run_queue[3][0][4] = nodes[6][5];
    run_queue[3][0][5] = nodes[0][6];
    run_queue[3][0][6] = nodes[4][6];
    run_queue[3][0][7] = nodes[8][6];
    run_queue[3][0][8] = nodes[4][7];
    run_queue[3][0][9] = nodes[8][7];
    run_queue[3][0][10] = nodes[2][8];
    run_queue[3][0][11] = nodes[6][8];
    run_queue[3][0][12] = nodes[0][9];
    run_queue[3][0][13] = nodes[4][9];
    run_queue[3][0][14] = nodes[8][9];
    run_queue[3][0][15] = nodes[2][1];
    run_queue[3][0][16] = nodes[6][1];
    run_queue[3][0][17] = nodes[0][10];
    run_queue[3][0][18] = nodes[4][10];
    run_queue[3][0][19] = nodes[8][10];
    run_queue[3][0][20] = nodes[2][2];
    run_queue[3][0][21] = nodes[6][2];
    run_queue[3][0][22] = nodes[0][11];
    run_queue[3][0][23] = nodes[4][11];
    run_queue[3][0][24] = nodes[8][11];
    run_queue[3][0][25] = nodes[2][3];
    run_queue[3][0][26] = nodes[6][3];
    run_queue[3][0][27] = nodes[0][12];
    run_queue[3][0][28] = nodes[4][12];
    run_queue[3][0][29] = nodes[8][12];
    run_queue[3][0][30] = nodes[2][4];
    run_queue[3][0][31] = nodes[6][4];
    run_queue[3][0][32] = nodes[0][13];
    run_queue[3][0][33] = nodes[4][13];
    run_queue[3][0][34] = nodes[8][13];
    run_queue[3][0][35] = nodes[2][14];
    run_queue[3][0][36] = nodes[6][14];
    run_queue_size[3][1] = 37;
    run_queue[3][1][0] = nodes[1][0];
    run_queue[3][1][1] = nodes[5][0];
    run_queue[3][1][2] = nodes[9][0];
    run_queue[3][1][3] = nodes[3][5];
    run_queue[3][1][4] = nodes[7][5];
    run_queue[3][1][5] = nodes[1][6];
    run_queue[3][1][6] = nodes[5][6];
    run_queue[3][1][7] = nodes[9][6];
    run_queue[3][1][8] = nodes[5][7];
    run_queue[3][1][9] = nodes[9][7];
    run_queue[3][1][10] = nodes[3][8];
    run_queue[3][1][11] = nodes[7][8];
    run_queue[3][1][12] = nodes[1][9];
    run_queue[3][1][13] = nodes[5][9];
    run_queue[3][1][14] = nodes[9][9];
    run_queue[3][1][15] = nodes[3][1];
    run_queue[3][1][16] = nodes[7][1];
    run_queue[3][1][17] = nodes[1][10];
    run_queue[3][1][18] = nodes[5][10];
    run_queue[3][1][19] = nodes[9][10];
    run_queue[3][1][20] = nodes[3][2];
    run_queue[3][1][21] = nodes[7][2];
    run_queue[3][1][22] = nodes[1][11];
    run_queue[3][1][23] = nodes[5][11];
    run_queue[3][1][24] = nodes[9][11];
    run_queue[3][1][25] = nodes[3][3];
    run_queue[3][1][26] = nodes[7][3];
    run_queue[3][1][27] = nodes[1][12];
    run_queue[3][1][28] = nodes[5][12];
    run_queue[3][1][29] = nodes[9][12];
    run_queue[3][1][30] = nodes[3][4];
    run_queue[3][1][31] = nodes[7][4];
    run_queue[3][1][32] = nodes[1][13];
    run_queue[3][1][33] = nodes[5][13];
    run_queue[3][1][34] = nodes[9][13];
    run_queue[3][1][35] = nodes[3][14];
    run_queue[3][1][36] = nodes[7][14];
    run_queue_size[3][2] = 38;
    run_queue[3][2][0] = nodes[2][0];
    run_queue[3][2][1] = nodes[6][0];
    run_queue[3][2][2] = nodes[0][5];
    run_queue[3][2][3] = nodes[4][5];
    run_queue[3][2][4] = nodes[8][5];
    run_queue[3][2][5] = nodes[2][6];
    run_queue[3][2][6] = nodes[6][6];
    run_queue[3][2][7] = nodes[0][7];
    run_queue[3][2][8] = nodes[2][7];
    run_queue[3][2][9] = nodes[6][7];
    run_queue[3][2][10] = nodes[0][8];
    run_queue[3][2][11] = nodes[4][8];
    run_queue[3][2][12] = nodes[8][8];
    run_queue[3][2][13] = nodes[2][9];
    run_queue[3][2][14] = nodes[6][9];
    run_queue[3][2][15] = nodes[0][1];
    run_queue[3][2][16] = nodes[4][1];
    run_queue[3][2][17] = nodes[8][1];
    run_queue[3][2][18] = nodes[2][10];
    run_queue[3][2][19] = nodes[6][10];
    run_queue[3][2][20] = nodes[0][2];
    run_queue[3][2][21] = nodes[4][2];
    run_queue[3][2][22] = nodes[8][2];
    run_queue[3][2][23] = nodes[2][11];
    run_queue[3][2][24] = nodes[6][11];
    run_queue[3][2][25] = nodes[0][3];
    run_queue[3][2][26] = nodes[4][3];
    run_queue[3][2][27] = nodes[8][3];
    run_queue[3][2][28] = nodes[2][12];
    run_queue[3][2][29] = nodes[6][12];
    run_queue[3][2][30] = nodes[0][4];
    run_queue[3][2][31] = nodes[4][4];
    run_queue[3][2][32] = nodes[8][4];
    run_queue[3][2][33] = nodes[2][13];
    run_queue[3][2][34] = nodes[6][13];
    run_queue[3][2][35] = nodes[0][14];
    run_queue[3][2][36] = nodes[4][14];
    run_queue[3][2][37] = nodes[8][14];
    run_queue_size[3][3] = 38;
    run_queue[3][3][0] = nodes[3][0];
    run_queue[3][3][1] = nodes[7][0];
    run_queue[3][3][2] = nodes[1][5];
    run_queue[3][3][3] = nodes[5][5];
    run_queue[3][3][4] = nodes[9][5];
    run_queue[3][3][5] = nodes[3][6];
    run_queue[3][3][6] = nodes[7][6];
    run_queue[3][3][7] = nodes[1][7];
    run_queue[3][3][8] = nodes[3][7];
    run_queue[3][3][9] = nodes[7][7];
    run_queue[3][3][10] = nodes[1][8];
    run_queue[3][3][11] = nodes[5][8];
    run_queue[3][3][12] = nodes[9][8];
    run_queue[3][3][13] = nodes[3][9];
    run_queue[3][3][14] = nodes[7][9];
    run_queue[3][3][15] = nodes[1][1];
    run_queue[3][3][16] = nodes[5][1];
    run_queue[3][3][17] = nodes[9][1];
    run_queue[3][3][18] = nodes[3][10];
    run_queue[3][3][19] = nodes[7][10];
    run_queue[3][3][20] = nodes[1][2];
    run_queue[3][3][21] = nodes[5][2];
    run_queue[3][3][22] = nodes[9][2];
    run_queue[3][3][23] = nodes[3][11];
    run_queue[3][3][24] = nodes[7][11];
    run_queue[3][3][25] = nodes[1][3];
    run_queue[3][3][26] = nodes[5][3];
    run_queue[3][3][27] = nodes[9][3];
    run_queue[3][3][28] = nodes[3][12];
    run_queue[3][3][29] = nodes[7][12];
    run_queue[3][3][30] = nodes[1][4];
    run_queue[3][3][31] = nodes[5][4];
    run_queue[3][3][32] = nodes[9][4];
    run_queue[3][3][33] = nodes[3][13];
    run_queue[3][3][34] = nodes[7][13];
    run_queue[3][3][35] = nodes[1][14];
    run_queue[3][3][36] = nodes[5][14];
    run_queue[3][3][37] = nodes[9][14];
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
    nodes[2][5]->producer_forward[0] = 0;
    nodes[2][5]->producer_forward[1] = 0;
    nodes[6][5]->producer_forward[0] = 0;
    nodes[6][5]->producer_forward[1] = 0;
    nodes[0][6]->producer_forward[0] = 0;
    nodes[0][6]->producer_forward[1] = 0;
    nodes[4][6]->producer_forward[0] = 0;
    nodes[4][6]->producer_forward[1] = 0;
    nodes[8][6]->producer_forward[0] = 0;
    nodes[8][6]->producer_forward[1] = 0;
    nodes[4][7]->producer_forward[0] = 0;
    nodes[8][7]->producer_forward[0] = 0;
    nodes[2][8]->producer_forward[0] = 0;
    nodes[2][8]->producer_forward[1] = 0;
    nodes[6][8]->producer_forward[0] = 0;
    nodes[6][8]->producer_forward[1] = 0;
    nodes[0][9]->producer_forward[0] = 0;
    nodes[0][9]->producer_forward[1] = 0;
    nodes[4][9]->producer_forward[0] = 0;
    nodes[4][9]->producer_forward[1] = 0;
    nodes[8][9]->producer_forward[0] = 0;
    nodes[8][9]->producer_forward[1] = 0;
    nodes[2][1]->producer_forward[0] = 0;
    nodes[2][1]->producer_forward[1] = 0;
    nodes[6][1]->producer_forward[0] = 0;
    nodes[6][1]->producer_forward[1] = 0;
    nodes[0][10]->producer_forward[0] = 0;
    nodes[0][10]->producer_forward[1] = 0;
    nodes[4][10]->producer_forward[0] = 0;
    nodes[4][10]->producer_forward[1] = 0;
    nodes[8][10]->producer_forward[0] = 0;
    nodes[8][10]->producer_forward[1] = 0;
    nodes[2][2]->producer_forward[0] = 0;
    nodes[2][2]->producer_forward[1] = 0;
    nodes[6][2]->producer_forward[0] = 0;
    nodes[6][2]->producer_forward[1] = 0;
    nodes[0][11]->producer_forward[0] = 0;
    nodes[0][11]->producer_forward[1] = 0;
    nodes[4][11]->producer_forward[0] = 0;
    nodes[4][11]->producer_forward[1] = 0;
    nodes[8][11]->producer_forward[0] = 0;
    nodes[8][11]->producer_forward[1] = 0;
    nodes[2][3]->producer_forward[0] = 0;
    nodes[6][3]->producer_forward[0] = 0;
    nodes[0][12]->producer_forward[0] = 0;
    nodes[4][12]->producer_forward[0] = 0;
    nodes[8][12]->producer_forward[0] = 0;
    nodes[2][4]->producer_forward[0] = 0;
    nodes[2][4]->producer_forward[1] = 0;
    nodes[6][4]->producer_forward[0] = 0;
    nodes[6][4]->producer_forward[1] = 0;
    nodes[0][13]->producer_forward[0] = 0;
    nodes[0][13]->producer_forward[1] = 0;
    nodes[4][13]->producer_forward[0] = 0;
    nodes[4][13]->producer_forward[1] = 0;
    nodes[8][13]->producer_forward[0] = 0;
    nodes[8][13]->producer_forward[1] = 0;
    nodes[2][14]->producer_forward[0] = 0;
    nodes[2][14]->producer_forward[1] = 0;
    nodes[6][14]->producer_forward[0] = 0;
    nodes[6][14]->producer_forward[1] = 0;
    nodes[1][0]->producer_forward[0] = 0;
    nodes[1][0]->producer_forward[1] = 0;
    nodes[5][0]->producer_forward[0] = 0;
    nodes[5][0]->producer_forward[1] = 0;
    nodes[9][0]->producer_forward[0] = 0;
    nodes[9][0]->producer_forward[1] = 0;
    nodes[3][5]->producer_forward[0] = 0;
    nodes[3][5]->producer_forward[1] = 0;
    nodes[7][5]->producer_forward[0] = 0;
    nodes[7][5]->producer_forward[1] = 0;
    nodes[1][6]->producer_forward[0] = 0;
    nodes[1][6]->producer_forward[1] = 0;
    nodes[5][6]->producer_forward[0] = 0;
    nodes[5][6]->producer_forward[1] = 0;
    nodes[9][6]->producer_forward[0] = 0;
    nodes[9][6]->producer_forward[1] = 0;
    nodes[5][7]->producer_forward[0] = 0;
    nodes[9][7]->producer_forward[0] = 0;
    nodes[3][8]->producer_forward[0] = 0;
    nodes[3][8]->producer_forward[1] = 0;
    nodes[7][8]->producer_forward[0] = 0;
    nodes[7][8]->producer_forward[1] = 0;
    nodes[1][9]->producer_forward[0] = 0;
    nodes[1][9]->producer_forward[1] = 0;
    nodes[5][9]->producer_forward[0] = 0;
    nodes[5][9]->producer_forward[1] = 0;
    nodes[9][9]->producer_forward[0] = 0;
    nodes[9][9]->producer_forward[1] = 0;
    nodes[3][1]->producer_forward[0] = 0;
    nodes[3][1]->producer_forward[1] = 0;
    nodes[7][1]->producer_forward[0] = 0;
    nodes[7][1]->producer_forward[1] = 0;
    nodes[1][10]->producer_forward[0] = 0;
    nodes[1][10]->producer_forward[1] = 0;
    nodes[5][10]->producer_forward[0] = 0;
    nodes[5][10]->producer_forward[1] = 0;
    nodes[9][10]->producer_forward[0] = 0;
    nodes[9][10]->producer_forward[1] = 0;
    nodes[3][2]->producer_forward[0] = 0;
    nodes[3][2]->producer_forward[1] = 0;
    nodes[7][2]->producer_forward[0] = 0;
    nodes[7][2]->producer_forward[1] = 0;
    nodes[1][11]->producer_forward[0] = 0;
    nodes[1][11]->producer_forward[1] = 0;
    nodes[5][11]->producer_forward[0] = 0;
    nodes[5][11]->producer_forward[1] = 0;
    nodes[9][11]->producer_forward[0] = 0;
    nodes[9][11]->producer_forward[1] = 0;
    nodes[3][3]->producer_forward[0] = 0;
    nodes[7][3]->producer_forward[0] = 0;
    nodes[1][12]->producer_forward[0] = 0;
    nodes[5][12]->producer_forward[0] = 0;
    nodes[9][12]->producer_forward[0] = 0;
    nodes[3][4]->producer_forward[0] = 0;
    nodes[3][4]->producer_forward[1] = 0;
    nodes[7][4]->producer_forward[0] = 0;
    nodes[7][4]->producer_forward[1] = 0;
    nodes[1][13]->producer_forward[0] = 0;
    nodes[1][13]->producer_forward[1] = 0;
    nodes[5][13]->producer_forward[0] = 0;
    nodes[5][13]->producer_forward[1] = 0;
    nodes[9][13]->producer_forward[0] = 0;
    nodes[9][13]->producer_forward[1] = 0;
    nodes[3][14]->producer_forward[0] = 0;
    nodes[3][14]->producer_forward[1] = 0;
    nodes[7][14]->producer_forward[0] = 0;
    nodes[7][14]->producer_forward[1] = 0;
    nodes[2][0]->producer_forward[0] = 0;
    nodes[2][0]->producer_forward[1] = 0;
    nodes[6][0]->producer_forward[0] = 0;
    nodes[6][0]->producer_forward[1] = 0;
    nodes[0][5]->producer_forward[0] = 0;
    nodes[0][5]->producer_forward[1] = 0;
    nodes[4][5]->producer_forward[0] = 0;
    nodes[4][5]->producer_forward[1] = 0;
    nodes[8][5]->producer_forward[0] = 0;
    nodes[8][5]->producer_forward[1] = 0;
    nodes[2][6]->producer_forward[0] = 0;
    nodes[2][6]->producer_forward[1] = 0;
    nodes[6][6]->producer_forward[0] = 0;
    nodes[6][6]->producer_forward[1] = 0;
    nodes[0][7]->producer_forward[0] = 0;
    nodes[2][7]->producer_forward[0] = 0;
    nodes[6][7]->producer_forward[0] = 0;
    nodes[0][8]->producer_forward[0] = 0;
    nodes[0][8]->producer_forward[1] = 0;
    nodes[4][8]->producer_forward[0] = 0;
    nodes[4][8]->producer_forward[1] = 0;
    nodes[8][8]->producer_forward[0] = 0;
    nodes[8][8]->producer_forward[1] = 0;
    nodes[2][9]->producer_forward[0] = 0;
    nodes[2][9]->producer_forward[1] = 0;
    nodes[6][9]->producer_forward[0] = 0;
    nodes[6][9]->producer_forward[1] = 0;
    nodes[0][1]->producer_forward[0] = 0;
    nodes[0][1]->producer_forward[1] = 0;
    nodes[4][1]->producer_forward[0] = 0;
    nodes[4][1]->producer_forward[1] = 0;
    nodes[8][1]->producer_forward[0] = 0;
    nodes[8][1]->producer_forward[1] = 0;
    nodes[2][10]->producer_forward[0] = 0;
    nodes[2][10]->producer_forward[1] = 0;
    nodes[6][10]->producer_forward[0] = 0;
    nodes[6][10]->producer_forward[1] = 0;
    nodes[0][2]->producer_forward[0] = 0;
    nodes[0][2]->producer_forward[1] = 0;
    nodes[4][2]->producer_forward[0] = 0;
    nodes[4][2]->producer_forward[1] = 0;
    nodes[8][2]->producer_forward[0] = 0;
    nodes[8][2]->producer_forward[1] = 0;
    nodes[2][11]->producer_forward[0] = 0;
    nodes[2][11]->producer_forward[1] = 0;
    nodes[6][11]->producer_forward[0] = 0;
    nodes[6][11]->producer_forward[1] = 0;
    nodes[0][3]->producer_forward[0] = 0;
    nodes[4][3]->producer_forward[0] = 0;
    nodes[8][3]->producer_forward[0] = 0;
    nodes[2][12]->producer_forward[0] = 0;
    nodes[6][12]->producer_forward[0] = 0;
    nodes[0][4]->producer_forward[0] = 0;
    nodes[0][4]->producer_forward[1] = 0;
    nodes[4][4]->producer_forward[0] = 0;
    nodes[4][4]->producer_forward[1] = 0;
    nodes[8][4]->producer_forward[0] = 0;
    nodes[8][4]->producer_forward[1] = 0;
    nodes[2][13]->producer_forward[0] = 0;
    nodes[2][13]->producer_forward[1] = 0;
    nodes[6][13]->producer_forward[0] = 0;
    nodes[6][13]->producer_forward[1] = 0;
    nodes[0][14]->producer_forward[0] = 0;
    nodes[0][14]->producer_forward[1] = 0;
    nodes[4][14]->producer_forward[0] = 0;
    nodes[4][14]->producer_forward[1] = 0;
    nodes[8][14]->producer_forward[0] = 0;
    nodes[8][14]->producer_forward[1] = 0;
    nodes[3][0]->producer_forward[0] = 0;
    nodes[3][0]->producer_forward[1] = 0;
    nodes[7][0]->producer_forward[0] = 0;
    nodes[7][0]->producer_forward[1] = 0;
    nodes[1][5]->producer_forward[0] = 0;
    nodes[1][5]->producer_forward[1] = 0;
    nodes[5][5]->producer_forward[0] = 0;
    nodes[5][5]->producer_forward[1] = 0;
    nodes[9][5]->producer_forward[0] = 0;
    nodes[9][5]->producer_forward[1] = 0;
    nodes[3][6]->producer_forward[0] = 0;
    nodes[3][6]->producer_forward[1] = 0;
    nodes[7][6]->producer_forward[0] = 0;
    nodes[7][6]->producer_forward[1] = 0;
    nodes[1][7]->producer_forward[0] = 0;
    nodes[3][7]->producer_forward[0] = 0;
    nodes[7][7]->producer_forward[0] = 0;
    nodes[1][8]->producer_forward[0] = 0;
    nodes[1][8]->producer_forward[1] = 0;
    nodes[5][8]->producer_forward[0] = 0;
    nodes[5][8]->producer_forward[1] = 0;
    nodes[9][8]->producer_forward[0] = 0;
    nodes[9][8]->producer_forward[1] = 0;
    nodes[3][9]->producer_forward[0] = 0;
    nodes[3][9]->producer_forward[1] = 0;
    nodes[7][9]->producer_forward[0] = 0;
    nodes[7][9]->producer_forward[1] = 0;
    nodes[1][1]->producer_forward[0] = 0;
    nodes[1][1]->producer_forward[1] = 0;
    nodes[5][1]->producer_forward[0] = 0;
    nodes[5][1]->producer_forward[1] = 0;
    nodes[9][1]->producer_forward[0] = 0;
    nodes[9][1]->producer_forward[1] = 0;
    nodes[3][10]->producer_forward[0] = 0;
    nodes[3][10]->producer_forward[1] = 0;
    nodes[7][10]->producer_forward[0] = 0;
    nodes[7][10]->producer_forward[1] = 0;
    nodes[1][2]->producer_forward[0] = 0;
    nodes[1][2]->producer_forward[1] = 0;
    nodes[5][2]->producer_forward[0] = 0;
    nodes[5][2]->producer_forward[1] = 0;
    nodes[9][2]->producer_forward[0] = 0;
    nodes[9][2]->producer_forward[1] = 0;
    nodes[3][11]->producer_forward[0] = 0;
    nodes[3][11]->producer_forward[1] = 0;
    nodes[7][11]->producer_forward[0] = 0;
    nodes[7][11]->producer_forward[1] = 0;
    nodes[1][3]->producer_forward[0] = 0;
    nodes[5][3]->producer_forward[0] = 0;
    nodes[9][3]->producer_forward[0] = 0;
    nodes[3][12]->producer_forward[0] = 0;
    nodes[7][12]->producer_forward[0] = 0;
    nodes[1][4]->producer_forward[0] = 0;
    nodes[1][4]->producer_forward[1] = 0;
    nodes[5][4]->producer_forward[0] = 0;
    nodes[5][4]->producer_forward[1] = 0;
    nodes[9][4]->producer_forward[0] = 0;
    nodes[9][4]->producer_forward[1] = 0;
    nodes[3][13]->producer_forward[0] = 0;
    nodes[3][13]->producer_forward[1] = 0;
    nodes[7][13]->producer_forward[0] = 0;
    nodes[7][13]->producer_forward[1] = 0;
    nodes[1][14]->producer_forward[0] = 0;
    nodes[1][14]->producer_forward[1] = 0;
    nodes[5][14]->producer_forward[0] = 0;
    nodes[5][14]->producer_forward[1] = 0;
    nodes[9][14]->producer_forward[0] = 0;
    nodes[9][14]->producer_forward[1] = 0;
#endif

    runtime(run_queue, run_queue_size);
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
    const int nodes_per_cell = 15;

    gru_cell_data_t *cells = (gru_cell_data_t*)
        get_memory(NUM_FRAMES * SEQ_LENGTH * sizeof(gru_cell_data_t));
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
            int node_index = j * nodes_per_cell;

            cell_init(&(cells[cell_index]),  nodes[i], node_index, cell_index,
                    j == 0);

            update_gate(&(cells[cell_index]), nodes[i], node_index + 1,
                    j == 0);

            reset_gate(&(cells[cell_index]), nodes[i], node_index + 5, j == 0);

            cell_output(&(cells[cell_index]), nodes[i], node_index + 13,
                    j == (SEQ_LENGTH - 1));
        }
    }

    gedf(nodes);
    //aprx(nodes);

#ifdef VERIFY
    for (int i = 0; i < NUM_FRAMES; i++) {
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Frame %2d, pixel %2d, value = %f\n", i, j,
                    cells[i].cell_output[j]);
        }
    }
#endif

    m5_dump_stats();
    m5_exit();
}
