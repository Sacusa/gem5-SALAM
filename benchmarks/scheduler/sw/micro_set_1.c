#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "runtime.h"

typedef struct {
    float *input;
    float *conv_kernel;

    float *o1;
    float *o2;
    float *o3;
} micro_set_1_b1_data_t;

typedef struct {
    float *input;
    float *o1;
    float *o2;
    float *o3;
} micro_set_1_b2_data_t;

// Dummy tasks with output sizes in the name
task_struct_t *micro_set_1_task_36;
task_struct_t *micro_set_1_task_65536;

void add_micro_set_1_b1(task_struct_t **nodes)
{
    micro_set_1_b1_data_t *u1 = (micro_set_1_b1_data_t*)
        get_memory(sizeof(micro_set_1_b1_data_t));

    u1->input = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);
    u1->conv_kernel = (float*) get_memory_aligned(36, CACHELINE_SIZE);
    u1->o1 = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);
    u1->o2 = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);
    u1->o3 = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);

    task_struct_t *task[3];
    elem_matrix_args *em_args[2];
    convolution_args *co_args;

    for (int i = 0; i < 3; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
    }

    for (int i = 0; i < 2; i++) {
        em_args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    co_args = (convolution_args*) get_memory(sizeof(convolution_args));

    em_args[0]->arg1 = u1->input;
    em_args[0]->op = TANH;
    em_args[0]->output = u1->o1;

    em_args[1]->arg1 = u1->o1;
    em_args[1]->op = TANH;
    em_args[1]->output = u1->o2;

    co_args->input = u1->o2;
    co_args->kernel = u1->conv_kernel;
    co_args->kern_height = 3;
    co_args->kern_width = 3;
    co_args->mod_and_floor = false;
    co_args->output = u1->o3;

    for (int i = 0; i < 2; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) em_args[i];
        task[i]->num_children = 1;
        task[i]->num_parents = 1;
        task[i]->children[0] = task[i+1];
        task[i]->output_size = 65536;
        task[i]->dag_deadline = 815;
    }

    task[0]->status = REQ_STATUS_READY;
    task[0]->producer[0] = micro_set_1_task_65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_TANH;
    task[0]->completed_parents = 1;
    task[0]->node_deadline = 58;

    task[1]->status = REQ_STATUS_WAITING;
    task[1]->producer[0] = task[0];
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_TANH;
    task[1]->completed_parents = 0;
    task[1]->node_deadline = 140;

    task[2]->acc_id = ACC_CONVOLUTION;
    task[2]->acc_args = (void*) co_args;
    task[2]->num_children = 0;
    task[2]->num_parents = 2;
    task[2]->producer[0] = task[1];
    task[2]->producer[1] = micro_set_1_task_36;
    task[2]->status = REQ_STATUS_WAITING;
    task[2]->compute_time = RUNTIME_CONVOLUTION_3;
    task[2]->completed_parents = 1;
    task[2]->dag_deadline = 815;
    task[2]->node_deadline = 815;

    for (int i = 0; i < 3; i++) {
        nodes[i] = task[i];
    }
}

void add_micro_set_1_b2(task_struct_t **nodes)
{
    micro_set_1_b2_data_t *u2 = (micro_set_1_b2_data_t*)
        get_memory(sizeof(micro_set_1_b2_data_t));

    u2->input = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);
    u2->o1 = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);
    u2->o2 = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);
    u2->o3 = (float*) get_memory_aligned(NUM_PIXELS * 4, CACHELINE_SIZE);

    task_struct_t *task[3];
    elem_matrix_args *em_args[3];

    for (int i = 0; i < 3; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        em_args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    em_args[0]->arg1 = u2->input;
    em_args[0]->op = TANH;
    em_args[0]->output = u2->o1;

    em_args[1]->arg1 = u2->o1;
    em_args[1]->op = TANH;
    em_args[1]->output = u2->o2;

    em_args[2]->arg1 = u2->o2;
    em_args[2]->op = TANH;
    em_args[2]->output = u2->o3;

    for (int i = 0; i < 3; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) em_args[i];

        task[i]->num_children = 0;
        if (i < 2) {
            task[i]->num_children = 1;
            task[i]->children[0] = task[i+1];
        }

        task[i]->num_parents = 1;

        task[i]->producer[0] = micro_set_1_task_65536;
        task[i]->completed_parents = 1;
        if (i > 0) {
            task[i]->producer[0] = task[i-1];
            task[i]->completed_parents = 0;
        }

        task[i]->output_size = 65536;
        task[i]->compute_time = RUNTIME_ELEM_MATRIX_TANH;
        task[i]->dag_deadline = 198;

        nodes[i] = task[i];
    }

    task[0]->status = REQ_STATUS_READY;
    task[0]->node_deadline = 70;

    task[1]->status = REQ_STATUS_WAITING;
    task[1]->node_deadline = 167;

    task[2]->status = REQ_STATUS_WAITING;
    task[2]->node_deadline = 198;
}

void init_micro_set_1()
{
    micro_set_1_task_36 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    micro_set_1_task_36->output_size = 36;
    micro_set_1_task_36->status = REQ_STATUS_COMPLETED;

    micro_set_1_task_65536 = (task_struct_t*)get_memory(sizeof(task_struct_t));
    micro_set_1_task_65536->output_size = 65536;
    micro_set_1_task_65536->status = REQ_STATUS_COMPLETED;
}

void add_micro_set_1_dags(task_struct_t ***nodes, int *num_nodes)
{
    add_micro_set_1_b1(nodes[0]);
    add_micro_set_1_b2(nodes[1]);

    num_nodes[0] = 3;
    num_nodes[1] = 3;
}

int main(int argc, char *argv[])
{
    task_struct_t ***nodes = (task_struct_t***)
        get_memory(MAX_DAGS * sizeof(task_struct_t**));
    for (int i = 0; i < MAX_DAGS; i++) {
        nodes[i] = (task_struct_t **)
            get_memory(MAX_NODES * sizeof(task_struct_t*));
    }

    int num_nodes[MAX_DAGS];

    // the following numbers are set by the bash script
    int num_canny = 0;
    int num_deblur = 0;
    int num_gru = 0;
    int num_harris = 0;
    int num_lstm = 0;
    int num_scale = 0;

    int nodes_offset = 0;

    init_micro_set_1();
    add_micro_set_1_dags(&nodes[0], &num_nodes[0]);

    runtime(nodes, 2, num_nodes, ELF, MEM_PRED_AVERAGE, false);

    m5_exit();
}
