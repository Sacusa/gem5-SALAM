#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "runtime.h"

#define NUM_IMAGES 10
#define ENABLE_FORWARDING
//#define VERIFY

typedef struct {
    // ISP
    uint8_t *raw_img;
    uint8_t *isp_img;

    // Grayscale
    float *grayscale_img;

    // Spatial derivative
    float *K_x, *K_y;
    float *I_x, *I_y;

    // Structure tensor
    float *I_xx, *I_xy, *I_yy;
    float *gauss_kernel;
    float *I_xx_g, *I_xy_g, *I_yy_g;

    // Harris response
    float *k;
    float *detA1, *detA2, *detA;
    float *traceA;
    float *hr1, *hr2, *harris_response;

    // Non-max suppression
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

    img->grayscale_img = (float*) get_memory(NUM_PIXELS * 4);

    args->input = img->isp_img;
    args->output = img->grayscale_img;

    task->acc_id = ACC_GRAYSCALE;
    task->acc_args = (void*) args;
    task->num_children = 2;
#ifdef VERIFY
    task->num_parents = 0;
    task->producer[0] = NULL;
    task->status = REQ_STATUS_READY;
#else
    task->num_parents = 1;
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

void spatial_derivative_calc(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task[2];
    convolution_args *args[2];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 2; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (convolution_args*) get_memory(sizeof(convolution_args));
    }

    img->K_x = (float*) get_memory(36);
    img->K_y = (float*) get_memory(36);
    img->I_x = (float*) get_memory(size);
    img->I_y = (float*) get_memory(size);

    img->K_x[0] = -1; img->K_x[1] = 0; img->K_x[2] = 1;
    img->K_x[3] = -2; img->K_x[4] = 0; img->K_x[5] = 2;
    img->K_x[6] = -1; img->K_x[7] = 0; img->K_x[8] = 1;

    img->K_y[0] =  1; img->K_y[1] =  2; img->K_y[2] =  1;
    img->K_y[3] =  0; img->K_y[4] =  0; img->K_y[5] =  0;
    img->K_y[6] = -1; img->K_y[7] = -2; img->K_y[8] = -1;

    args[0]->input = img->grayscale_img;
    args[0]->kernel = img->K_x;
    args[0]->output = img->I_x;
    args[0]->kern_width = 3;
    args[0]->kern_height = 3;
    args[0]->mod_and_floor = true;

    args[1]->input = img->grayscale_img;
    args[1]->kernel = img->K_y;
    args[1]->output = img->I_y;
    args[1]->kern_width = 3;
    args[1]->kern_height = 3;
    args[1]->mod_and_floor = true;

    for (int i = 0; i < 2; i++) {
        task[i]->acc_id = ACC_CONVOLUTION;
        task[i]->acc_args = (void*) args[i];
        task[i]->num_children = 2;
        task[i]->num_parents = 1;
        task[i]->producer[0] = retval[1][0];
        task[i]->producer_forward[0] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;

        retval[1][0]->children[i] = task[i];
        retval[2][i] = task[i];
        nodes[i+2] = task[i];
    }
}

void structure_tensor_setup(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task[6];
    elem_matrix_args *em_args[3];
    convolution_args *c_args[3];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 6; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
    }
    for (int i = 0; i < 3; i++) {
        em_args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
        c_args[i] = (convolution_args*) get_memory(sizeof(convolution_args));
    }
    img->I_xx = (float*) get_memory(size);
    img->I_xy = (float*) get_memory(size);
    img->I_yy = (float*) get_memory(size);
    img->I_xx_g = (float*) get_memory(size);
    img->I_xy_g = (float*) get_memory(size);
    img->I_yy_g = (float*) get_memory(size);
    img->gauss_kernel = (float*) get_memory(100);

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

    em_args[0]->arg1 = img->I_x;
    em_args[0]->arg2 = NULL;
    em_args[0]->output = img->I_xx;
    em_args[0]->is_arg2_scalar = 0;
    em_args[0]->op = SQR;
    em_args[0]->do_one_minus = 0;

    em_args[1]->arg1 = img->I_x;
    em_args[1]->arg2 = img->I_y;
    em_args[1]->output = img->I_xy;
    em_args[1]->is_arg2_scalar = 0;
    em_args[1]->op = MUL;
    em_args[1]->do_one_minus = 0;

    em_args[2]->arg1 = img->I_y;
    em_args[2]->arg2 = NULL;
    em_args[2]->output = img->I_yy;
    em_args[2]->is_arg2_scalar = 0;
    em_args[2]->op = SQR;
    em_args[2]->do_one_minus = 0;

    c_args[0]->input = img->I_xx;
    c_args[0]->kernel = img->gauss_kernel;
    c_args[0]->output = img->I_xx_g;
    c_args[0]->kern_width = 5;
    c_args[0]->kern_height = 5;
    c_args[0]->mod_and_floor = true;

    c_args[1]->input = img->I_xy;
    c_args[1]->kernel = img->gauss_kernel;
    c_args[1]->output = img->I_xy_g;
    c_args[1]->kern_width = 5;
    c_args[1]->kern_height = 5;
    c_args[1]->mod_and_floor = true;

    c_args[2]->input = img->I_yy;
    c_args[2]->kernel = img->gauss_kernel;
    c_args[2]->output = img->I_yy_g;
    c_args[2]->kern_width = 5;
    c_args[2]->kern_height = 5;
    c_args[2]->mod_and_floor = true;

    for (int i = 0; i < 3; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) em_args[i];
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->producer[0] = NULL;
        task[i]->producer[1] = NULL;
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->completed_parents = 0;

        task[i+3]->acc_id = ACC_CONVOLUTION;
        task[i+3]->acc_args = (void*) c_args[i];
        task[i+3]->status = REQ_STATUS_WAITING;
        task[i+3]->producer[0] = NULL;
        task[i+3]->producer_forward[0] = 0;
        task[i+3]->completed_parents = 0;

        retval[3][i] = task[i+3];
        nodes[i+4] = task[i];
        nodes[i+7] = task[i+3];
    }

    task[0]->num_children = 1;
    task[0]->children[0] = task[3];
    task[0]->num_parents = 1;
    task[0]->producer[0] = retval[2][0];

    task[1]->num_children = 1;
    task[1]->children[0] = task[4];
    task[1]->num_parents = 2;
    task[1]->producer[0] = retval[2][0];
    task[1]->producer[1] = retval[2][1];

    task[2]->num_children = 1;
    task[2]->children[0] = task[5];
    task[2]->num_parents = 1;
    task[2]->producer[0] = retval[2][1];

    task[3]->num_children = 2;
    task[3]->num_parents = 1;
    task[3]->producer[0] = task[0];

    task[4]->num_children = 1;
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[1];

    task[5]->num_children = 2;
    task[5]->num_parents = 1;
    task[5]->producer[0] = task[2];

    retval[2][0]->children[0] = task[0];
    retval[2][0]->children[1] = task[1];
    retval[2][1]->children[0] = task[1];
    retval[2][1]->children[1] = task[2];
}

void harris_response_calc(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task[7];
    elem_matrix_args *args[7];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 7; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }
    img->detA1  = (float*) get_memory(size);
    img->detA2  = (float*) get_memory(size);
    img->detA   = (float*) get_memory(size);
    img->traceA = (float*) get_memory(size);
    img->k      = (float*) get_memory(4);
    img->hr1    = (float*) get_memory(size);
    img->hr2    = (float*) get_memory(size);
    img->harris_response = (float*) get_memory(size);

    *img->k = 0.05;

    args[0]->arg1 = img->I_xx_g;
    args[0]->arg2 = img->I_yy_g;
    args[0]->output = img->detA1;
    args[0]->is_arg2_scalar = 0;
    args[0]->op = MUL;
    args[0]->do_one_minus = 0;

    args[1]->arg1 = img->I_xy_g;
    args[1]->arg2 = NULL;
    args[1]->output = img->detA2;
    args[1]->is_arg2_scalar = 0;
    args[1]->op = SQR;
    args[1]->do_one_minus = 0;

    args[2]->arg1 = img->I_xx_g;
    args[2]->arg2 = img->I_yy_g;
    args[2]->output = img->traceA;
    args[2]->is_arg2_scalar = 0;
    args[2]->op = ADD;
    args[2]->do_one_minus = 0;

    args[3]->arg1 = img->detA1;
    args[3]->arg2 = img->detA2;
    args[3]->output = img->detA;
    args[3]->is_arg2_scalar = 0;
    args[3]->op = SUB;
    args[3]->do_one_minus = 0;

    args[4]->arg1 = img->traceA;
    args[4]->arg2 = NULL;
    args[4]->output = img->hr1;
    args[4]->is_arg2_scalar = 0;
    args[4]->op = SQR;
    args[4]->do_one_minus = 0;

    args[5]->arg1 = img->hr1;
    args[5]->arg2 = img->k;
    args[5]->output = img->hr2;
    args[5]->is_arg2_scalar = 1;
    args[5]->op = MUL;
    args[5]->do_one_minus = 0;

    args[6]->arg1 = img->detA;
    args[6]->arg2 = img->hr2;
    args[6]->output = img->harris_response;
    args[6]->is_arg2_scalar = 0;
    args[6]->op = SUB;
    args[6]->do_one_minus = 0;

    for (int i = 0; i < 7; i++) {
        task[i]->acc_id = ACC_ELEM_MATRIX;
        task[i]->acc_args = (void*) args[i];
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->producer[0] = NULL;
        task[i]->producer[1] = NULL;
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->completed_parents = 0;
        nodes[i+10] = task[i];
    }

    task[0]->num_children = 1;
    task[0]->children[0] = task[3];
    task[0]->num_parents = 2;
    task[0]->producer[0] = retval[3][0];
    task[0]->producer[1] = retval[3][2];

    task[1]->num_children = 1;
    task[1]->children[0] = task[3];
    task[1]->num_parents = 1;
    task[1]->producer[0] = retval[3][1];

    task[2]->num_children = 1;
    task[2]->children[0] = task[4];
    task[2]->num_parents = 2;
    task[2]->producer[0] = retval[3][0];
    task[2]->producer[1] = retval[3][2];

    task[3]->num_children = 1;
    task[3]->children[0] = task[6];
    task[3]->num_parents = 2;
    task[3]->producer[0] = task[0];
    task[3]->producer[1] = task[1];

    task[4]->num_children = 1;
    task[4]->children[0] = task[5];
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[2];

    task[5]->num_children = 1;
    task[5]->children[0] = task[6];
    task[5]->num_parents = 1;
    task[5]->producer[0] = task[4];

    task[6]->num_children = 1;
    task[6]->num_parents = 2;
    task[6]->producer[0] = task[3];
    task[6]->producer[1] = task[5];

    retval[3][0]->children[0] = task[0];
    retval[3][0]->children[1] = task[2];
    retval[3][1]->children[0] = task[1];
    retval[3][2]->children[0] = task[0];
    retval[3][2]->children[1] = task[2];
    retval[4][0] = task[6];
}

void non_max_suppression(image_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    harris_non_max_args *args =
        (harris_non_max_args*) get_memory(sizeof(harris_non_max_args));

    img->final_img = (uint8_t*) get_memory(NUM_PIXELS);

    args->input = img->harris_response;
    args->output = img->final_img;

    task->acc_id = ACC_HARRIS_NON_MAX;
    task->acc_args = (void*) args;
    task->num_children = 0;
    task->num_parents = 1;
    task->producer[0] = retval[4][0];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[4][0]->children[0] = task;
    nodes[17] = task;
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
    run_queue_size[1][0] = 25;
    run_queue[1][0][0] = nodes[0][2];
    run_queue[1][0][1] = nodes[1][2];
    run_queue[1][0][2] = nodes[2][2];
    run_queue[1][0][3] = nodes[3][2];
    run_queue[1][0][4] = nodes[4][2];
    run_queue[1][0][5] = nodes[5][2];
    run_queue[1][0][6] = nodes[6][2];
    run_queue[1][0][7] = nodes[7][2];
    run_queue[1][0][8] = nodes[8][2];
    run_queue[1][0][9] = nodes[9][2];
    run_queue[1][0][10] = nodes[0][7];
    run_queue[1][0][11] = nodes[1][7];
    run_queue[1][0][12] = nodes[2][7];
    run_queue[1][0][13] = nodes[3][7];
    run_queue[1][0][14] = nodes[4][7];
    run_queue[1][0][15] = nodes[5][7];
    run_queue[1][0][16] = nodes[6][7];
    run_queue[1][0][17] = nodes[7][7];
    run_queue[1][0][18] = nodes[8][7];
    run_queue[1][0][19] = nodes[9][7];
    run_queue[1][0][20] = nodes[0][8];
    run_queue[1][0][21] = nodes[2][8];
    run_queue[1][0][22] = nodes[4][8];
    run_queue[1][0][23] = nodes[6][8];
    run_queue[1][0][24] = nodes[8][8];
    run_queue_size[1][1] = 25;
    run_queue[1][1][0] = nodes[0][3];
    run_queue[1][1][1] = nodes[1][3];
    run_queue[1][1][2] = nodes[2][3];
    run_queue[1][1][3] = nodes[3][3];
    run_queue[1][1][4] = nodes[4][3];
    run_queue[1][1][5] = nodes[5][3];
    run_queue[1][1][6] = nodes[6][3];
    run_queue[1][1][7] = nodes[7][3];
    run_queue[1][1][8] = nodes[8][3];
    run_queue[1][1][9] = nodes[9][3];
    run_queue[1][1][10] = nodes[0][9];
    run_queue[1][1][11] = nodes[1][9];
    run_queue[1][1][12] = nodes[2][9];
    run_queue[1][1][13] = nodes[3][9];
    run_queue[1][1][14] = nodes[4][9];
    run_queue[1][1][15] = nodes[5][9];
    run_queue[1][1][16] = nodes[6][9];
    run_queue[1][1][17] = nodes[7][9];
    run_queue[1][1][18] = nodes[8][9];
    run_queue[1][1][19] = nodes[9][9];
    run_queue[1][1][20] = nodes[1][8];
    run_queue[1][1][21] = nodes[3][8];
    run_queue[1][1][22] = nodes[5][8];
    run_queue[1][1][23] = nodes[7][8];
    run_queue[1][1][24] = nodes[9][8];
    run_queue_size[2][0] = 0;
    run_queue_size[3][0] = 55;
    run_queue[3][0][0] = nodes[0][4];
    run_queue[3][0][1] = nodes[1][4];
    run_queue[3][0][2] = nodes[2][4];
    run_queue[3][0][3] = nodes[3][4];
    run_queue[3][0][4] = nodes[4][4];
    run_queue[3][0][5] = nodes[5][4];
    run_queue[3][0][6] = nodes[6][4];
    run_queue[3][0][7] = nodes[7][4];
    run_queue[3][0][8] = nodes[8][4];
    run_queue[3][0][9] = nodes[9][4];
    run_queue[3][0][10] = nodes[0][12];
    run_queue[3][0][11] = nodes[0][14];
    run_queue[3][0][12] = nodes[0][15];
    run_queue[3][0][13] = nodes[1][12];
    run_queue[3][0][14] = nodes[1][14];
    run_queue[3][0][15] = nodes[1][15];
    run_queue[3][0][16] = nodes[2][12];
    run_queue[3][0][17] = nodes[2][14];
    run_queue[3][0][18] = nodes[2][15];
    run_queue[3][0][19] = nodes[3][12];
    run_queue[3][0][20] = nodes[3][14];
    run_queue[3][0][21] = nodes[3][15];
    run_queue[3][0][22] = nodes[4][12];
    run_queue[3][0][23] = nodes[4][14];
    run_queue[3][0][24] = nodes[4][15];
    run_queue[3][0][25] = nodes[5][12];
    run_queue[3][0][26] = nodes[5][14];
    run_queue[3][0][27] = nodes[5][15];
    run_queue[3][0][28] = nodes[6][12];
    run_queue[3][0][29] = nodes[6][14];
    run_queue[3][0][30] = nodes[6][15];
    run_queue[3][0][31] = nodes[7][12];
    run_queue[3][0][32] = nodes[7][14];
    run_queue[3][0][33] = nodes[7][15];
    run_queue[3][0][34] = nodes[8][12];
    run_queue[3][0][35] = nodes[8][14];
    run_queue[3][0][36] = nodes[8][15];
    run_queue[3][0][37] = nodes[9][12];
    run_queue[3][0][38] = nodes[9][14];
    run_queue[3][0][39] = nodes[9][15];
    run_queue[3][0][40] = nodes[0][11];
    run_queue[3][0][41] = nodes[0][13];
    run_queue[3][0][42] = nodes[0][16];
    run_queue[3][0][43] = nodes[2][11];
    run_queue[3][0][44] = nodes[2][13];
    run_queue[3][0][45] = nodes[2][16];
    run_queue[3][0][46] = nodes[4][11];
    run_queue[3][0][47] = nodes[4][13];
    run_queue[3][0][48] = nodes[4][16];
    run_queue[3][0][49] = nodes[6][11];
    run_queue[3][0][50] = nodes[6][13];
    run_queue[3][0][51] = nodes[6][16];
    run_queue[3][0][52] = nodes[8][11];
    run_queue[3][0][53] = nodes[8][13];
    run_queue[3][0][54] = nodes[8][16];
    run_queue_size[3][1] = 35;
    run_queue[3][1][0] = nodes[0][6];
    run_queue[3][1][1] = nodes[1][6];
    run_queue[3][1][2] = nodes[2][6];
    run_queue[3][1][3] = nodes[3][6];
    run_queue[3][1][4] = nodes[4][6];
    run_queue[3][1][5] = nodes[5][6];
    run_queue[3][1][6] = nodes[6][6];
    run_queue[3][1][7] = nodes[7][6];
    run_queue[3][1][8] = nodes[8][6];
    run_queue[3][1][9] = nodes[9][6];
    run_queue[3][1][10] = nodes[0][10];
    run_queue[3][1][11] = nodes[1][10];
    run_queue[3][1][12] = nodes[2][10];
    run_queue[3][1][13] = nodes[3][10];
    run_queue[3][1][14] = nodes[4][10];
    run_queue[3][1][15] = nodes[5][10];
    run_queue[3][1][16] = nodes[6][10];
    run_queue[3][1][17] = nodes[7][10];
    run_queue[3][1][18] = nodes[8][10];
    run_queue[3][1][19] = nodes[9][10];
    run_queue[3][1][20] = nodes[1][11];
    run_queue[3][1][21] = nodes[1][13];
    run_queue[3][1][22] = nodes[1][16];
    run_queue[3][1][23] = nodes[3][11];
    run_queue[3][1][24] = nodes[3][13];
    run_queue[3][1][25] = nodes[3][16];
    run_queue[3][1][26] = nodes[5][11];
    run_queue[3][1][27] = nodes[5][13];
    run_queue[3][1][28] = nodes[5][16];
    run_queue[3][1][29] = nodes[7][11];
    run_queue[3][1][30] = nodes[7][13];
    run_queue[3][1][31] = nodes[7][16];
    run_queue[3][1][32] = nodes[9][11];
    run_queue[3][1][33] = nodes[9][13];
    run_queue[3][1][34] = nodes[9][16];
    run_queue_size[3][2] = 10;
    run_queue[3][2][0] = nodes[0][5];
    run_queue[3][2][1] = nodes[1][5];
    run_queue[3][2][2] = nodes[2][5];
    run_queue[3][2][3] = nodes[3][5];
    run_queue[3][2][4] = nodes[4][5];
    run_queue[3][2][5] = nodes[5][5];
    run_queue[3][2][6] = nodes[6][5];
    run_queue[3][2][7] = nodes[7][5];
    run_queue[3][2][8] = nodes[8][5];
    run_queue[3][2][9] = nodes[9][5];
    run_queue_size[3][3] = 0;
    run_queue_size[4][0] = 10;
    run_queue[4][0][0] = nodes[0][1];
    run_queue[4][0][1] = nodes[1][1];
    run_queue[4][0][2] = nodes[2][1];
    run_queue[4][0][3] = nodes[3][1];
    run_queue[4][0][4] = nodes[4][1];
    run_queue[4][0][5] = nodes[5][1];
    run_queue[4][0][6] = nodes[6][1];
    run_queue[4][0][7] = nodes[7][1];
    run_queue[4][0][8] = nodes[8][1];
    run_queue[4][0][9] = nodes[9][1];
    run_queue_size[5][0] = 10;
    run_queue[5][0][0] = nodes[0][17];
    run_queue[5][0][1] = nodes[1][17];
    run_queue[5][0][2] = nodes[2][17];
    run_queue[5][0][3] = nodes[3][17];
    run_queue[5][0][4] = nodes[4][17];
    run_queue[5][0][5] = nodes[5][17];
    run_queue[5][0][6] = nodes[6][17];
    run_queue[5][0][7] = nodes[7][17];
    run_queue[5][0][8] = nodes[8][17];
    run_queue[5][0][9] = nodes[9][17];
    run_queue_size[6][0] = 10;
    run_queue[6][0][0] = nodes[0][0];
    run_queue[6][0][1] = nodes[1][0];
    run_queue[6][0][2] = nodes[2][0];
    run_queue[6][0][3] = nodes[3][0];
    run_queue[6][0][4] = nodes[4][0];
    run_queue[6][0][5] = nodes[5][0];
    run_queue[6][0][6] = nodes[6][0];
    run_queue[6][0][7] = nodes[7][0];
    run_queue[6][0][8] = nodes[8][0];
    run_queue[6][0][9] = nodes[9][0];
#ifdef ENABLE_FORWARDING
    nodes[0][2]->producer_forward[0] = 1;
    nodes[1][2]->producer_forward[0] = 0;
    nodes[2][2]->producer_forward[0] = 0;
    nodes[3][2]->producer_forward[0] = 0;
    nodes[4][2]->producer_forward[0] = 0;
    nodes[5][2]->producer_forward[0] = 0;
    nodes[6][2]->producer_forward[0] = 0;
    nodes[7][2]->producer_forward[0] = 0;
    nodes[8][2]->producer_forward[0] = 0;
    nodes[9][2]->producer_forward[0] = 0;
    nodes[0][7]->producer_forward[0] = 0;
    nodes[1][7]->producer_forward[0] = 0;
    nodes[2][7]->producer_forward[0] = 0;
    nodes[3][7]->producer_forward[0] = 0;
    nodes[4][7]->producer_forward[0] = 0;
    nodes[5][7]->producer_forward[0] = 0;
    nodes[6][7]->producer_forward[0] = 0;
    nodes[7][7]->producer_forward[0] = 0;
    nodes[8][7]->producer_forward[0] = 0;
    nodes[9][7]->producer_forward[0] = 0;
    nodes[0][8]->producer_forward[0] = 0;
    nodes[2][8]->producer_forward[0] = 0;
    nodes[4][8]->producer_forward[0] = 0;
    nodes[6][8]->producer_forward[0] = 0;
    nodes[8][8]->producer_forward[0] = 0;
    nodes[0][3]->producer_forward[0] = 1;
    nodes[1][3]->producer_forward[0] = 0;
    nodes[2][3]->producer_forward[0] = 0;
    nodes[3][3]->producer_forward[0] = 0;
    nodes[4][3]->producer_forward[0] = 0;
    nodes[5][3]->producer_forward[0] = 0;
    nodes[6][3]->producer_forward[0] = 0;
    nodes[7][3]->producer_forward[0] = 0;
    nodes[8][3]->producer_forward[0] = 0;
    nodes[9][3]->producer_forward[0] = 0;
    nodes[0][9]->producer_forward[0] = 0;
    nodes[1][9]->producer_forward[0] = 0;
    nodes[2][9]->producer_forward[0] = 0;
    nodes[3][9]->producer_forward[0] = 0;
    nodes[4][9]->producer_forward[0] = 0;
    nodes[5][9]->producer_forward[0] = 0;
    nodes[6][9]->producer_forward[0] = 0;
    nodes[7][9]->producer_forward[0] = 0;
    nodes[8][9]->producer_forward[0] = 0;
    nodes[9][9]->producer_forward[0] = 0;
    nodes[1][8]->producer_forward[0] = 0;
    nodes[3][8]->producer_forward[0] = 0;
    nodes[5][8]->producer_forward[0] = 0;
    nodes[7][8]->producer_forward[0] = 0;
    nodes[9][8]->producer_forward[0] = 0;
    nodes[0][4]->producer_forward[0] = 1;
    nodes[0][4]->producer_forward[1] = 0;
    nodes[1][4]->producer_forward[0] = 1;
    nodes[1][4]->producer_forward[1] = 0;
    nodes[2][4]->producer_forward[0] = 1;
    nodes[2][4]->producer_forward[1] = 0;
    nodes[3][4]->producer_forward[0] = 1;
    nodes[3][4]->producer_forward[1] = 0;
    nodes[4][4]->producer_forward[0] = 1;
    nodes[4][4]->producer_forward[1] = 0;
    nodes[5][4]->producer_forward[0] = 1;
    nodes[5][4]->producer_forward[1] = 0;
    nodes[6][4]->producer_forward[0] = 1;
    nodes[6][4]->producer_forward[1] = 0;
    nodes[7][4]->producer_forward[0] = 1;
    nodes[7][4]->producer_forward[1] = 0;
    nodes[8][4]->producer_forward[0] = 1;
    nodes[8][4]->producer_forward[1] = 0;
    nodes[9][4]->producer_forward[0] = 1;
    nodes[9][4]->producer_forward[1] = 0;
    nodes[0][12]->producer_forward[0] = 1;
    nodes[0][12]->producer_forward[1] = 1;
    nodes[0][14]->producer_forward[0] = 1;
    nodes[0][14]->producer_forward[1] = 0;
    nodes[0][15]->producer_forward[0] = 1;
    nodes[0][15]->producer_forward[1] = 0;
    nodes[1][12]->producer_forward[0] = 1;
    nodes[1][12]->producer_forward[1] = 1;
    nodes[1][14]->producer_forward[0] = 1;
    nodes[1][14]->producer_forward[1] = 0;
    nodes[1][15]->producer_forward[0] = 1;
    nodes[1][15]->producer_forward[1] = 0;
    nodes[2][12]->producer_forward[0] = 1;
    nodes[2][12]->producer_forward[1] = 1;
    nodes[2][14]->producer_forward[0] = 1;
    nodes[2][14]->producer_forward[1] = 0;
    nodes[2][15]->producer_forward[0] = 1;
    nodes[2][15]->producer_forward[1] = 0;
    nodes[3][12]->producer_forward[0] = 1;
    nodes[3][12]->producer_forward[1] = 1;
    nodes[3][14]->producer_forward[0] = 1;
    nodes[3][14]->producer_forward[1] = 0;
    nodes[3][15]->producer_forward[0] = 1;
    nodes[3][15]->producer_forward[1] = 0;
    nodes[4][12]->producer_forward[0] = 1;
    nodes[4][12]->producer_forward[1] = 1;
    nodes[4][14]->producer_forward[0] = 1;
    nodes[4][14]->producer_forward[1] = 0;
    nodes[4][15]->producer_forward[0] = 1;
    nodes[4][15]->producer_forward[1] = 0;
    nodes[5][12]->producer_forward[0] = 1;
    nodes[5][12]->producer_forward[1] = 1;
    nodes[5][14]->producer_forward[0] = 1;
    nodes[5][14]->producer_forward[1] = 0;
    nodes[5][15]->producer_forward[0] = 1;
    nodes[5][15]->producer_forward[1] = 0;
    nodes[6][12]->producer_forward[0] = 1;
    nodes[6][12]->producer_forward[1] = 1;
    nodes[6][14]->producer_forward[0] = 1;
    nodes[6][14]->producer_forward[1] = 0;
    nodes[6][15]->producer_forward[0] = 1;
    nodes[6][15]->producer_forward[1] = 0;
    nodes[7][12]->producer_forward[0] = 1;
    nodes[7][12]->producer_forward[1] = 1;
    nodes[7][14]->producer_forward[0] = 1;
    nodes[7][14]->producer_forward[1] = 0;
    nodes[7][15]->producer_forward[0] = 1;
    nodes[7][15]->producer_forward[1] = 0;
    nodes[8][12]->producer_forward[0] = 1;
    nodes[8][12]->producer_forward[1] = 1;
    nodes[8][14]->producer_forward[0] = 1;
    nodes[8][14]->producer_forward[1] = 0;
    nodes[8][15]->producer_forward[0] = 1;
    nodes[8][15]->producer_forward[1] = 0;
    nodes[9][12]->producer_forward[0] = 1;
    nodes[9][12]->producer_forward[1] = 1;
    nodes[9][14]->producer_forward[0] = 1;
    nodes[9][14]->producer_forward[1] = 0;
    nodes[9][15]->producer_forward[0] = 1;
    nodes[9][15]->producer_forward[1] = 0;
    nodes[0][11]->producer_forward[0] = 1;
    nodes[0][11]->producer_forward[1] = 0;
    nodes[0][13]->producer_forward[0] = 0;
    nodes[0][13]->producer_forward[1] = 1;
    nodes[0][16]->producer_forward[0] = 1;
    nodes[0][16]->producer_forward[1] = 0;
    nodes[2][11]->producer_forward[0] = 1;
    nodes[2][11]->producer_forward[1] = 0;
    nodes[2][13]->producer_forward[0] = 0;
    nodes[2][13]->producer_forward[1] = 1;
    nodes[2][16]->producer_forward[0] = 1;
    nodes[2][16]->producer_forward[1] = 0;
    nodes[4][11]->producer_forward[0] = 1;
    nodes[4][11]->producer_forward[1] = 0;
    nodes[4][13]->producer_forward[0] = 0;
    nodes[4][13]->producer_forward[1] = 1;
    nodes[4][16]->producer_forward[0] = 1;
    nodes[4][16]->producer_forward[1] = 0;
    nodes[6][11]->producer_forward[0] = 1;
    nodes[6][11]->producer_forward[1] = 0;
    nodes[6][13]->producer_forward[0] = 0;
    nodes[6][13]->producer_forward[1] = 1;
    nodes[6][16]->producer_forward[0] = 1;
    nodes[6][16]->producer_forward[1] = 0;
    nodes[8][11]->producer_forward[0] = 1;
    nodes[8][11]->producer_forward[1] = 0;
    nodes[8][13]->producer_forward[0] = 0;
    nodes[8][13]->producer_forward[1] = 1;
    nodes[8][16]->producer_forward[0] = 1;
    nodes[8][16]->producer_forward[1] = 0;
    nodes[0][6]->producer_forward[0] = 1;
    nodes[0][6]->producer_forward[1] = 0;
    nodes[1][6]->producer_forward[0] = 1;
    nodes[1][6]->producer_forward[1] = 0;
    nodes[2][6]->producer_forward[0] = 1;
    nodes[2][6]->producer_forward[1] = 0;
    nodes[3][6]->producer_forward[0] = 1;
    nodes[3][6]->producer_forward[1] = 0;
    nodes[4][6]->producer_forward[0] = 1;
    nodes[4][6]->producer_forward[1] = 0;
    nodes[5][6]->producer_forward[0] = 1;
    nodes[5][6]->producer_forward[1] = 0;
    nodes[6][6]->producer_forward[0] = 1;
    nodes[6][6]->producer_forward[1] = 0;
    nodes[7][6]->producer_forward[0] = 1;
    nodes[7][6]->producer_forward[1] = 0;
    nodes[8][6]->producer_forward[0] = 1;
    nodes[8][6]->producer_forward[1] = 0;
    nodes[9][6]->producer_forward[0] = 1;
    nodes[9][6]->producer_forward[1] = 0;
    nodes[0][10]->producer_forward[0] = 1;
    nodes[0][10]->producer_forward[1] = 1;
    nodes[1][10]->producer_forward[0] = 1;
    nodes[1][10]->producer_forward[1] = 1;
    nodes[2][10]->producer_forward[0] = 1;
    nodes[2][10]->producer_forward[1] = 1;
    nodes[3][10]->producer_forward[0] = 1;
    nodes[3][10]->producer_forward[1] = 1;
    nodes[4][10]->producer_forward[0] = 1;
    nodes[4][10]->producer_forward[1] = 1;
    nodes[5][10]->producer_forward[0] = 1;
    nodes[5][10]->producer_forward[1] = 1;
    nodes[6][10]->producer_forward[0] = 1;
    nodes[6][10]->producer_forward[1] = 1;
    nodes[7][10]->producer_forward[0] = 1;
    nodes[7][10]->producer_forward[1] = 1;
    nodes[8][10]->producer_forward[0] = 1;
    nodes[8][10]->producer_forward[1] = 1;
    nodes[9][10]->producer_forward[0] = 1;
    nodes[9][10]->producer_forward[1] = 1;
    nodes[1][11]->producer_forward[0] = 1;
    nodes[1][11]->producer_forward[1] = 0;
    nodes[1][13]->producer_forward[0] = 0;
    nodes[1][13]->producer_forward[1] = 1;
    nodes[1][16]->producer_forward[0] = 1;
    nodes[1][16]->producer_forward[1] = 0;
    nodes[3][11]->producer_forward[0] = 1;
    nodes[3][11]->producer_forward[1] = 0;
    nodes[3][13]->producer_forward[0] = 0;
    nodes[3][13]->producer_forward[1] = 1;
    nodes[3][16]->producer_forward[0] = 1;
    nodes[3][16]->producer_forward[1] = 0;
    nodes[5][11]->producer_forward[0] = 1;
    nodes[5][11]->producer_forward[1] = 0;
    nodes[5][13]->producer_forward[0] = 0;
    nodes[5][13]->producer_forward[1] = 1;
    nodes[5][16]->producer_forward[0] = 1;
    nodes[5][16]->producer_forward[1] = 0;
    nodes[7][11]->producer_forward[0] = 1;
    nodes[7][11]->producer_forward[1] = 0;
    nodes[7][13]->producer_forward[0] = 0;
    nodes[7][13]->producer_forward[1] = 1;
    nodes[7][16]->producer_forward[0] = 1;
    nodes[7][16]->producer_forward[1] = 0;
    nodes[9][11]->producer_forward[0] = 1;
    nodes[9][11]->producer_forward[1] = 0;
    nodes[9][13]->producer_forward[0] = 0;
    nodes[9][13]->producer_forward[1] = 1;
    nodes[9][16]->producer_forward[0] = 1;
    nodes[9][16]->producer_forward[1] = 0;
    nodes[0][5]->producer_forward[0] = 1;
    nodes[0][5]->producer_forward[1] = 1;
    nodes[1][5]->producer_forward[0] = 1;
    nodes[1][5]->producer_forward[1] = 1;
    nodes[2][5]->producer_forward[0] = 1;
    nodes[2][5]->producer_forward[1] = 1;
    nodes[3][5]->producer_forward[0] = 1;
    nodes[3][5]->producer_forward[1] = 1;
    nodes[4][5]->producer_forward[0] = 1;
    nodes[4][5]->producer_forward[1] = 1;
    nodes[5][5]->producer_forward[0] = 1;
    nodes[5][5]->producer_forward[1] = 1;
    nodes[6][5]->producer_forward[0] = 1;
    nodes[6][5]->producer_forward[1] = 1;
    nodes[7][5]->producer_forward[0] = 1;
    nodes[7][5]->producer_forward[1] = 1;
    nodes[8][5]->producer_forward[0] = 1;
    nodes[8][5]->producer_forward[1] = 1;
    nodes[9][5]->producer_forward[0] = 1;
    nodes[9][5]->producer_forward[1] = 1;
    nodes[0][1]->producer_forward[0] = 1;
    nodes[1][1]->producer_forward[0] = 1;
    nodes[2][1]->producer_forward[0] = 1;
    nodes[3][1]->producer_forward[0] = 1;
    nodes[4][1]->producer_forward[0] = 1;
    nodes[5][1]->producer_forward[0] = 1;
    nodes[6][1]->producer_forward[0] = 1;
    nodes[7][1]->producer_forward[0] = 1;
    nodes[8][1]->producer_forward[0] = 1;
    nodes[9][1]->producer_forward[0] = 1;
    nodes[0][17]->producer_forward[0] = 1;
    nodes[1][17]->producer_forward[0] = 0;
    nodes[2][17]->producer_forward[0] = 1;
    nodes[3][17]->producer_forward[0] = 0;
    nodes[4][17]->producer_forward[0] = 1;
    nodes[5][17]->producer_forward[0] = 0;
    nodes[6][17]->producer_forward[0] = 1;
    nodes[7][17]->producer_forward[0] = 0;
    nodes[8][17]->producer_forward[0] = 1;
    nodes[9][17]->producer_forward[0] = 0;
    nodes[0][0]->producer_forward[0] = 0;
    nodes[1][0]->producer_forward[0] = 0;
    nodes[2][0]->producer_forward[0] = 0;
    nodes[3][0]->producer_forward[0] = 0;
    nodes[4][0]->producer_forward[0] = 0;
    nodes[5][0]->producer_forward[0] = 0;
    nodes[6][0]->producer_forward[0] = 0;
    nodes[7][0]->producer_forward[0] = 0;
    nodes[8][0]->producer_forward[0] = 0;
    nodes[9][0]->producer_forward[0] = 0;
#endif

    schedule(run_queue, run_queue_size);
}

void aprx(task_struct_t ***nodes)
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

        // Step 2: Spatial derivative calculation
        spatial_derivative_calc(&imgs[i], nodes[i]);

        // Step 3: Structure tensor setup
        structure_tensor_setup(&imgs[i], nodes[i]);

        // Step 4: Harris response calculation
        harris_response_calc(&imgs[i], nodes[i]);

        // Step 5: Non-max suppression
        non_max_suppression(&imgs[i], nodes[i]);
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
