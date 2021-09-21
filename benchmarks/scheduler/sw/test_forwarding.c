#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "scheduler.h"

void run_pipeline()
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
            run_queue_size[i][j] = 0;
        }
    }

    printf("Generating data\n");

    grayscale_args *g_args = (grayscale_args*)
        get_memory(sizeof(grayscale_args));
    elem_matrix_args *em_args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    g_args->input = (uint8_t*) get_memory(NUM_PIXELS * 3);
    g_args->output = (float*) get_memory(NUM_PIXELS * 4);

    em_args->arg1 = g_args->output;
    em_args->output = (float*) get_memory(NUM_PIXELS * 4);
    em_args->is_arg2_scalar = 0;
    em_args->op = SQR;
    em_args->do_one_minus = 0;

    for (int i = 0; i < NUM_PIXELS; i++) {
        int ii = i * 3;
        g_args->input[ii]   = 3;
        g_args->input[ii+1] = 3;
        g_args->input[ii+2] = 3;
    }
    float expected = 9;

    task_struct_t *task[2];
    task[0] = (task_struct_t*) get_memory(sizeof(task_struct_t));
    task[1] = (task_struct_t*) get_memory(sizeof(task_struct_t));

    task[0]->acc_id = ACC_GRAYSCALE;
    task[0]->acc_args = (void*) g_args;
    task[0]->num_children = 1;
    task[0]->children[0] = task[1];
    task[0]->num_parents = 0;
    task[0]->producer_forward[0] = 0;
    task[0]->status = REQ_STATUS_READY;
    task[0]->completed_parents = 0;

    task[1]->acc_id = ACC_ELEM_MATRIX;
    task[1]->acc_args = (void*) em_args;
    task[1]->num_children = 0;
    task[1]->num_parents = 1;
    task[1]->producer[0] = task[0];

    /********************************
     * THIS IS THE KEY!
     *
     * Setting the following value to 1 will cause a direct transfer.
     */
    task[1]->producer_forward[0] = 1;

    task[1]->producer_forward[1] = 0;
    task[1]->status = REQ_STATUS_WAITING;
    task[1]->completed_parents = 0;

    run_queue_size[3][0] = 1;
    run_queue[3][0][0] = task[1];
    run_queue_size[4][0] = 1;
    run_queue[4][0][0] = task[0];

    printf("Launching accelerators\n");
    schedule(run_queue, run_queue_size);

    printf("Verifying output\n");
    for (int i = 0; i < NUM_PIXELS; i++) {
        if (em_args->output[i] != expected) {
            printf("ERROR at index %d: expected = %d, got = %d\n", i,
                    expected, em_args->output[i]);
        }
    }
}

int main(int argc, char *argv[])
{
    m5_reset_stats();

    run_pipeline();

    m5_dump_stats();
    m5_exit();
}
