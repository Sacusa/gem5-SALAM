#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "scheduler.h"

#define NUM_IMAGES 1
#define ENABLE_FORWARDING
#define VERIFY

typedef struct {
    // ISP
    uint8_t *raw_img;
    uint8_t *isp_img;

    // Grayscale
    float *grayscale_img;

    // Noise reduction
    float *gauss_kernel;
    float *denoise_img;

    // Gradient calculation
    float *K_x, *K_y;
    float *I_x, *I_y, *I_xx, *I_yy, *I_xx_yy;
    float *gradient, *theta;

    // Non-maxmimum suppression
    uint32_t *max_values;

    // Edge tracking and hysteresis
    uint8_t *final_img;
} image_data_t;

task_struct_t *retval[5][3];

void process_raw(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    isp_args *args = (isp_args*) get_memory(sizeof(isp_args));

    img->raw_img = (uint8_t*) get_memory((IMG_HEIGHT+2) * (IMG_WIDTH+2));
    img->isp_img = (uint8_t*) get_memory(NUM_PIXELS * 3);

    args->input = img->raw_img;
    args->output = img->isp_img;

    task->acc_id = ACC_ISP;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 0;
    task->producer[0] = NULL;
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_READY;
    task->completed_parents = 0;

    retval[0][0] = task;
    nodes[0] = task;
}

void convert_to_grayscale(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    grayscale_args *args = (grayscale_args*)
        get_memory(sizeof(grayscale_args));

    img->grayscale_img = (float*) get_memory(NUM_PIXELS*4);

    args->input = img->isp_img;
    args->output = img->grayscale_img;

    task->acc_id = ACC_GRAYSCALE;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 1;
#ifdef VERIFY
    task->producer[0] = NULL;
    task->status = REQ_STATUS_READY;
#else
    task->producer[0] = retval[0][0];
    task->status = REQ_STATUS_WAITING;
#endif
    task->producer_forward[0] = 0;
    task->completed_parents = 0;

#ifndef VERIFY
    retval[0][0]->children[0] = task;
#endif
    retval[1][0] = task;
    nodes[1] = task;
}

void noise_reduction(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    convolution_args *args = (convolution_args*)
        get_memory(sizeof(convolution_args));

    img->gauss_kernel = (float*) get_memory(100);
    img->denoise_img = (float*) get_memory(NUM_PIXELS * 4);

    img->gauss_kernel[0]  = 0.00291502; img->gauss_kernel[1]  = 0.01306423;
    img->gauss_kernel[2]  = 0.02153928; img->gauss_kernel[3]  = 0.01306423;
    img->gauss_kernel[4]  = 0.00291502;
    img->gauss_kernel[5]  = 0.01306423; img->gauss_kernel[6]  = 0.05854983;
    img->gauss_kernel[7]  = 0.09653235; img->gauss_kernel[8]  = 0.05854983;
    img->gauss_kernel[9]  = 0.01306423;
    img->gauss_kernel[10] = 0.02153928; img->gauss_kernel[11] = 0.09653235;
    img->gauss_kernel[12] = 0.15915494; img->gauss_kernel[13] = 0.09653235;
    img->gauss_kernel[14] = 0.02153928;
    img->gauss_kernel[15] = 0.01306423; img->gauss_kernel[16] = 0.05854983;
    img->gauss_kernel[17] = 0.09653235; img->gauss_kernel[18] = 0.05854983;
    img->gauss_kernel[19] = 0.01306423;
    img->gauss_kernel[20] = 0.00291502; img->gauss_kernel[21] = 0.01306423;
    img->gauss_kernel[22] = 0.02153928; img->gauss_kernel[23] = 0.01306423;
    img->gauss_kernel[24] = 0.00291502;

    args->input = img->grayscale_img;
    args->kernel = img->gauss_kernel;
    args->output = img->denoise_img;
    args->kern_width = 5;
    args->kern_height = 5;
    args->mod_and_floor = true;

    task->acc_id = ACC_CONVOLUTION;
    task->acc_args = (void*) args;
    task->num_children = 2;
    task->num_parents = 1;
    task->producer[0] = retval[1][0];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[1][0]->children[0] = task;
    retval[2][0] = task;
    nodes[2] = task;
}

void gradient_calculation(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task[7];
    convolution_args *c_args[2];
    elem_matrix_args *em_args[5];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 7; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
    }
    for (int i = 0; i < 2; i++) {
        c_args[i] = (convolution_args*) get_memory(sizeof(convolution_args));
    }
    for (int i = 0; i < 5; i++) {
        em_args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }

    img->K_x      = (float*) get_memory(36);
    img->K_y      = (float*) get_memory(36);
    img->I_x      = (float*) get_memory(size);
    img->I_y      = (float*) get_memory(size);
    img->I_xx     = (float*) get_memory(size);
    img->I_yy     = (float*) get_memory(size);
    img->I_xx_yy  = (float*) get_memory(size);
    img->gradient = (float*) get_memory(size);
    img->theta    = (float*) get_memory(size);

    img->K_x[0] = -1; img->K_x[1] = 0; img->K_x[2] = 1;
    img->K_x[3] = -2; img->K_x[4] = 0; img->K_x[5] = 2;
    img->K_x[6] = -1; img->K_x[7] = 0; img->K_x[8] = 1;

    img->K_y[0] =  1; img->K_y[1] =  2; img->K_y[2] =  1;
    img->K_y[3] =  0; img->K_y[4] =  0; img->K_y[5] =  0;
    img->K_y[6] = -1; img->K_y[7] = -2; img->K_y[8] = -1;

    c_args[0]->input = img->denoise_img;
    c_args[0]->kernel = img->K_x;
    c_args[0]->output = img->I_x;
    c_args[0]->kern_width = 3;
    c_args[0]->kern_height = 3;
    c_args[0]->mod_and_floor = true;

    c_args[1]->input = img->denoise_img;
    c_args[1]->kernel = img->K_y;
    c_args[1]->output = img->I_y;
    c_args[1]->kern_width = 3;
    c_args[1]->kern_height = 3;
    c_args[1]->mod_and_floor = true;

    em_args[0]->arg1 = img->I_x;
    em_args[0]->arg2 = NULL;
    em_args[0]->output = img->I_xx;
    em_args[0]->is_arg2_scalar = 0;
    em_args[0]->op = SQR;
    em_args[0]->do_one_minus = 0;

    em_args[1]->arg1 = img->I_x;
    em_args[1]->arg2 = img->I_y;
    em_args[1]->output = img->theta;
    em_args[1]->is_arg2_scalar = 0;
    em_args[1]->op = ATAN2;
    em_args[1]->do_one_minus = 0;

    em_args[2]->arg1 = img->I_y;
    em_args[2]->arg2 = NULL;
    em_args[2]->output = img->I_yy;
    em_args[2]->is_arg2_scalar = 0;
    em_args[2]->op = SQR;
    em_args[2]->do_one_minus = 0;

    em_args[3]->arg1 = img->I_xx;
    em_args[3]->arg2 = img->I_yy;
    em_args[3]->output = img->I_xx_yy;
    em_args[3]->is_arg2_scalar = 0;
    em_args[3]->op = ADD;
    em_args[3]->do_one_minus = 0;

    em_args[4]->arg1 = img->I_xx_yy;
    em_args[4]->arg2 = NULL;
    em_args[4]->output = img->gradient;
    em_args[4]->is_arg2_scalar = 0;
    em_args[4]->op = SQRT;
    em_args[4]->do_one_minus = 0;

    for (int i = 0; i < 2; i++) {
        task[i]->acc_id = ACC_CONVOLUTION;
        task[i]->acc_args = (void*) c_args[i];
        task[i]->num_children = 2;
        task[i]->num_parents = 1;
        task[i]->producer[0] = retval[2][0];
        task[i]->producer_forward[0] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;
        nodes[3+i] = task[i];
    }
    for (int i = 2; i < 7; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) em_args[i-2];
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->num_children = 1;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;
        nodes[3+i] = task[i];
    }

    task[0]->children[0] = task[2];
    task[0]->children[1] = task[3];
    task[1]->children[0] = task[3];
    task[1]->children[1] = task[4];

    task[2]->children[0] = task[5];
    task[2]->num_parents = 1;
    task[2]->producer[0] = task[0];

    task[3]->num_parents = 2;
    task[3]->producer[0] = task[0];
    task[3]->producer[1] = task[1];

    task[4]->children[0] = task[5];
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[1];

    task[5]->children[0] = task[6];
    task[5]->num_parents = 2;
    task[5]->producer[0] = task[2];
    task[5]->producer[1] = task[4];

    task[6]->num_parents = 1;
    task[6]->producer[0] = task[5];

    retval[2][0]->children[0] = task[0];
    retval[2][0]->children[1] = task[1];
    retval[3][0] = task[3];
    retval[3][1] = task[6];
}

void non_max_suppression(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    canny_non_max_args *args = (canny_non_max_args*)
        get_memory(sizeof(canny_non_max_args));

    img->max_values = (uint32_t*) get_memory(NUM_PIXELS * 4);

    args->hypotenuse = img->gradient;
    args->theta = img->theta;
    args->output = img->max_values;

    task->acc_id = ACC_CANNY_NON_MAX;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 2;
    task->producer[0] = retval[3][1];
    task->producer[1] = retval[3][0];
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[3][0]->children[0] = task;
    retval[3][1]->children[0] = task;
    retval[4][0] = task;
    nodes[10] = task;
}

void thr_and_edge_tracking(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    edge_tracking_args *args = (edge_tracking_args*)
        get_memory(sizeof(edge_tracking_args));

    img->final_img = (uint8_t*) get_memory(NUM_PIXELS);

    args->input = img->max_values;
    args->thr_strong_ratio = 0.15;
    args->thr_weak_ratio = 0.05;
    args->output = img->final_img;

    task->acc_id = ACC_EDGE_TRACKING;
    task->acc_args = (void*) args;
    task->num_children = 0;
    task->num_parents = 1;
    task->producer[0] = retval[4][0];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[4][0]->children[0] = task;
    nodes[11] = task;
}

void print_dag(task_struct_t *root)
{
    task_struct_t *stage[2][5];
    int stage_len[2];

    int curr_stage = 0;
    stage[0][0] = root;
    stage_len[0] = 1;

    while (stage_len[curr_stage]) {
        int next_stage = curr_stage ^ 1;
        stage_len[next_stage] = 0;

        for (int i = 0; i < stage_len[curr_stage]; i++) {
            task_struct_t *node = stage[curr_stage][i];
            printf("\nID = %d\nEST = %d\nDeadline = %d\n", node->acc_id, node->earliest_start,
                    node->deadline);

            for (int c = 0; c < node->num_children; c++) {
                bool is_unique = true;

                for (int j = 0; j < stage_len[next_stage]; j++) {
                    if (stage[next_stage][j] == node->children[c]) {
                        is_unique = false;
                        break;
                    }
                }

                if (is_unique) {
                    stage[next_stage][stage_len[next_stage]] = node->children[c];
                    stage_len[next_stage]++;
                }
            }
        }

        printf("=====\n");
        curr_stage = next_stage;
    }
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

    run_queue_size[0][0] = 1;
    run_queue[0][0][0] = nodes[0][10];
    run_queue_size[1][0] = 2;
    run_queue[1][0][0] = nodes[0][2];
    run_queue[1][0][1] = nodes[0][3];
    run_queue_size[1][1] = 1;
    run_queue[1][1][0] = nodes[0][4];
    run_queue_size[2][0] = 1;
    run_queue[2][0][0] = nodes[0][11];
    run_queue_size[3][0] = 1;
    run_queue[3][0][0] = nodes[0][5];
    run_queue_size[3][1] = 3;
    run_queue[3][1][0] = nodes[0][7];
    run_queue[3][1][1] = nodes[0][8];
    run_queue[3][1][2] = nodes[0][9];
    run_queue_size[3][2] = 1;
    run_queue[3][2][0] = nodes[0][6];
    run_queue_size[3][3] = 0;
    run_queue_size[4][0] = 1;
    run_queue[4][0][0] = nodes[0][1];
    run_queue_size[5][0] = 0;
#ifdef VERIFY
    run_queue_size[6][0] = 0;
#else
    run_queue_size[6][0] = 1;
    run_queue[6][0][0] = nodes[0][0];
#endif

#ifdef ENABLE_FORWARDING
    nodes[0][10]->producer_forward[0] = 1;
    nodes[0][10]->producer_forward[1] = 0;
    nodes[0][2]->producer_forward[0] = 1;
    nodes[0][3]->producer_forward[0] = 1;
    nodes[0][4]->producer_forward[0] = 1;
    nodes[0][11]->producer_forward[0] = 1;
    nodes[0][5]->producer_forward[0] = 1;
    nodes[0][5]->producer_forward[1] = 0;
    nodes[0][7]->producer_forward[0] = 1;
    nodes[0][7]->producer_forward[1] = 0;
    nodes[0][8]->producer_forward[0] = 1;
    nodes[0][8]->producer_forward[1] = 1;
    nodes[0][9]->producer_forward[0] = 1;
    nodes[0][9]->producer_forward[1] = 0;
    nodes[0][6]->producer_forward[0] = 1;
    nodes[0][6]->producer_forward[1] = 1;
    nodes[0][1]->producer_forward[0] = 1;
    nodes[0][0]->producer_forward[0] = 0;
#endif

    schedule(run_queue, run_queue_size);
}

int main(int argc, char *argv[])
{
    m5_reset_stats();

    image_data_t *imgs = (image_data_t*)
        get_memory(NUM_IMAGES * sizeof(image_data_t));
    task_struct_t ***nodes = (task_struct_t***)
        get_memory(MAX_DAGS * sizeof(task_struct_t**));
    for (int i = 0; i < MAX_DAGS; i++) {
        nodes[i] = (task_struct_t **)
            get_memory(MAX_NODES * sizeof(task_struct_t*));
    }

#ifdef VERIFY
    uint8_t *isp_output = (uint8_t*) get_memory(NUM_PIXELS * 3);

    for (int i = 0; i < (NUM_PIXELS * 3); i++) {
        isp_output[i] = i % 256;
    }
#endif

    for (int i = 0; i < NUM_IMAGES; i++) {
#ifdef VERIFY
        // Step 0: Link ISP output
        imgs[i].isp_img = isp_output;
#else
        // Step 0: Run raw image through ISP
        process_raw(&imgs[i], nodes[i]);
#endif

        // Step 1: Convert image to grayscale
        convert_to_grayscale(&imgs[i], nodes[i]);

        // Step 2: Noise reduction
        noise_reduction(&imgs[i], nodes[i]);

        // Step 3: Gradient calculation
        gradient_calculation(&imgs[i], nodes[i]);

        // Step 4: Non-maximum suppression
        non_max_suppression(&imgs[i], nodes[i]);

        // Steps 5 and 6: Double threshold and edge tracking by hysteresis
        thr_and_edge_tracking(&imgs[i], nodes[i]);

        // For recording and printing dags
        //dags[i] = retval[0][0];
        //print_dag(dags[i]);
    }

    gedf(nodes);

#ifdef VERIFY
    for (int i = 0; i < NUM_IMAGES; i++) {
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Image %2d, pixel %2d, value = %d\n", i, j,
                    imgs[i].final_img[j]);
        }
    }
#endif

    m5_dump_stats();
    m5_exit();
}
