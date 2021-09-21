#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "scheduler.h"

#define NUM_FRAMES 1
#define SEQ_LENGTH 8

typedef struct {
    float data_input[NUM_PIXELS];
    float *hidden_state_input;

    // Update gate
    float ug_weighted_hidden[NUM_PIXELS], ug_weighted_input[NUM_PIXELS];
    float ug_add_out1[NUM_PIXELS], ug_add_out2[NUM_PIXELS];
    float ug_sigmoid_out[NUM_PIXELS];
    float ug_output[NUM_PIXELS];

    // Reset gate
    float rg_weighted_hidden[NUM_PIXELS], rg_weighted_input1[NUM_PIXELS];
    float rg_add_out1[NUM_PIXELS], rg_add_out2[NUM_PIXELS];
    float rg_sigmoid_out[NUM_PIXELS];

    float rg_sigmoid_hidden_mult[NUM_PIXELS], rg_weighted_input2[NUM_PIXELS];
    float rg_mult_out1[NUM_PIXELS], rg_biased_input2[NUM_PIXELS];
    float rg_add_out3[NUM_PIXELS];
    float rg_tanh_out[NUM_PIXELS];

    // Final cell output
    float ug_rg_mult[NUM_PIXELS];
    float cell_output[NUM_PIXELS];
} gru_cell_data_t;

task_struct_t *retval[4];

void init_cell_data(gru_cell_data_t *cell, int input_seed, bool is_first)
{
    if (is_first) {
        cell->hidden_state_input = (float*) get_memory(NUM_PIXELS * 4);
    }

    for (int i = 0; i < NUM_PIXELS; i++) {
        cell->data_input[i] = input_seed % NUM_PIXELS;
        input_seed++;

        if (is_first) {
            cell->hidden_state_input[i] = 0;
        }
    }
}

void update_gate(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_first)
{
    task_struct_t *task[6];
    elem_matrix_args *args[6];

    int size = NUM_PIXELS * 4;
    float *hidden_state_weight = (float*) get_memory(size);
    float *data_input_weight = (float*) get_memory(size);
    float *bias = (float*) get_memory(size);
    // TODO: initialize above three

    if (!is_first) {
        cell->hidden_state_input =
            ((elem_matrix_args*)(retval[3]->acc_args))->output;
    }

    args[0]->arg1 = cell->hidden_state_input;
    args[0]->arg2 = (float*)(hidden_state_weight);
    args[0]->output = (float*)(cell->ug_weighted_hidden);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->data_input);
    args[1]->arg2 = (float*)(data_input_weight);
    args[1]->output = (float*)(cell->ug_weighted_input);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = MUL;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = (float*)(cell->ug_weighted_hidden);
    args[2]->arg2 = (float*)(cell->ug_weighted_input);
    args[2]->output = (float*)(cell->ug_add_out1);
    args[2]->is_arg2_scalar = 0;
    args[2]->op = ADD;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = (float*)(cell->ug_add_out1);
    args[3]->arg2 = (float*)(bias);
    args[3]->output = (float*)(cell->ug_add_out2);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = ADD;
    args[3]->do_one_minus = 0;

    args[4]->arg1 = (float*)(cell->ug_add_out2);
    args[4]->output = (float*)(cell->ug_sigmoid_out);
    args[4]->is_arg2_scalar = 0;
    args[4]->op = SIGMOID;
    args[4]->do_one_minus = 0;

    args[5]->arg1 = (float*)(cell->hidden_state_input);
    args[5]->arg2 = (float*)(cell->ug_sigmoid_out);
    args[5]->output = (float*)(cell->ug_output);
    args[5]->is_arg2_scalar = 0;
    args[5]->op = MUL;
    args[5]->do_one_minus = 1;

    for (int i = 0; i < 6; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 1;
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;

        nodes[node_index + i] = task[i];
    }

    if (is_first) {
        task[0]->num_parents = 0;
        task[0]->status = REQ_STATUS_READY;

        task[5]->num_parents = 1;
        task[5]->producer[1] = task[4];
    } else {
        task[0]->num_parents = 1;
        task[0]->producer[0] = retval[3];

        task[5]->num_parents = 2;
        task[5]->producer[0] = retval[3];
        task[5]->producer[1] = task[4];
    }

    task[1]->num_parents = 0;
    task[1]->status = REQ_STATUS_READY;

    task[2]->num_parents = 2;
    task[2]->producer[0] = task[0];
    task[2]->producer[1] = task[1];

    task[3]->num_parents = 1;
    task[3]->producer[0] = task[2];

    task[4]->num_children = 2;
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[3];

    retval[0] = task[4];
    retval[1] = task[5];
}

void reset_gate(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_first)
{
    task_struct_t *task[11];
    elem_matrix_args *args[11];

    int size = NUM_PIXELS * 4;

    float *hidden_state_weight = (float*) get_memory(size);
    float *data_input_weight1  = (float*) get_memory(size);
    float *bias1               = (float*) get_memory(size);
    float *inner_weight        = (float*) get_memory(size);
    float *data_input_weight2  = (float*) get_memory(size);
    float *bias2               = (float*) get_memory(size);
    // TODO: initialize above arrays

    if (!is_first) {
        cell->hidden_state_input =
            ((elem_matrix_args*)(retval[3]->acc_args))->output;
    }

    args[0]->arg1 = cell->hidden_state_input;
    args[0]->arg2 = (float*)(hidden_state_weight);
    args[0]->output = (float*)(cell->rg_weighted_hidden);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = (float*)(cell->data_input);
    args[1]->arg2 = (float*)(data_input_weight1);
    args[1]->output = (float*)(cell->rg_weighted_input1);
    args[1]->is_arg2_scalar = 0;
    args[1]->op = MUL;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = (float*)(cell->rg_weighted_hidden);
    args[2]->arg2 = (float*)(cell->rg_weighted_input1);
    args[2]->output = (float*)(cell->rg_add_out1);
    args[2]->is_arg2_scalar = 0;
    args[2]->op = ADD;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = (float*)(cell->rg_add_out1);
    args[3]->arg2 = (float*)(bias1);
    args[3]->output = (float*)(cell->rg_add_out2);
    args[3]->is_arg2_scalar = 0;
    args[3]->op = ADD;
    args[3]->do_one_minus = 0;

    args[4]->arg1 = (float*)(cell->rg_add_out2);
    args[4]->output = (float*)(cell->rg_sigmoid_out);
    args[4]->is_arg2_scalar = 0;
    args[4]->op = SIGMOID;
    args[4]->do_one_minus = 0;

    args[5]->arg1 = (float*)(cell->rg_sigmoid_out);
    args[5]->arg2 = cell->hidden_state_input;
    args[5]->output = (float*)(cell->rg_sigmoid_hidden_mult);
    args[5]->is_arg2_scalar = 0;
    args[5]->op = MUL;
    args[5]->do_one_minus = 0;

    args[6]->arg1 = (float*)(cell->data_input);
    args[6]->arg2 = (float*)(data_input_weight2);
    args[6]->output = (float*)(cell->rg_weighted_input2);
    args[6]->is_arg2_scalar = 0;
    args[6]->op = MUL;
    args[6]->do_one_minus = 0;

    args[7]->arg1 = (float*)(cell->rg_sigmoid_hidden_mult);
    args[7]->arg2 = (float*)(inner_weight);
    args[7]->output = (float*)(cell->rg_mult_out1);
    args[7]->is_arg2_scalar = 0;
    args[7]->op = MUL;
    args[7]->do_one_minus = 0;

    args[8]->arg1 = (float*)(cell->rg_weighted_input2);
    args[8]->arg2 = (float*)(bias2);
    args[8]->output = (float*)(cell->rg_biased_input2);
    args[8]->is_arg2_scalar = 0;
    args[8]->op = ADD;
    args[8]->do_one_minus = 0;

    args[9]->arg1 = (float*)(cell->rg_mult_out1);
    args[9]->arg2 = (float*)(cell->rg_biased_input2);
    args[9]->output = (float*)(cell->rg_add_out3);
    args[9]->is_arg2_scalar = 0;
    args[9]->op = ADD;
    args[9]->do_one_minus = 0;

    args[10]->arg1 = (float*)(cell->rg_add_out3);
    args[10]->output = (float*)(cell->rg_tanh_out);
    args[10]->is_arg2_scalar = 0;
    args[10]->op = TANH;
    args[10]->do_one_minus = 0;

    for (int i = 0; i < 11; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 1;
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;

        nodes[node_index + i] = task[i];
    }

    if (is_first) {
        task[0]->num_parents = 0;
        task[0]->status = REQ_STATUS_READY;

        task[5]->num_parents = 1;
        task[5]->producer[0] = task[4];
        task[5]->status = REQ_STATUS_READY;
    } else {
        task[0]->num_parents = 1;
        task[0]->producer[0] = retval[3];

        task[5]->num_parents = 2;
        task[5]->producer[0] = task[4];
        task[5]->producer[1] = retval[3];
    }

    task[1]->num_parents = 0;
    task[1]->status = REQ_STATUS_READY;

    task[2]->num_parents = 2;
    task[2]->producer[0] = task[0];
    task[2]->producer[1] = task[1];

    task[3]->num_parents = 1;
    task[3]->producer[0] = task[2];

    task[4]->num_parents = 1;
    task[4]->producer[0] = task[3];

    task[6]->num_parents = 0;
    task[6]->status = REQ_STATUS_READY;

    task[7]->num_parents = 1;
    task[7]->producer[0] = task[5];

    task[8]->num_parents = 1;
    task[8]->producer[0] = task[6];

    task[9]->num_parents = 2;
    task[9]->producer[0] = task[7];
    task[9]->producer[1] = task[8];

    task[10]->num_parents = 1;
    task[10]->producer[0] = task[9];

    retval[2] = task[10];
}

void cell_output(gru_cell_data_t *cell, task_struct_t **nodes, int node_index,
        bool is_last)
{
    task_struct_t *task[2];
    elem_matrix_args *args[2];
    int size = NUM_PIXELS * 4;

    args[0]->arg1 = ((elem_matrix_args*)(retval[0]->acc_args))->output;
    args[0]->arg2 = ((elem_matrix_args*)(retval[2]->acc_args))->output;
    args[0]->output = (float*)(cell->ug_rg_mult);
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = ((elem_matrix_args*)(retval[1]->acc_args))->output;
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

    task[0]->num_children = 0;
    task[0]->producer[0] = retval[0];
    task[0]->producer[1] = retval[2];

    if (is_last) {
        task[1]->num_children = 0;
    } else {
        task[1]->num_children = 4;
    }
    task[1]->producer[0] = retval[1];
    task[1]->producer[1] = task[0];

    retval[3] = task[1];
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

    schedule(run_queue, run_queue_size);
}

int main(int argc, char *argv[])
{
    m5_reset_stats();
    const int nodes_per_cell = 19;

    gru_cell_data_t *cells = (gru_cell_data_t*)
        get_memory(NUM_FRAMES * SEQ_LENGTH * sizeof(gru_cell_data_t));
    task_struct_t ***nodes = (task_struct_t***)
        get_memory(MAX_DAGS * sizeof(task_struct_t**));
    for (int i = 0; i < MAX_DAGS; i++) {
        nodes[i] = (task_struct_t **)
            get_memory(MAX_NODES * sizeof(task_struct_t*));
    }

    for (int i = 0; i < NUM_FRAMES; i++) {
        for (int j = 0; j < SEQ_LENGTH; j++) {
            int cell_index = (i * SEQ_LENGTH) + j;
            int node_index = j * nodes_per_cell;

            init_cell_data(&(cells[cell_index]), cell_index, j == 0);

            update_gate(&(cells[cell_index]), nodes[i], node_index, j == 0);

            reset_gate(&(cells[cell_index]), nodes[i], node_index + 6, j == 0);

            cell_output(&(cells[cell_index]), nodes[i], node_index + 17,
                    j == (SEQ_LENGTH - 1));
        }
    }

    gedf(nodes);

#ifdef VERIFY
    // TODO: print output here
#endif

    m5_dump_stats();
    m5_exit();
}
