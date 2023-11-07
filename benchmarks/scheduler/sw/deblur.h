#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

#define DEBLUR_DEADLINE     16667
#define DEBLUR_ITER_RUNTIME 3267
#define DEBLUR_NUM_ITERS    5
#define DEBLUR_NUM_NODES    (2 + ((DEBLUR_NUM_ITERS) * 4))

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

// Dummy tasks with output sizes in the name
task_struct_t *deblur_task_100;
task_struct_t *deblur_task_16900;
task_struct_t *deblur_task_65536;

#ifdef VERIFY
task_struct_t *deblur_task_49152;
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

    dcache_flush((uint32_t) img->conv_psf     , size);
    dcache_flush((uint32_t) img->div_ut_psf   , size);
    dcache_flush((uint32_t) img->conv_psf_flip, size);
    dcache_flush((uint32_t) img->estimate     , size);
}

void deblur_process_raw(deblur_data_t *img, task_struct_t **nodes,
        uint32_t earliest_start, int rep_count)
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
        task->producer[0] = deblur_task_16900;
        task->status = REQ_STATUS_READY;
        task->completed_parents = 1;
    }
    else {
        task->producer[0] = nodes[(rep_count * DEBLUR_NUM_NODES) - 1];
        task->status = REQ_STATUS_WAITING;
        task->completed_parents = 0;
        nodes[(rep_count * DEBLUR_NUM_NODES) - 1]->children[0] = task;
    }

    task->is_first_node = true;
    task->output_size = 49152;
    task->compute_time = RUNTIME_ISP;
    task->dag_deadline = (rep_count + 1) * DEBLUR_DEADLINE;
    task->node_deadline = (rep_count * DEBLUR_DEADLINE) + earliest_start + 50;
    task->sd = (50.0 / (87 + (DEBLUR_ITER_RUNTIME * DEBLUR_NUM_ITERS))) * \
               DEBLUR_DEADLINE;

    deblur_retval[0] = task;
    nodes[rep_count * DEBLUR_NUM_NODES] = task;

    dcache_flush((uint32_t) img->raw_img, (IMG_HEIGHT+2) * (IMG_WIDTH+2));
    dcache_flush((uint32_t) img->isp_img, NUM_PIXELS * 3);
}

void deblur_convert_to_grayscale(deblur_data_t *img, task_struct_t **nodes,
        uint32_t earliest_start, int rep_count)
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
    task->num_children = DEBLUR_NUM_ITERS + 1;
    task->num_parents = 1;
#ifdef VERIFY
    task->producer[0] = deblur_task_49152;
    task->status = REQ_STATUS_READY;
    task->completed_parents = 1;
#else
    task->producer[0] = deblur_retval[0];
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;
#endif

    task->is_first_node = false;
    task->output_size = 65536;
    task->compute_time = RUNTIME_GRAYSCALE;
    task->dag_deadline = (rep_count + 1) * DEBLUR_DEADLINE;
    task->node_deadline = (rep_count * DEBLUR_DEADLINE) + earliest_start + 87;
    task->sd = (37.0 / (87 + (DEBLUR_ITER_RUNTIME * DEBLUR_NUM_ITERS))) * \
               DEBLUR_DEADLINE;

#ifndef VERIFY
    deblur_retval[0]->children[0] = task;
#endif
    deblur_retval[1] = task;
    nodes[(rep_count * DEBLUR_NUM_NODES) + 1] = task;

    dcache_flush((uint32_t) img->input_img, NUM_PIXELS * 4);
}

void deblur_run_conv_psf(deblur_data_t *img, task_struct_t **nodes,
        int node_index, bool is_first, uint32_t earliest_start, int rep_count)
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
    task->num_parents = 2;
    if (is_first) {
        task->producer[0] = deblur_retval[1];
        deblur_retval[1]->children[0] = task;
    }
    else {
        task->producer[0] = deblur_retval[5];
        deblur_retval[5]->children[0] = task;
    }
    task->producer[1] = deblur_task_100;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 1;

    task->is_first_node = false;
    task->output_size = 65536;
    task->compute_time = RUNTIME_CONVOLUTION_5;
    task->dag_deadline = (rep_count + 1) * DEBLUR_DEADLINE;
    task->node_deadline = (rep_count*DEBLUR_DEADLINE) + earliest_start + 1576;
    task->sd = (1576.0 / (87 + (DEBLUR_ITER_RUNTIME * DEBLUR_NUM_ITERS))) * \
               DEBLUR_DEADLINE;

    deblur_retval[2] = task;
    nodes[(rep_count * DEBLUR_NUM_NODES) + node_index] = task;
}

void deblur_run_div_ut_psf(deblur_data_t *img, task_struct_t **nodes,
        int node_index, int iter_num, uint32_t earliest_start, int rep_count)
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
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    task->is_first_node = false;
    task->output_size = 65536;
    task->compute_time = RUNTIME_ELEM_MATRIX_DIV;
    task->dag_deadline = (rep_count + 1) * DEBLUR_DEADLINE;
    task->node_deadline = (rep_count*DEBLUR_DEADLINE) + earliest_start + 1633;
    task->sd = (57.0 / (87 + (DEBLUR_ITER_RUNTIME * DEBLUR_NUM_ITERS))) * \
               DEBLUR_DEADLINE;

    deblur_retval[1]->children[iter_num + 1] = task;
    deblur_retval[2]->children[0] = task;
    deblur_retval[3] = task;
    nodes[(rep_count * DEBLUR_NUM_NODES) + node_index] = task;
}

void deblur_run_conv_psf_flip(deblur_data_t *img, task_struct_t **nodes,
        int node_index, uint32_t earliest_start, int rep_count)
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
    task->num_parents = 2;
    task->producer[0] = deblur_retval[3];
    task->producer[1] = deblur_task_100;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 1;

    task->is_first_node = false;
    task->output_size = 65536;
    task->compute_time = RUNTIME_CONVOLUTION_5;
    task->dag_deadline = (rep_count + 1) * DEBLUR_DEADLINE;
    task->node_deadline = (rep_count*DEBLUR_DEADLINE) + earliest_start + 3210;
    task->sd = (1577.0 / (87 + (DEBLUR_ITER_RUNTIME * DEBLUR_NUM_ITERS))) * \
               DEBLUR_DEADLINE;

    deblur_retval[3]->children[0] = task;
    deblur_retval[4] = task;
    nodes[(rep_count * DEBLUR_NUM_NODES) + node_index] = task;
}

void deblur_run_mult_psf_flip(deblur_data_t *img, bool is_first,
        bool has_child, task_struct_t **nodes, int node_index,
        uint32_t earliest_start, int rep_count, bool is_last_rep)
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
    else if (!is_last_rep) {
        task->num_children = 1;
    }
    else {
        task->num_children = 0;
    }

    task->num_parents = 2;

    if (is_first) {
        task->producer[0] = deblur_task_65536;
        task->completed_parents = 1;
    }
    else {
        task->producer[0] = deblur_retval[5];
        deblur_retval[5]->children[1] = task;
        task->completed_parents = 0;
    }

    task->producer[1] = deblur_retval[4];
    task->status = REQ_STATUS_WAITING;

    task->is_first_node = false;
    task->output_size = 65536;
    task->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task->dag_deadline = (rep_count + 1) * DEBLUR_DEADLINE;
    task->node_deadline = (rep_count*DEBLUR_DEADLINE) + earliest_start + 3267;
    task->sd = (57.0 / (87 + (DEBLUR_ITER_RUNTIME * DEBLUR_NUM_ITERS))) * \
               DEBLUR_DEADLINE;

    deblur_retval[4]->children[0] = task;
    deblur_retval[5] = task;
    nodes[(rep_count * DEBLUR_NUM_NODES) + node_index] = task;
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

    deblur_task_100 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    deblur_task_100->output_size = 100;
    deblur_task_100->status = REQ_STATUS_COMPLETED;

    deblur_task_16900 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    deblur_task_16900->output_size = 16900;
    deblur_task_16900->status = REQ_STATUS_COMPLETED;

    deblur_task_65536 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    deblur_task_65536->output_size = 65536;
    deblur_task_65536->status = REQ_STATUS_COMPLETED;

    dcache_flush((uint32_t) deblur_psf     , 100);
    dcache_flush((uint32_t) deblur_psf_flip, 100);

#ifdef VERIFY
    deblur_task_49152 = (task_struct_t*) get_memory(sizeof(task_struct_t));
    deblur_task_49152->output_size = 49152;
    deblur_task_49152->status = REQ_STATUS_COMPLETED;

    deblur_isp_output = (uint8_t*) get_memory_aligned(NUM_PIXELS * 3,
            CACHELINE_SIZE);

    for (int i = 0; i < (NUM_PIXELS * 3); i++) {
        deblur_isp_output[i] = i % 256;
    }

    dcache_flush((uint32_t) deblur_isp_output, NUM_PIXELS * 3);
#endif
}

void add_deblur_dag(task_struct_t ***nodes, int *num_nodes, int num_images)
{
    deblur_data_t *imgs = (deblur_data_t*)
        get_memory(num_images * sizeof(deblur_data_t));

    for (int i = 0; i < num_images; i++) {
        deblur_init_img(&imgs[i]);

        for (int rep = 0; rep < NUM_REPEATS; rep++) {
            uint32_t earliest_start = DEBLUR_DEADLINE - \
                (DEBLUR_ITER_RUNTIME * DEBLUR_NUM_ITERS) - 87;

#ifdef VERIFY
            // Step 0: Link ISP output
            imgs[i].isp_img = deblur_isp_output;
#else
            // Step 0: Run raw image through ISP
            deblur_process_raw(&imgs[i], nodes[i], earliest_start, rep);
#endif

            deblur_convert_to_grayscale(&imgs[i], nodes[i], earliest_start,
                    rep);

            earliest_start += 87;

            for (int j = 0; j < DEBLUR_NUM_ITERS; j++) {
                int node_index = 2 + j * 4;

                deblur_run_conv_psf(&imgs[i], nodes[i], node_index, j == 0,
                        earliest_start, rep);
                deblur_run_div_ut_psf(&imgs[i], nodes[i], node_index + 1, j,
                        earliest_start, rep);
                deblur_run_conv_psf_flip(&imgs[i], nodes[i], node_index + 2,
                        earliest_start, rep);
                deblur_run_mult_psf_flip(&imgs[i], j == 0,
                        j != (DEBLUR_NUM_ITERS - 1), nodes[i], node_index + 3,
                        earliest_start, rep, rep == (NUM_REPEATS - 1));

                earliest_start += DEBLUR_ITER_RUNTIME;
            }
        }

        num_nodes[i] = NUM_REPEATS * DEBLUR_NUM_NODES;
    }
}

void print_deblur_output(task_struct_t ***nodes, int num_images)
{
    printf("Printing deblur results\n");
    printf("=======================\n");
    int node_index = 1 + (4 * DEBLUR_NUM_ITERS);

    for (int i = 0; i < num_images; i++) {
        float *final_img =
            ((elem_matrix_args*)(nodes[i][node_index]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Image %2d, pixel %2d, value = %f\n", i, j,
                    final_img[j]);
        }
    }
}
