#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

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
#ifdef VERIFY
uint8_t *canny_isp_output;
#endif

void canny_process_raw(canny_data_t *img, task_struct_t **nodes)
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
    task->num_parents = 0;
    task->producer[0] = NULL;
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_READY;
    task->completed_parents = 0;

    canny_retval[0][0] = task;
    nodes[0] = task;
}

void canny_convert_to_grayscale(canny_data_t *img, task_struct_t **nodes)
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
#ifdef VERIFY
    task->num_parents = 0;
    task->producer[0] = NULL;
    task->status = REQ_STATUS_READY;
#else
    task->num_parents = 1;
    task->producer[0] = canny_retval[0][0];
    task->status = REQ_STATUS_WAITING;
#endif
    task->producer_forward[0] = 0;
    task->completed_parents = 0;

#ifndef VERIFY
    canny_retval[0][0]->children[0] = task;
#endif
    canny_retval[1][0] = task;
    nodes[1] = task;
}

void canny_noise_reduction(canny_data_t *img, task_struct_t **nodes)
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
    task->num_parents = 1;
    task->producer[0] = canny_retval[1][0];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    canny_retval[1][0]->children[0] = task;
    canny_retval[2][0] = task;
    nodes[2] = task;
}

void canny_gradient_calculation(canny_data_t *img, task_struct_t **nodes)
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
        task[i]->num_parents = 1;
        task[i]->producer[0] = canny_retval[2][0];
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

    canny_retval[2][0]->children[0] = task[0];
    canny_retval[2][0]->children[1] = task[1];
    canny_retval[3][0] = task[3];
    canny_retval[3][1] = task[6];
}

void canny_non_max_suppression(canny_data_t *img, task_struct_t **nodes)
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
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    canny_retval[3][0]->children[0] = task;
    canny_retval[3][1]->children[0] = task;
    canny_retval[4][0] = task;
    nodes[10] = task;
}

void canny_thr_and_edge_tracking(canny_data_t *img, task_struct_t **nodes)
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
    task->num_children = 0;
    task->num_parents = 1;
    task->producer[0] = canny_retval[4][0];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    canny_retval[4][0]->children[0] = task;
    nodes[11] = task;
}

void init_canny()
{
#ifdef VERIFY
    canny_isp_output = (uint8_t*) get_memory_aligned(NUM_PIXELS * 3,
            CACHELINE_SIZE);

    for (int i = 0; i < (NUM_PIXELS * 3); i++) {
        canny_isp_output[i] = i % 256;
    }
#endif
}

void add_canny_dag(task_struct_t ***nodes, int num_images)
{
    canny_data_t *imgs = (canny_data_t*)
        get_memory(num_images * sizeof(canny_data_t));

    for (int i = 0; i < num_images; i++) {
#ifdef VERIFY
        // Step 0: Link ISP output
        imgs[i].isp_img = canny_isp_output;
#else
        // Step 0: Run raw image through ISP
        canny_process_raw(&imgs[i], nodes[i]);
#endif

        // Step 1: Convert image to grayscale
        canny_convert_to_grayscale(&imgs[i], nodes[i]);

        // Step 2: Noise reduction
        canny_noise_reduction(&imgs[i], nodes[i]);

        // Step 3: Gradient calculation
        canny_gradient_calculation(&imgs[i], nodes[i]);

        // Step 4: Non-maximum suppression
        canny_non_max_suppression(&imgs[i], nodes[i]);

        // Steps 5 and 6: Double threshold and edge tracking by hysteresis
        canny_thr_and_edge_tracking(&imgs[i], nodes[i]);
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
