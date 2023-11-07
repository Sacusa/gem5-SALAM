#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

#define CANNY_DEADLINE  16667
#define CANNY_NUM_NODES 12

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
} canny_data_t;

task_struct_t *canny_retval[5][3];

// Dummy tasks with output sizes in the name
task_struct_t *canny_task_36;
task_struct_t *canny_task_100;
task_struct_t *canny_task_16900;

#ifdef VERIFY
task_struct_t *canny_task_49152;
uint8_t *canny_isp_output;
#endif

void canny_process_raw(canny_data_t *img, task_struct_t **nodes, int rep_count)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    isp_args *args = (isp_args*) get_memory(sizeof(isp_args));

    img->raw_img = (uint8_t*) get_memory_aligned(
            (IMG_HEIGHT+2) * (IMG_WIDTH+2), CACHELINE_SIZE);
    img->isp_img = (uint8_t*) get_memory_aligned(NUM_PIXELS * 3,
            CACHELINE_SIZE);

    args->input = img->raw_img;
    args->output = img->isp_img;

    task->acc_id = ACC_ISP;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 1;

    if (rep_count == 0) {
        task->producer[0] = canny_task_16900;
        task->status = REQ_STATUS_READY;
        task->completed_parents = 1;
    }
    else {
        task->producer[0] = nodes[(CANNY_NUM_NODES * rep_count) - 1];
        task->status = REQ_STATUS_WAITING;
        task->completed_parents = 0;
        nodes[(CANNY_NUM_NODES * rep_count) - 1]->children[0] = task;
    }

    task->is_first_node = true;
    task->output_size = 49152;
    task->compute_time = RUNTIME_ISP;
    task->dag_deadline = (rep_count + 1) * CANNY_DEADLINE;
    task->node_deadline = (rep_count * CANNY_DEADLINE) + 13564;
    task->sd = 0.01494 * CANNY_DEADLINE;

    canny_retval[0][0] = task;
    nodes[rep_count * CANNY_NUM_NODES] = task;

    dcache_flush((uint32_t) img->raw_img, (IMG_HEIGHT+2) * (IMG_WIDTH+2));
    dcache_flush((uint32_t) img->isp_img, NUM_PIXELS * 3);
}

void canny_convert_to_grayscale(canny_data_t *img, task_struct_t **nodes,
        int rep_count)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    grayscale_args *args = (grayscale_args*)
        get_memory(sizeof(grayscale_args));

    img->grayscale_img = (float*) get_memory_aligned(NUM_PIXELS * 4,
            CACHELINE_SIZE);

    args->input = img->isp_img;
    args->output = img->grayscale_img;

    task->acc_id = ACC_GRAYSCALE;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 1;
#ifdef VERIFY
    task->producer[0] = canny_task_49152;
    task->status = REQ_STATUS_READY;
    task->completed_parents = 1;
    task->is_first_node = true;
#else
    task->producer[0] = canny_retval[0][0];
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;
    task->is_first_node = false;
#endif

    task->output_size = 65536;
    task->compute_time = RUNTIME_GRAYSCALE;
    task->dag_deadline = (rep_count + 1) * CANNY_DEADLINE;
    task->node_deadline = (rep_count * CANNY_DEADLINE) + 13601;
    task->sd = 0.01176 * CANNY_DEADLINE;

#ifndef VERIFY
    canny_retval[0][0]->children[0] = task;
#endif
    canny_retval[1][0] = task;
    nodes[(rep_count * CANNY_NUM_NODES) + 1] = task;

    dcache_flush((uint32_t) img->grayscale_img, NUM_PIXELS * 4);
}

void canny_noise_reduction(canny_data_t *img, task_struct_t **nodes,
        int rep_count)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    convolution_args *args = (convolution_args*)
        get_memory(sizeof(convolution_args));

    img->gauss_kernel = (float*) get_memory_aligned(100, CACHELINE_SIZE);
    img->denoise_img = (float*) get_memory_aligned(NUM_PIXELS * 4,
            CACHELINE_SIZE);

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
    task->num_parents = 2;
    task->producer[0] = canny_retval[1][0];
    task->producer[1] = canny_task_100;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 1;

    task->is_first_node = false;
    task->output_size = 65536;
    task->compute_time = RUNTIME_CONVOLUTION_5;
    task->dag_deadline = (rep_count + 1) * CANNY_DEADLINE;
    task->node_deadline = (rep_count * CANNY_DEADLINE) + 15177;
    task->sd = 0.49952 * CANNY_DEADLINE;

    canny_retval[1][0]->children[0] = task;
    canny_retval[2][0] = task;
    nodes[(rep_count * CANNY_NUM_NODES) + 2] = task;

    dcache_flush((uint32_t) (img->gauss_kernel), 100);
    dcache_flush((uint32_t) (img->denoise_img),  NUM_PIXELS * 4);
}

void canny_gradient_calculation(canny_data_t *img, task_struct_t **nodes,
        int rep_count)
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

    img->K_x      = (float*) get_memory_aligned(36, CACHELINE_SIZE);
    img->K_y      = (float*) get_memory_aligned(36, CACHELINE_SIZE);
    img->I_x      = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_y      = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_xx     = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_yy     = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_xx_yy  = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->gradient = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->theta    = (float*) get_memory_aligned(size, CACHELINE_SIZE);

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
        task[i]->num_parents = 2;
        task[i]->producer[0] = canny_retval[2][0];
        task[i]->producer[1] = canny_task_36;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 1;
        task[i]->dag_deadline = (rep_count + 1) * CANNY_DEADLINE;
        task[i]->is_first_node = false;
        nodes[(rep_count * CANNY_NUM_NODES) + 3 + i] = task[i];
    }
    for (int i = 2; i < 7; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) em_args[i-2];
        task[i]->num_children = 1;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;
        task[i]->dag_deadline = (rep_count + 1) * CANNY_DEADLINE;
        task[i]->is_first_node = false;
        nodes[(rep_count * CANNY_NUM_NODES) + 3 + i] = task[i];
    }

    task[0]->children[0] = task[2];
    task[0]->children[1] = task[3];
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_CONVOLUTION_3;
    task[0]->node_deadline = (rep_count * CANNY_DEADLINE) + 15846;
    task[0]->sd = 0.21272 * CANNY_DEADLINE;

    task[1]->children[0] = task[3];
    task[1]->children[1] = task[4];
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_CONVOLUTION_3;
    task[1]->node_deadline = (rep_count * CANNY_DEADLINE) + 15846;
    task[1]->sd = 0.21272 * CANNY_DEADLINE;

    task[2]->children[0] = task[5];
    task[2]->num_parents = 1;
    task[2]->producer[0] = task[0];
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_SQR;
    task[2]->node_deadline = (rep_count * CANNY_DEADLINE) + 15885;
    task[2]->sd = 0.0124 * CANNY_DEADLINE;

    task[3]->num_parents = 2;
    task[3]->producer[0] = task[0];
    task[3]->producer[1] = task[1];
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_ELEM_MATRIX_ATAN2;
    task[3]->node_deadline = (rep_count * CANNY_DEADLINE) + 15981;
    task[3]->sd = 0.0124 * CANNY_DEADLINE;

    task[4]->children[0] = task[5];
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[1];
    task[4]->output_size = 65536;
    task[4]->compute_time = RUNTIME_ELEM_MATRIX_SQR;
    task[4]->node_deadline = (rep_count * CANNY_DEADLINE) + 15885;
    task[4]->sd = 0.0124 * CANNY_DEADLINE;

    task[5]->children[0] = task[6];
    task[5]->num_parents = 2;
    task[5]->producer[0] = task[2];
    task[5]->producer[1] = task[4];
    task[5]->output_size = 65536;
    task[5]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[5]->node_deadline = (rep_count * CANNY_DEADLINE) + 15942;
    task[5]->sd = 0.01812 * CANNY_DEADLINE;

    task[6]->num_parents = 1;
    task[6]->producer[0] = task[5];
    task[6]->output_size = 65536;
    task[6]->compute_time = RUNTIME_ELEM_MATRIX_SQRT;
    task[6]->node_deadline = (rep_count * CANNY_DEADLINE) + 15981;
    task[6]->sd = 0.0124 * CANNY_DEADLINE;

    canny_retval[2][0]->children[0] = task[0];
    canny_retval[2][0]->children[1] = task[1];
    canny_retval[3][0] = task[3];
    canny_retval[3][1] = task[6];

    dcache_flush((uint32_t) (img->K_x)      ,36);
    dcache_flush((uint32_t) (img->K_y)      ,36);
    dcache_flush((uint32_t) (img->I_x)      ,size);
    dcache_flush((uint32_t) (img->I_y)      ,size);
    dcache_flush((uint32_t) (img->I_xx)     ,size);
    dcache_flush((uint32_t) (img->I_yy)     ,size);
    dcache_flush((uint32_t) (img->I_xx_yy)  ,size);
    dcache_flush((uint32_t) (img->gradient) ,size);
    dcache_flush((uint32_t) (img->theta)    ,size);
}

void canny_non_max_suppression(canny_data_t *img, task_struct_t **nodes,
        int rep_count)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    canny_non_max_args *args = (canny_non_max_args*)
        get_memory(sizeof(canny_non_max_args));

    img->max_values = (uint32_t*) get_memory_aligned(NUM_PIXELS * 4,
            CACHELINE_SIZE);

    args->hypotenuse = img->gradient;
    args->theta = img->theta;
    args->output = img->max_values;

    task->acc_id = ACC_CANNY_NON_MAX;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 2;
    task->producer[0] = canny_retval[3][1];
    task->producer[1] = canny_retval[3][0];
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    task->is_first_node = false;
    task->output_size = 65536;
    task->compute_time = RUNTIME_CANNY_NON_MAX;
    task->dag_deadline = (rep_count + 1) * CANNY_DEADLINE;
    task->node_deadline = (rep_count * CANNY_DEADLINE) + 16427;
    task->sd = 0.14181 * CANNY_DEADLINE;

    canny_retval[3][0]->children[0] = task;
    canny_retval[3][1]->children[0] = task;
    canny_retval[4][0] = task;
    nodes[(rep_count * CANNY_NUM_NODES) + 10] = task;

    dcache_flush((uint32_t) (img->max_values), NUM_PIXELS * 4);
}

void canny_thr_and_edge_tracking(canny_data_t *img, task_struct_t **nodes,
        int rep_count, bool is_last_node)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    edge_tracking_args *args = (edge_tracking_args*)
        get_memory(sizeof(edge_tracking_args));

    img->final_img = (uint8_t*) get_memory_aligned(NUM_PIXELS, CACHELINE_SIZE);

    args->input = img->max_values;
    args->thr_strong_ratio = 0.5;
    args->thr_weak_ratio = 0.503;
    args->output = img->final_img;

    task->acc_id = ACC_EDGE_TRACKING;
    task->acc_args = (void*) args;
    if (is_last_node) {
        task->num_children = 0;
    }
    else {
        task->num_children = 1;
    }
    task->num_parents = 1;
    task->producer[0] = canny_retval[4][0];
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    task->is_first_node = false;
    task->output_size = 16384;
    task->compute_time = RUNTIME_EDGE_TRACKING;
    task->dag_deadline = (rep_count + 1) * CANNY_DEADLINE;
    task->node_deadline = (rep_count * CANNY_DEADLINE) + 16667;
    task->sd = 0.07631 * CANNY_DEADLINE;

    canny_retval[4][0]->children[0] = task;
    nodes[(rep_count * CANNY_NUM_NODES) + 11] = task;

    dcache_flush((uint32_t) (img->final_img), NUM_PIXELS);
}

void init_canny()
{
    canny_task_36 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    canny_task_36->output_size = 36;
    canny_task_36->status = REQ_STATUS_COMPLETED;

    canny_task_100 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    canny_task_100->output_size = 100;
    canny_task_100->status = REQ_STATUS_COMPLETED;

    canny_task_16900 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    canny_task_16900->output_size = 16900;
    canny_task_16900->status = REQ_STATUS_COMPLETED;

#ifdef VERIFY
    canny_task_49152 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    canny_task_49152->output_size = 49152;
    canny_task_49152->status = REQ_STATUS_COMPLETED;

    canny_isp_output = (uint8_t*) get_memory_aligned(NUM_PIXELS * 3,
            CACHELINE_SIZE);

    for (int i = 0; i < (NUM_PIXELS * 3); i++) {
        canny_isp_output[i] = i % 256;
    }

    dcache_flush((uint32_t) (canny_isp_output), NUM_PIXELS * 3);
#endif
}

void add_canny_dag(task_struct_t ***nodes, int *num_nodes, int num_images)
{
    canny_data_t *imgs = (canny_data_t*)
        get_memory(num_images * sizeof(canny_data_t));

    for (int i = 0; i < num_images; i++) {
        for (int rep = 0; rep < NUM_REPEATS; rep++) {
#ifdef VERIFY
            // Step 0: Link ISP output
            imgs[i].isp_img = canny_isp_output;
#else
            // Step 0: Run raw image through ISP
            canny_process_raw(&imgs[i], nodes[i], rep);
#endif

            // Step 1: Convert image to grayscale
            canny_convert_to_grayscale(&imgs[i], nodes[i], rep);

            // Step 2: Noise reduction
            canny_noise_reduction(&imgs[i], nodes[i], rep);

            // Step 3: Gradient calculation
            canny_gradient_calculation(&imgs[i], nodes[i], rep);

            // Step 4: Non-maximum suppression
            canny_non_max_suppression(&imgs[i], nodes[i], rep);

            // Steps 5 and 6: Double threshold and edge tracking by hysteresis
            canny_thr_and_edge_tracking(&imgs[i], nodes[i], rep,
                    rep == (NUM_REPEATS - 1));
        }

        num_nodes[i] = CANNY_NUM_NODES * NUM_REPEATS;
    }
}

void print_canny_output(task_struct_t ***nodes, int num_images)
{
    printf("Printing canny results\n");
    printf("======================\n");

    for (int i = 0; i < num_images; i++) {
        uint8_t *final_img =
            ((edge_tracking_args*)(nodes[i][11]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Image %2d, pixel %2d, value = %d\n", i, j,
                    final_img[j]);
        }
    }
}
