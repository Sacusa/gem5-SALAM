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

void schedule(task_struct_t ***nodes)
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

Unsupported DAG type: 201

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

    // the following numbers are set by the bash script
    int num_canny = 0;
    int num_deblur = 0;
    int num_gru = 0;
    int num_harris = 0;
    int num_lstm = 1;

    int nodes_offset = 0;

    if (num_canny > 0) { init_canny(); }
    add_canny_dag(&nodes[nodes_offset], num_canny);
    nodes_offset += num_canny;

    if (num_deblur > 0) { init_deblur(); }
    add_deblur_dag(&nodes[nodes_offset], num_deblur, 5);
    nodes_offset += num_deblur;

    if (num_gru > 0) { init_gru(); }
    add_gru_dag(&nodes[nodes_offset], num_gru, 8);
    nodes_offset += num_gru;

    if (num_harris > 0) { init_harris(); }
    add_harris_dag(&nodes[nodes_offset], num_harris);
    nodes_offset += num_harris;

    if (num_lstm > 0) { init_lstm(); }
    add_lstm_dag(&nodes[nodes_offset], num_lstm, 8);
    nodes_offset += num_lstm;

    m5_reset_stats();

    schedule(nodes);

    m5_dump_stats();

#ifdef VERIFY
    nodes_offset -= num_lstm;
    print_lstm_output(&nodes[nodes_offset], num_lstm, 8);

    nodes_offset -= num_harris;
    print_harris_output(&nodes[nodes_offset], num_harris);

    nodes_offset -= num_gru;
    print_gru_output(&nodes[nodes_offset], num_gru, 8);

    nodes_offset -= num_deblur;
    print_deblur_output(&nodes[nodes_offset], num_deblur, 5);

    nodes_offset -= num_canny;
    print_canny_output(&nodes[nodes_offset], num_canny);
#endif

    m5_exit();
}
