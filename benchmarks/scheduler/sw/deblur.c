#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "runtime.h"

#define NUM_IMAGES 1
#define NUM_ITERS 2
#define ENABLE_FORWARDING
#define VERIFY

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
} image_data_t;

float *psf;
float *psf_flip;

task_struct_t *retval[6];

void init_img(image_data_t *img)
{
    int size = NUM_PIXELS * 4;

    img->conv_psf      = (float*) get_memory(size);
    img->div_ut_psf    = (float*) get_memory(size);
    img->conv_psf_flip = (float*) get_memory(size);
    img->estimate      = (float*) get_memory(size);

    for (int i = 0; i < NUM_PIXELS; i++) {
        img->estimate[i] = 0.5;
    }
}

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

    retval[0] = task;
    nodes[0] = task;
}

void convert_to_grayscale(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    grayscale_args *args = (grayscale_args*)
        get_memory(sizeof(grayscale_args));

    img->input_img = (float*) get_memory(NUM_PIXELS * 4);

    args->input = img->isp_img;
    args->output = img->input_img;

    task->acc_id = ACC_GRAYSCALE;
    task->acc_args = (void*) args;
    task->num_children = NUM_ITERS;
#ifdef VERIFY
    task->num_parents = 0;
    task->producer[0] = NULL;
    task->status = REQ_STATUS_READY;
#else
    task->num_parents = 1;
    task->producer[0] = retval[0];
    task->status = REQ_STATUS_WAITING;
#endif
    task->producer_forward[0] = 0;
    task->completed_parents = 0;

#ifndef VERIFY
    retval[0]->children[0] = task;
#endif
    retval[1] = task;
    nodes[1] = task;
}

void run_conv_psf(image_data_t *img, task_struct_t **nodes,
        int node_index, bool is_first)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    convolution_args *args = (convolution_args*)
        get_memory(sizeof(convolution_args));

    args->input = img->estimate;
    args->kernel = psf;
    args->output = img->conv_psf;
    args->kern_width = 5;
    args->kern_height = 5;
    args->mod_and_floor = false;

    task->acc_id = ACC_CONVOLUTION;
    task->acc_args = (void*) args;
    task->num_children = 1;
    if (is_first) {
        task->num_parents = 0;
        task->producer[0] = NULL;
        task->status = REQ_STATUS_READY;
    }
    else {
        task->num_parents = 1;
        task->producer[0] = retval[5];
        task->status = REQ_STATUS_WAITING;
        retval[5]->children[0] = task;
    }
    task->producer_forward[0] = 0;
    task->completed_parents = 0;

    retval[2] = task;
    nodes[node_index] = task;
}

void run_div_ut_psf(image_data_t *img, task_struct_t **nodes,
        int node_index, int iter_num)
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
    task->producer[0] = retval[1];
    task->producer[1] = retval[2];
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[1]->children[iter_num] = task;
    retval[2]->children[0] = task;
    retval[3] = task;
    nodes[node_index] = task;
}

void run_conv_psf_flip(image_data_t *img, task_struct_t **nodes,
        int node_index)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    convolution_args *args = (convolution_args*)
        get_memory(sizeof(convolution_args));

    args->input = img->div_ut_psf;
    args->kernel = psf_flip;
    args->output = img->conv_psf_flip;
    args->kern_width = 5;
    args->kern_height = 5;
    args->mod_and_floor = false;

    task->acc_id = ACC_CONVOLUTION;
    task->acc_args = (void*) args;
    task->num_children = 1;
    task->num_parents = 1;
    task->producer[0] = retval[3];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[3]->children[0] = task;
    retval[4] = task;
    nodes[node_index] = task;
}

void run_mult_psf_flip(image_data_t *img, bool is_first, bool has_child,
        task_struct_t **nodes, int node_index)
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
        task->producer[0] = retval[5];
        retval[5]->children[1] = task;
    }

    task->producer[1] = retval[4];
    task->producer_forward[0] = 0;
    task->producer_forward[1] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[4]->children[0] = task;
    retval[5] = task;
    nodes[node_index] = task;
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

    run_queue_size[0][0] = 0;
    run_queue_size[1][0] = 4;
    run_queue[1][0][0] = nodes[0][2];
    run_queue[1][0][1] = nodes[0][4];
    run_queue[1][0][2] = nodes[0][6];
    run_queue[1][0][3] = nodes[0][8];
    run_queue_size[1][1] = 0;
    run_queue_size[2][0] = 0;
    run_queue_size[3][0] = 4;
    run_queue[3][0][0] = nodes[0][3];
    run_queue[3][0][1] = nodes[0][5];
    run_queue[3][0][2] = nodes[0][7];
    run_queue[3][0][3] = nodes[0][9];
    run_queue_size[3][1] = 0;
    run_queue_size[3][2] = 0;
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
    nodes[0][2]->producer_forward[0] = 0;
    nodes[0][4]->producer_forward[0] = 1;
    nodes[0][6]->producer_forward[0] = 1;
    nodes[0][8]->producer_forward[0] = 1;
    nodes[0][3]->producer_forward[0] = 0;
    nodes[0][3]->producer_forward[1] = 1;
    nodes[0][5]->producer_forward[0] = 0;
    nodes[0][5]->producer_forward[1] = 1;
    nodes[0][7]->producer_forward[0] = 0;
    nodes[0][7]->producer_forward[1] = 1;
    nodes[0][9]->producer_forward[0] = 0;
    nodes[0][9]->producer_forward[1] = 1;
#ifndef VERIFY
    nodes[0][1]->producer_forward[0] = 1;
#endif
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

    psf = (float*) get_memory(100);
    psf[0]  = 0.00291502; psf[1]  = 0.01306423; psf[2]  = 0.02153928;
    psf[3]  = 0.01306423; psf[4]  = 0.00291502;
    psf[5]  = 0.01306423; psf[6]  = 0.05854983; psf[7]  = 0.09653235;
    psf[8]  = 0.05854983; psf[9]  = 0.01306423;
    psf[10] = 0.02153928; psf[11] = 0.09653235; psf[12] = 0.15915494;
    psf[13] = 0.09653235; psf[14] = 0.02153928;
    psf[15] = 0.01306423; psf[16] = 0.05854983; psf[17] = 0.09653235;
    psf[18] = 0.05854983; psf[19] = 0.01306423;
    psf[20] = 0.00291502; psf[21] = 0.01306423; psf[22] = 0.02153928;
    psf[23] = 0.01306423; psf[24] = 0.00291502;

    psf_flip = (float*) get_memory(100);
    psf_flip[0]  = 0.00291502; psf_flip[1]  = 0.01306423;
    psf_flip[2]  = 0.02153928; psf_flip[3]  = 0.01306423;
    psf_flip[4]  = 0.00291502;
    psf_flip[5]  = 0.01306423; psf_flip[6]  = 0.05854983;
    psf_flip[7]  = 0.09653235; psf_flip[8]  = 0.05854983;
    psf_flip[9]  = 0.01306423;
    psf_flip[10] = 0.02153928; psf_flip[11] = 0.09653235;
    psf_flip[12] = 0.15915494; psf_flip[13] = 0.09653235;
    psf_flip[14] = 0.02153928;
    psf_flip[15] = 0.01306423; psf_flip[16] = 0.05854983;
    psf_flip[17] = 0.09653235; psf_flip[18] = 0.05854983;
    psf_flip[19] = 0.01306423;
    psf_flip[20] = 0.00291502; psf_flip[21] = 0.01306423;
    psf_flip[22] = 0.02153928; psf_flip[23] = 0.01306423;
    psf_flip[24] = 0.00291502;

#ifdef VERIFY
    uint8_t *isp_output = (uint8_t*) get_memory(NUM_PIXELS * 3);

    for (int i = 0; i < (NUM_PIXELS * 3); i++) {
        isp_output[i] = i % 128;
    }
#endif

    for (int i = 0; i < NUM_IMAGES; i++) {
        init_img(&imgs[i]);

#ifdef VERIFY
        // Step 0: Link ISP output
        imgs[i].isp_img = isp_output;
#else
        // Step 0: Run raw image through ISP
        process_raw(&imgs[i], nodes[i]);
#endif

        convert_to_grayscale(&imgs[i], nodes[i]);

        for (int j = 0; j < NUM_ITERS; j++) {
            int node_index = 2 + j*4;

            run_conv_psf(&imgs[i], nodes[i], node_index, j == 0);
            run_div_ut_psf(&imgs[i], nodes[i], node_index+1, j);
            run_conv_psf_flip(&imgs[i], nodes[i], node_index+2);
            run_mult_psf_flip(&imgs[i], j == 0, j != (NUM_ITERS-1), nodes[i],
                    node_index+3);
        }
    }

    gedf(nodes);

#ifdef VERIFY
    for (int i = 0; i < NUM_IMAGES; i++) {
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Image %2d, pixel %2d, value = %f\n", i, j,
                    imgs[i].estimate[j]);
        }
    }
#endif

    m5_dump_stats();
    m5_exit();
}
