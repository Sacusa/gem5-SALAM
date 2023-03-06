#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

#define DEBLUR_DEADLINE 16667

typedef struct {
    // ISP
    uint8_t *raw_img;
    uint8_t *isp_img;

    // input image
    float *input_img;

    // convolution of ut with P
    float *conv_psf;

    // division of d by ut_P
    float *div_ut_psf;

    // convolution of d_ut_P with P*
    float *conv_psf_flip;

    // estimate after each iteration
    float *estimate;
} deblur_data_t;

float *deblur_psf;
float *deblur_psf_flip;
task_struct_t *deblur_retval[6];
#ifdef VERIFY
uint8_t *deblur_isp_output;
#endif

void deblur_init_img(deblur_data_t *img)
{
    int size = NUM_PIXELS * 4;

    img->conv_psf      = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->div_ut_psf    = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->conv_psf_flip = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->estimate      = (float*) get_memory_aligned(size, CACHELINE_SIZE);

    for (int i = 0; i < NUM_PIXELS; i++) {
        img->estimate[i] = 0.5;
    }
}

void deblur_process_raw(deblur_data_t *img, task_struct_t **nodes,
        uint32_t earliest_start)
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
    task->dag_deadline = DEBLUR_DEADLINE;
    task->node_deadline = earliest_start + 50;

    deblur_retval[0] = task;
    nodes[0] = task;
}

void deblur_convert_to_grayscale(deblur_data_t *img, task_struct_t **nodes,
        int num_iters, uint32_t earliest_start)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    grayscale_args *args = (grayscale_args*)
        get_memory(sizeof(grayscale_args));

    img->input_img = (float*) get_memory_aligned(NUM_PIXELS * 4,
            CACHELINE_SIZE);

    args->input = img->isp_img;
    args->output = img->input_img;

    task->acc_id = ACC_GRAYSCALE;
    task->acc_args = (void*) args;
    task->num_children = num_iters + 1;
#ifdef VERIFY
    task->num_parents = 0;
    task->producer[0] = NULL;
    task->status = REQ_STATUS_READY;
#else
    task->num_parents = 1;
    task->producer[0] = deblur_retval[0];
    task->status = REQ_STATUS_WAITING;
#endif
    task->producer_forward[0] = 0;
    task->completed_parents = 0;
    task->dag_deadline = DEBLUR_DEADLINE;
    task->node_deadline = earliest_start + 87;

#ifndef VERIFY
    deblur_retval[0]->children[0] = task;
#endif
    deblur_retval[1] = task;
    nodes[1] = task;
}

void deblur_run_conv_psf(deblur_data_t *img, task_struct_t **nodes,
        int node_index, bool is_first, uint32_t earliest_start)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    convolution_args *args = (convolution_args*)
        get_memory(sizeof(convolution_args));

    if (is_first) {
        args->input = img->input_img;
    }
    else {
        args->input = img->estimate;
    }
    args->kernel = deblur_psf;
    args->output = img->conv_psf;
    args->kern_width = 5;
    args->kern_height = 5;
    args->mod_and_floor = false;

    task->acc_id = ACC_CONVOLUTION;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 1;
    if (is_first) {
        task->producer[0] = deblur_retval[1];
        deblur_retval[1]->children[0] = task;
    }
    else {
        task->producer[0] = deblur_retval[5];
        deblur_retval[5]->children[0] = task;
    }
    task->status = REQ_STATUS_WAITING;
    task->producer_forward[0] = 0;
    task->completed_parents = 0;
    task->dag_deadline = DEBLUR_DEADLINE;
    task->node_deadline = earliest_start + 1576;

    deblur_retval[2] = task;
    nodes[node_index] = task;
}

void deblur_run_div_ut_psf(deblur_data_t *img, task_struct_t **nodes,
        int node_index, int iter_num, uint32_t earliest_start)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    args->arg1 = img->input_img;
    args->arg2 = img->conv_psf;
    args->output = img->div_ut_psf;
    args->is_arg2_scalar = 0;
    args->op = DIV;

    task->acc_id = ACC_ELEM_MATRIX;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 2;
    task->producer[0] = deblur_retval[1];
    task->producer[1] = deblur_retval[2];
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;
    task->dag_deadline = DEBLUR_DEADLINE;
    task->node_deadline = earliest_start + 1633;

    deblur_retval[1]->children[iter_num + 1] = task;
    deblur_retval[2]->children[0] = task;
    deblur_retval[3] = task;
    nodes[node_index] = task;
}

void deblur_run_conv_psf_flip(deblur_data_t *img, task_struct_t **nodes,
        int node_index, uint32_t earliest_start)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    convolution_args *args = (convolution_args*)
        get_memory(sizeof(convolution_args));

    args->input = img->div_ut_psf;
    args->kernel = deblur_psf_flip;
    args->output = img->conv_psf_flip;
    args->kern_width = 5;
    args->kern_height = 5;
    args->mod_and_floor = false;

    task->acc_id = ACC_CONVOLUTION;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 1;
    task->producer[0] = deblur_retval[3];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;
    task->dag_deadline = DEBLUR_DEADLINE;
    task->node_deadline = earliest_start + 3210;

    deblur_retval[3]->children[0] = task;
    deblur_retval[4] = task;
    nodes[node_index] = task;
}

void deblur_run_mult_psf_flip(deblur_data_t *img, bool is_first, bool has_child,
        task_struct_t **nodes, int node_index, uint32_t earliest_start)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));

    args->arg1 = img->estimate;
    args->arg2 = img->conv_psf_flip;
    args->output = img->estimate;
    args->is_arg2_scalar = 0;
    args->op = MUL;

    task->acc_id = ACC_ELEM_MATRIX;
    task->acc_args = (void*) args;
    if (has_child) {
        task->num_children = 2;
    }
    else {
        task->num_children = 0;
    }

    if (is_first) {
        task->num_parents = 1;
        task->producer[0] = NULL;
    }
    else {
        task->num_parents = 2;
        task->producer[0] = deblur_retval[5];
        deblur_retval[5]->children[1] = task;
    }

    task->producer[1] = deblur_retval[4];
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;
    task->dag_deadline = DEBLUR_DEADLINE;
    task->node_deadline = earliest_start + 3267;

    deblur_retval[4]->children[0] = task;
    deblur_retval[5] = task;
    nodes[node_index] = task;
}

void init_deblur()
{
    deblur_psf = (float*) get_memory_aligned(100, CACHELINE_SIZE);
    deblur_psf[0]  = 0.00291502; deblur_psf[1]  = 0.01306423;
    deblur_psf[2]  = 0.02153928; deblur_psf[3]  = 0.01306423;
    deblur_psf[4]  = 0.00291502;
    deblur_psf[5]  = 0.01306423; deblur_psf[6]  = 0.05854983;
    deblur_psf[7]  = 0.09653235; deblur_psf[8]  = 0.05854983;
    deblur_psf[9]  = 0.01306423;
    deblur_psf[10] = 0.02153928; deblur_psf[11] = 0.09653235;
    deblur_psf[12] = 0.15915494; deblur_psf[13] = 0.09653235;
    deblur_psf[14] = 0.02153928;
    deblur_psf[15] = 0.01306423; deblur_psf[16] = 0.05854983;
    deblur_psf[17] = 0.09653235; deblur_psf[18] = 0.05854983;
    deblur_psf[19] = 0.01306423;
    deblur_psf[20] = 0.00291502; deblur_psf[21] = 0.01306423;
    deblur_psf[22] = 0.02153928; deblur_psf[23] = 0.01306423;
    deblur_psf[24] = 0.00291502;

    deblur_psf_flip = (float*) get_memory_aligned(100, CACHELINE_SIZE);
    deblur_psf_flip[0]  = 0.00291502; deblur_psf_flip[1]  = 0.01306423;
    deblur_psf_flip[2]  = 0.02153928; deblur_psf_flip[3]  = 0.01306423;
    deblur_psf_flip[4]  = 0.00291502;
    deblur_psf_flip[5]  = 0.01306423; deblur_psf_flip[6]  = 0.05854983;
    deblur_psf_flip[7]  = 0.09653235; deblur_psf_flip[8]  = 0.05854983;
    deblur_psf_flip[9]  = 0.01306423;
    deblur_psf_flip[10] = 0.02153928; deblur_psf_flip[11] = 0.09653235;
    deblur_psf_flip[12] = 0.15915494; deblur_psf_flip[13] = 0.09653235;
    deblur_psf_flip[14] = 0.02153928;
    deblur_psf_flip[15] = 0.01306423; deblur_psf_flip[16] = 0.05854983;
    deblur_psf_flip[17] = 0.09653235; deblur_psf_flip[18] = 0.05854983;
    deblur_psf_flip[19] = 0.01306423;
    deblur_psf_flip[20] = 0.00291502; deblur_psf_flip[21] = 0.01306423;
    deblur_psf_flip[22] = 0.02153928; deblur_psf_flip[23] = 0.01306423;
    deblur_psf_flip[24] = 0.00291502;

#ifdef VERIFY
    deblur_isp_output = (uint8_t*) get_memory_aligned(NUM_PIXELS * 3,
            CACHELINE_SIZE);

    for (int i = 0; i < (NUM_PIXELS * 3); i++) {
        deblur_isp_output[i] = i % 256;
    }
#endif
}

void add_deblur_dag(task_struct_t ***nodes, int *num_nodes, int num_images,
        int num_iters)
{
    deblur_data_t *imgs = (deblur_data_t*)
        get_memory(num_images * sizeof(deblur_data_t));

    const uint32_t iter_runtime = 3267;

    for (int i = 0; i < num_images; i++) {
        uint32_t earliest_start = DEBLUR_DEADLINE - \
                                  (iter_runtime * num_iters) - 87;

        deblur_init_img(&imgs[i]);

#ifdef VERIFY
        // Step 0: Link ISP output
        imgs[i].isp_img = deblur_isp_output;
#else
        // Step 0: Run raw image through ISP
        deblur_process_raw(&imgs[i], nodes[i], earliest_start);
#endif

        deblur_convert_to_grayscale(&imgs[i], nodes[i], num_iters,
                earliest_start);

        earliest_start += 87;

        for (int j = 0; j < num_iters; j++) {
            int node_index = 2 + j*4;

            deblur_run_conv_psf(&imgs[i], nodes[i], node_index, j == 0,
                    earliest_start);
            deblur_run_div_ut_psf(&imgs[i], nodes[i], node_index+1, j,
                    earliest_start);
            deblur_run_conv_psf_flip(&imgs[i], nodes[i], node_index+2,
                    earliest_start);
            deblur_run_mult_psf_flip(&imgs[i], j == 0, j != (num_iters-1),
                    nodes[i], node_index+3, earliest_start);

            earliest_start += iter_runtime;
        }

        num_nodes[i] = 2 * (num_iters * 4);
    }
}

void print_deblur_output(task_struct_t ***nodes, int num_images, int num_iters)
{
    printf("Printing deblur results\n");
    printf("=======================\n");
    int node_index = 1 + (4 * num_iters);

    for (int i = 0; i < num_images; i++) {
        float *final_img =
            ((elem_matrix_args*)(nodes[i][node_index]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Image %2d, pixel %2d, value = %f\n", i, j,
                    final_img[j]);
        }
    }
}
