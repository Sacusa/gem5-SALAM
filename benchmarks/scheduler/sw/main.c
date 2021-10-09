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

    run_queue_size[0][0] = 3;
    run_queue[0][0][0] = nodes[0][10];
    run_queue[0][0][1] = nodes[1][10];
    run_queue[0][0][2] = nodes[2][10];
    run_queue_size[1][0] = 12;
    run_queue[1][0][0] = nodes[0][2];
    run_queue[1][0][1] = nodes[0][3];
    run_queue[1][0][2] = nodes[2][2];
    run_queue[1][0][3] = nodes[2][3];
    run_queue[1][0][4] = nodes[2][4];
    run_queue[1][0][5] = nodes[3][3];
    run_queue[1][0][6] = nodes[4][3];
    run_queue[1][0][7] = nodes[5][3];
    run_queue[1][0][8] = nodes[3][9];
    run_queue[1][0][9] = nodes[4][9];
    run_queue[1][0][10] = nodes[5][9];
    run_queue[1][0][11] = nodes[4][8];
    run_queue_size[1][1] = 12;
    run_queue[1][1][0] = nodes[1][2];
    run_queue[1][1][1] = nodes[1][3];
    run_queue[1][1][2] = nodes[0][4];
    run_queue[1][1][3] = nodes[1][4];
    run_queue[1][1][4] = nodes[3][2];
    run_queue[1][1][5] = nodes[4][2];
    run_queue[1][1][6] = nodes[5][2];
    run_queue[1][1][7] = nodes[3][7];
    run_queue[1][1][8] = nodes[4][7];
    run_queue[1][1][9] = nodes[5][7];
    run_queue[1][1][10] = nodes[3][8];
    run_queue[1][1][11] = nodes[5][8];
    run_queue_size[2][0] = 3;
    run_queue[2][0][0] = nodes[0][11];
    run_queue[2][0][1] = nodes[1][11];
    run_queue[2][0][2] = nodes[2][11];
    run_queue_size[3][0] = 33;
    run_queue[3][0][0] = nodes[0][5];
    run_queue[3][0][1] = nodes[1][5];
    run_queue[3][0][2] = nodes[0][6];
    run_queue[3][0][3] = nodes[0][9];
    run_queue[3][0][4] = nodes[2][5];
    run_queue[3][0][5] = nodes[1][6];
    run_queue[3][0][6] = nodes[1][9];
    run_queue[3][0][7] = nodes[2][6];
    run_queue[3][0][8] = nodes[2][9];
    run_queue[3][0][9] = nodes[3][4];
    run_queue[3][0][10] = nodes[3][5];
    run_queue[3][0][11] = nodes[4][4];
    run_queue[3][0][12] = nodes[4][5];
    run_queue[3][0][13] = nodes[5][4];
    run_queue[3][0][14] = nodes[5][5];
    run_queue[3][0][15] = nodes[3][10];
    run_queue[3][0][16] = nodes[3][14];
    run_queue[3][0][17] = nodes[3][15];
    run_queue[3][0][18] = nodes[4][10];
    run_queue[3][0][19] = nodes[4][14];
    run_queue[3][0][20] = nodes[4][15];
    run_queue[3][0][21] = nodes[5][10];
    run_queue[3][0][22] = nodes[5][14];
    run_queue[3][0][23] = nodes[5][15];
    run_queue[3][0][24] = nodes[3][11];
    run_queue[3][0][25] = nodes[3][13];
    run_queue[3][0][26] = nodes[3][16];
    run_queue[3][0][27] = nodes[4][11];
    run_queue[3][0][28] = nodes[4][13];
    run_queue[3][0][29] = nodes[4][16];
    run_queue[3][0][30] = nodes[5][11];
    run_queue[3][0][31] = nodes[5][13];
    run_queue[3][0][32] = nodes[5][16];
    run_queue_size[3][1] = 12;
    run_queue[3][1][0] = nodes[0][7];
    run_queue[3][1][1] = nodes[0][8];
    run_queue[3][1][2] = nodes[1][7];
    run_queue[3][1][3] = nodes[1][8];
    run_queue[3][1][4] = nodes[2][7];
    run_queue[3][1][5] = nodes[2][8];
    run_queue[3][1][6] = nodes[3][6];
    run_queue[3][1][7] = nodes[4][6];
    run_queue[3][1][8] = nodes[5][6];
    run_queue[3][1][9] = nodes[3][12];
    run_queue[3][1][10] = nodes[4][12];
    run_queue[3][1][11] = nodes[5][12];
    run_queue_size[3][2] = 0;
    run_queue_size[3][3] = 0;
    run_queue_size[4][0] = 6;
    run_queue[4][0][0] = nodes[0][1];
    run_queue[4][0][1] = nodes[1][1];
    run_queue[4][0][2] = nodes[2][1];
    run_queue[4][0][3] = nodes[3][1];
    run_queue[4][0][4] = nodes[4][1];
    run_queue[4][0][5] = nodes[5][1];
    run_queue_size[5][0] = 3;
    run_queue[5][0][0] = nodes[3][17];
    run_queue[5][0][1] = nodes[4][17];
    run_queue[5][0][2] = nodes[5][17];
#ifdef VERIFY
    run_queue_size[6][0] = 0
#else
    run_queue_size[6][0] = 6;
#endif
    run_queue[6][0][0] = nodes[0][0];
    run_queue[6][0][1] = nodes[1][0];
    run_queue[6][0][2] = nodes[2][0];
    run_queue[6][0][3] = nodes[3][0];
    run_queue[6][0][4] = nodes[4][0];
    run_queue[6][0][5] = nodes[5][0];
#ifdef ENABLE_FORWARDING
    nodes[0][10]->producer_forward[0] = 1;
    nodes[0][10]->producer_forward[1] = 0;
    nodes[1][10]->producer_forward[0] = 1;
    nodes[1][10]->producer_forward[1] = 0;
    nodes[2][10]->producer_forward[0] = 0;
    nodes[2][10]->producer_forward[1] = 0;
    nodes[0][2]->producer_forward[0] = 1;
    nodes[0][3]->producer_forward[0] = 1;
    nodes[2][2]->producer_forward[0] = 0;
    nodes[2][3]->producer_forward[0] = 1;
    nodes[2][4]->producer_forward[0] = 1;
    nodes[3][3]->producer_forward[0] = 0;
    nodes[4][3]->producer_forward[0] = 0;
    nodes[5][3]->producer_forward[0] = 0;
    nodes[3][9]->producer_forward[0] = 0;
    nodes[4][9]->producer_forward[0] = 0;
    nodes[5][9]->producer_forward[0] = 0;
    nodes[4][8]->producer_forward[0] = 0;
    nodes[1][2]->producer_forward[0] = 1;
    nodes[1][3]->producer_forward[0] = 1;
    nodes[0][4]->producer_forward[0] = 1;
    nodes[1][4]->producer_forward[0] = 1;
    nodes[3][2]->producer_forward[0] = 0;
    nodes[4][2]->producer_forward[0] = 0;
    nodes[5][2]->producer_forward[0] = 0;
    nodes[3][7]->producer_forward[0] = 0;
    nodes[4][7]->producer_forward[0] = 0;
    nodes[5][7]->producer_forward[0] = 0;
    nodes[3][8]->producer_forward[0] = 0;
    nodes[5][8]->producer_forward[0] = 0;
    nodes[0][11]->producer_forward[0] = 1;
    nodes[1][11]->producer_forward[0] = 1;
    nodes[2][11]->producer_forward[0] = 1;
    nodes[0][5]->producer_forward[0] = 1;
    nodes[0][5]->producer_forward[1] = 0;
    nodes[1][5]->producer_forward[0] = 1;
    nodes[1][5]->producer_forward[1] = 0;
    nodes[0][6]->producer_forward[0] = 1;
    nodes[0][6]->producer_forward[1] = 1;
    nodes[0][9]->producer_forward[0] = 1;
    nodes[0][9]->producer_forward[1] = 0;
    nodes[2][5]->producer_forward[0] = 1;
    nodes[2][5]->producer_forward[1] = 0;
    nodes[1][6]->producer_forward[0] = 1;
    nodes[1][6]->producer_forward[1] = 1;
    nodes[1][9]->producer_forward[0] = 1;
    nodes[1][9]->producer_forward[1] = 0;
    nodes[2][6]->producer_forward[0] = 1;
    nodes[2][6]->producer_forward[1] = 1;
    nodes[2][9]->producer_forward[0] = 1;
    nodes[2][9]->producer_forward[1] = 0;
    nodes[3][4]->producer_forward[0] = 1;
    nodes[3][4]->producer_forward[1] = 0;
    nodes[3][5]->producer_forward[0] = 0;
    nodes[3][5]->producer_forward[1] = 1;
    nodes[4][4]->producer_forward[0] = 1;
    nodes[4][4]->producer_forward[1] = 0;
    nodes[4][5]->producer_forward[0] = 0;
    nodes[4][5]->producer_forward[1] = 1;
    nodes[5][4]->producer_forward[0] = 1;
    nodes[5][4]->producer_forward[1] = 0;
    nodes[5][5]->producer_forward[0] = 0;
    nodes[5][5]->producer_forward[1] = 1;
    nodes[3][10]->producer_forward[0] = 0;
    nodes[3][10]->producer_forward[1] = 1;
    nodes[3][14]->producer_forward[0] = 1;
    nodes[3][14]->producer_forward[1] = 0;
    nodes[3][15]->producer_forward[0] = 1;
    nodes[3][15]->producer_forward[1] = 0;
    nodes[4][10]->producer_forward[0] = 0;
    nodes[4][10]->producer_forward[1] = 1;
    nodes[4][14]->producer_forward[0] = 1;
    nodes[4][14]->producer_forward[1] = 0;
    nodes[4][15]->producer_forward[0] = 1;
    nodes[4][15]->producer_forward[1] = 0;
    nodes[5][10]->producer_forward[0] = 0;
    nodes[5][10]->producer_forward[1] = 1;
    nodes[5][14]->producer_forward[0] = 1;
    nodes[5][14]->producer_forward[1] = 0;
    nodes[5][15]->producer_forward[0] = 1;
    nodes[5][15]->producer_forward[1] = 0;
    nodes[3][11]->producer_forward[0] = 0;
    nodes[3][11]->producer_forward[1] = 0;
    nodes[3][13]->producer_forward[0] = 0;
    nodes[3][13]->producer_forward[1] = 1;
    nodes[3][16]->producer_forward[0] = 1;
    nodes[3][16]->producer_forward[1] = 0;
    nodes[4][11]->producer_forward[0] = 0;
    nodes[4][11]->producer_forward[1] = 0;
    nodes[4][13]->producer_forward[0] = 0;
    nodes[4][13]->producer_forward[1] = 1;
    nodes[4][16]->producer_forward[0] = 1;
    nodes[4][16]->producer_forward[1] = 0;
    nodes[5][11]->producer_forward[0] = 0;
    nodes[5][11]->producer_forward[1] = 0;
    nodes[5][13]->producer_forward[0] = 0;
    nodes[5][13]->producer_forward[1] = 1;
    nodes[5][16]->producer_forward[0] = 1;
    nodes[5][16]->producer_forward[1] = 0;
    nodes[0][7]->producer_forward[0] = 1;
    nodes[0][7]->producer_forward[1] = 0;
    nodes[0][8]->producer_forward[0] = 0;
    nodes[0][8]->producer_forward[1] = 1;
    nodes[1][7]->producer_forward[0] = 1;
    nodes[1][7]->producer_forward[1] = 0;
    nodes[1][8]->producer_forward[0] = 0;
    nodes[1][8]->producer_forward[1] = 1;
    nodes[2][7]->producer_forward[0] = 1;
    nodes[2][7]->producer_forward[1] = 0;
    nodes[2][8]->producer_forward[0] = 0;
    nodes[2][8]->producer_forward[1] = 1;
    nodes[3][6]->producer_forward[0] = 1;
    nodes[3][6]->producer_forward[1] = 0;
    nodes[4][6]->producer_forward[0] = 1;
    nodes[4][6]->producer_forward[1] = 0;
    nodes[5][6]->producer_forward[0] = 1;
    nodes[5][6]->producer_forward[1] = 0;
    nodes[3][12]->producer_forward[0] = 0;
    nodes[3][12]->producer_forward[1] = 1;
    nodes[4][12]->producer_forward[0] = 0;
    nodes[4][12]->producer_forward[1] = 1;
    nodes[5][12]->producer_forward[0] = 0;
    nodes[5][12]->producer_forward[1] = 1;
#ifndef VERIFY
    nodes[0][1]->producer_forward[0] = 1;
#endif
#ifndef VERIFY
    nodes[1][1]->producer_forward[0] = 1;
#endif
#ifndef VERIFY
    nodes[2][1]->producer_forward[0] = 1;
#endif
#ifndef VERIFY
    nodes[3][1]->producer_forward[0] = 1;
#endif
#ifndef VERIFY
    nodes[4][1]->producer_forward[0] = 1;
#endif
#ifndef VERIFY
    nodes[5][1]->producer_forward[0] = 1;
#endif
    nodes[3][17]->producer_forward[0] = 1;
    nodes[4][17]->producer_forward[0] = 1;
    nodes[5][17]->producer_forward[0] = 0;
    nodes[0][0]->producer_forward[0] = 0;
    nodes[1][0]->producer_forward[0] = 0;
    nodes[2][0]->producer_forward[0] = 0;
    nodes[3][0]->producer_forward[0] = 0;
    nodes[4][0]->producer_forward[0] = 0;
    nodes[5][0]->producer_forward[0] = 0;
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

    // the following numbers are set by the bash script
    int num_canny = 3;
    int num_deblur = 0;
    int num_gru = 0;
    int num_harris = 3;
    int num_lstm = 0;

    int nodes_offset = 0;

    if (num_canny > 0) { init_canny(); }
    add_canny_dag(&nodes[nodes_offset], num_canny);
    nodes_offset += num_canny;

    if (num_harris > 0) { init_harris(); }
    add_harris_dag(&nodes[nodes_offset], num_harris);
    nodes_offset += num_harris;

    if (num_deblur > 0) { init_deblur(); }
    add_deblur_dag(&nodes[nodes_offset], num_deblur, 5);
    nodes_offset += num_deblur;

    if (num_gru > 0) { init_gru(); }
    add_gru_dag(&nodes[nodes_offset], num_gru, 8);
    nodes_offset += num_gru;

    if (num_lstm > 0) { init_lstm(); }
    add_lstm_dag(&nodes[nodes_offset], num_lstm, 8);
    nodes_offset += num_lstm;

    m5_reset_stats();

    schedule(nodes);

    m5_dump_stats();
    m5_exit();
}
