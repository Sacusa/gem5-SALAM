#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "canny.h"
#include "deblur.h"
#include "gru.h"
#include "harris.h"
#include "lstm.h"
#include "runtime.h"

#define ENABLE_FORWARDING

void schedule(task_struct_t ***nodes) // Policy: GEDF
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

    run_queue_size[0][0] = 1;
    run_queue[0][0][0] = nodes[0][10];
    run_queue_size[1][0] = 2;
    run_queue[1][0][0] = nodes[0][2];
    run_queue[1][0][1] = nodes[0][3];
    run_queue_size[1][1] = 1;
    run_queue[1][1][0] = nodes[0][4];
    run_queue_size[2][0] = 1;
    run_queue[2][0][0] = nodes[0][11];
    run_queue_size[3][0] = 3;
    run_queue[3][0][0] = nodes[0][5];
    run_queue[3][0][1] = nodes[0][8];
    run_queue[3][0][2] = nodes[0][9];
    run_queue_size[3][1] = 1;
    run_queue[3][1][0] = nodes[0][7];
    run_queue_size[3][2] = 1;
    run_queue[3][2][0] = nodes[0][6];
    run_queue_size[3][3] = 0;
    run_queue_size[4][0] = 1;
    run_queue[4][0][0] = nodes[0][1];
    run_queue_size[5][0] = 0;
#ifdef VERIFY
    run_queue_size[6][0] = 0
#else
    run_queue_size[6][0] = 1;
#endif
    run_queue[6][0][0] = nodes[0][0];
#ifdef ENABLE_FORWARDING
    nodes[0][10]->producer_forward[0] = 1;
    nodes[0][10]->producer_forward[1] = 0;
    nodes[0][2]->producer_forward[0] = 1;
    nodes[0][3]->producer_forward[0] = 1;
    nodes[0][4]->producer_forward[0] = 1;
    nodes[0][11]->producer_forward[0] = 1;
    nodes[0][5]->producer_forward[0] = 1;
    nodes[0][5]->producer_forward[1] = 0;
    nodes[0][8]->producer_forward[0] = 1;
    nodes[0][8]->producer_forward[1] = 1;
    nodes[0][9]->producer_forward[0] = 1;
    nodes[0][9]->producer_forward[1] = 0;
    nodes[0][7]->producer_forward[0] = 1;
    nodes[0][7]->producer_forward[1] = 0;
    nodes[0][6]->producer_forward[0] = 1;
    nodes[0][6]->producer_forward[1] = 1;
#ifndef VERIFY
    nodes[0][1]->producer_forward[0] = 1;
#endif
    nodes[0][0]->producer_forward[0] = 0;
#endif

     runtime(run_queue, run_queue_size);
}


int main(int argc, char *argv[])
{
    task_struct_t ***nodes = (task_struct_t***)
        get_memory(MAX_DAGS * sizeof(task_struct_t**));
    for (int i = 0; i < MAX_DAGS; i++) {
        nodes[i] = (task_struct_t **)
            get_memory(MAX_NODES * sizeof(task_struct_t*));
    }

    init_canny();
    /*
    init_deblur();
    init_gru();
    init_harris();
    init_lstm();
    */

    int nodes_offset = 0;

    add_canny_dag(&nodes[nodes_offset], 1);
    nodes_offset += 1;
    /*
    add_harris_dag(&nodes[nodes_offset], 1);
    nodes_offset += 1;
    add_deblur_dag(&nodes[nodes_offset], 1, 5);
    nodes_offset += 1;
    add_gru_dag(&nodes[nodes_offset], 1, 8);
    nodes_offset += 1;
    add_lstm_dag(&nodes[nodes_offset], 1, 8);
    nodes_offset += 1;
    */

    m5_reset_stats();

    schedule(nodes);

    m5_dump_stats();
    m5_exit();
}
