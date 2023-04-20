#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

#define SCALE_DEADLINE 100000
#define DEADLINE_INCREMENT 500

void add_scale_dag(task_struct_t ***nodes, int *num_nodes, int num_children)
{
    if (num_children < 1) { return; }

    task_struct_t *root_task = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    int size = NUM_PIXELS * 4;

    float *root_output = (float*) get_memory_aligned(size, CACHELINE_SIZE);

    args->arg1 = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    args->arg2 = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    args->output = root_output;
    args->is_arg2_scalar = 0;
    args->op = ADD;
    args->do_one_minus = 0;

    root_task->acc_id = ACC_ELEM_MATRIX;
    root_task->acc_args = (void*) args;
    root_task->num_children = num_children;
    root_task->num_parents = 0;
    root_task->producer[0] = NULL;
    root_task->producer[1] = NULL;
    root_task->status = REQ_STATUS_READY;

    root_task->producer_forward[0] = 0;
    root_task->producer_forward[1] = 0;
    root_task->completed_parents = 0;

    root_task->input_size = 131072;
    root_task->output_size = 65536;
    root_task->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    root_task->dag_deadline = SCALE_DEADLINE;
    root_task->node_deadline = DEADLINE_INCREMENT;

    nodes[0][0] = root_task;

    for (int i = 1; i <= num_children; i++) {
        task_struct_t *task = (task_struct_t*)
            get_memory(sizeof(task_struct_t));

        args = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));

        args->arg1 = root_output;
        args->arg2 = (float*) get_memory_aligned(size, CACHELINE_SIZE);
        args->output = (float*) get_memory_aligned(size, CACHELINE_SIZE);
        args->is_arg2_scalar = 0;
        args->op = ADD;
        args->do_one_minus = 0;

        task->acc_id = ACC_ELEM_MATRIX;
        task->acc_args = (void*) args;
        task->num_children = 0;
        task->num_parents = 1;
        task->producer[0] = root_task;
        task->producer[1] = NULL;
        task->status = REQ_STATUS_WAITING;

        task->producer_forward[0] = 0;
        task->producer_forward[1] = 0;
        task->completed_parents = 0;

        task->input_size = 131072;
        task->output_size = 65536;
        task->compute_time = RUNTIME_ELEM_MATRIX_ADD;
        task->dag_deadline = SCALE_DEADLINE;
        task->node_deadline = (i + 1) * DEADLINE_INCREMENT;

        root_task->children[i - 1] = task;

        nodes[0][i] = task;
    }

    num_nodes[0] = num_children + 1;
}
