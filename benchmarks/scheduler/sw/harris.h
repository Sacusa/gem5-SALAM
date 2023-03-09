#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "runtime.h"

#define HARRIS_DEADLINE 16667

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
} harris_data_t;

task_struct_t *harris_retval[5][3];
#ifdef VERIFY
uint8_t *harris_isp_output;
#endif

void harris_process_raw(harris_data_t *img, task_struct_t **nodes)
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

    task->input_size = 16900;
    task->output_size = 49152;
    task->compute_time = RUNTIME_ISP;
    task->dag_deadline = HARRIS_DEADLINE;
    task->node_deadline = 14026;

    harris_retval[0][0] = task;
    nodes[0] = task;
}

void harris_convert_to_grayscale(harris_data_t *img, task_struct_t **nodes)
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
    task->num_children = 2;
#ifdef VERIFY
    task->num_parents = 0;
    task->producer[0] = NULL;
    task->status = REQ_STATUS_READY;
#else
    task->num_parents = 1;
    task->producer[0] = harris_retval[0][0];
    task->status = REQ_STATUS_WAITING;
#endif
    task->producer_forward[0] = 0;
    task->completed_parents = 0;

    task->input_size = 49152;
    task->output_size = 65536;
    task->compute_time = RUNTIME_GRAYSCALE;
    task->dag_deadline = HARRIS_DEADLINE;
    task->node_deadline = 14063;

#ifndef VERIFY
    harris_retval[0][0]->children[0] = task;
#endif
    harris_retval[1][0] = task;
    nodes[1] = task;
}

void harris_spatial_derivative_calc(harris_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task[2];
    convolution_args *args[2];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 2; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (convolution_args*) get_memory(sizeof(convolution_args));
    }

    img->K_x = (float*) get_memory_aligned(36, CACHELINE_SIZE);
    img->K_y = (float*) get_memory_aligned(36, CACHELINE_SIZE);
    img->I_x = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_y = (float*) get_memory_aligned(size, CACHELINE_SIZE);

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
        task[i]->producer[0] = harris_retval[1][0];
        task[i]->producer_forward[0] = 0;
        task[i]->status = REQ_STATUS_WAITING;
        task[i]->completed_parents = 0;

        task[i]->input_size = 65572;
        task[i]->output_size = 65536;
        task[i]->compute_time = RUNTIME_CONVOLUTION_3;
        task[i]->dag_deadline = HARRIS_DEADLINE;
        task[i]->node_deadline = 14731;

        harris_retval[1][0]->children[i] = task[i];
        harris_retval[2][i] = task[i];
        nodes[i+2] = task[i];
    }
}

void harris_structure_tensor_setup(harris_data_t *img, task_struct_t **nodes)
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
    img->I_xx = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_xy = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_yy = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_xx_g = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_xy_g = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->I_yy_g = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->gauss_kernel = (float*) get_memory_aligned(100, CACHELINE_SIZE);

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
        task[i]->dag_deadline = HARRIS_DEADLINE;

        task[i+3]->acc_id = ACC_CONVOLUTION;
        task[i+3]->acc_args = (void*) c_args[i];
        task[i+3]->status = REQ_STATUS_WAITING;
        task[i+3]->producer[0] = NULL;
        task[i+3]->producer_forward[0] = 0;
        task[i+3]->completed_parents = 0;
        task[i+3]->dag_deadline = HARRIS_DEADLINE;

        harris_retval[3][i] = task[i+3];
        nodes[i+4] = task[i];
        nodes[i+7] = task[i+3];
    }

    task[0]->num_children = 1;
    task[0]->children[0] = task[3];
    task[0]->num_parents = 1;
    task[0]->producer[0] = harris_retval[2][0];
    task[0]->input_size = 65536;
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_SQR;
    task[0]->node_deadline = 14771;

    task[1]->num_children = 1;
    task[1]->children[0] = task[4];
    task[1]->num_parents = 2;
    task[1]->producer[0] = harris_retval[2][0];
    task[1]->producer[1] = harris_retval[2][1];
    task[1]->input_size = 131072;
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[1]->node_deadline = 14812;

    task[2]->num_children = 1;
    task[2]->children[0] = task[5];
    task[2]->num_parents = 1;
    task[2]->producer[0] = harris_retval[2][1];
    task[2]->input_size = 65536;
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_SQR;
    task[2]->node_deadline = 14771;

    task[3]->num_children = 2;
    task[3]->num_parents = 1;
    task[3]->producer[0] = task[0];
    task[3]->input_size = 65636;
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_CONVOLUTION_5;
    task[3]->node_deadline = 16347;

    task[4]->num_children = 1;
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[1];
    task[4]->input_size = 65636;
    task[4]->output_size = 65536;
    task[4]->compute_time = RUNTIME_CONVOLUTION_5;
    task[4]->node_deadline = 16389;

    task[5]->num_children = 2;
    task[5]->num_parents = 1;
    task[5]->producer[0] = task[2];
    task[5]->input_size = 65636;
    task[5]->output_size = 65536;
    task[5]->compute_time = RUNTIME_CONVOLUTION_5;
    task[5]->node_deadline = 16347;

    harris_retval[2][0]->children[0] = task[0];
    harris_retval[2][0]->children[1] = task[1];
    harris_retval[2][1]->children[0] = task[1];
    harris_retval[2][1]->children[1] = task[2];
}

void harris_response_calc(harris_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task[7];
    elem_matrix_args *args[7];
    int size = NUM_PIXELS * 4;

    for (int i = 0; i < 7; i++) {
        task[i] = (task_struct_t*) get_memory(sizeof(task_struct_t));
        args[i] = (elem_matrix_args*) get_memory(sizeof(elem_matrix_args));
    }
    img->detA1  = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->detA2  = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->detA   = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->traceA = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->k      = (float*) get_memory_aligned(4, CACHELINE_SIZE);
    img->hr1    = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->hr2    = (float*) get_memory_aligned(size, CACHELINE_SIZE);
    img->harris_response = (float*) get_memory_aligned(size, CACHELINE_SIZE);

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
        task[i]->dag_deadline = HARRIS_DEADLINE;
        nodes[i+10] = task[i];
    }

    task[0]->num_children = 1;
    task[0]->children[0] = task[3];
    task[0]->num_parents = 2;
    task[0]->producer[0] = harris_retval[3][0];
    task[0]->producer[1] = harris_retval[3][2];
    task[0]->input_size = 131072;
    task[0]->output_size = 65536;
    task[0]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[0]->node_deadline = 16428;

    task[1]->num_children = 1;
    task[1]->children[0] = task[3];
    task[1]->num_parents = 1;
    task[1]->producer[0] = harris_retval[3][1];
    task[1]->input_size = 65536;
    task[1]->output_size = 65536;
    task[1]->compute_time = RUNTIME_ELEM_MATRIX_SQR;
    task[1]->node_deadline = 16428;

    task[2]->num_children = 1;
    task[2]->children[0] = task[4];
    task[2]->num_parents = 2;
    task[2]->producer[0] = harris_retval[3][0];
    task[2]->producer[1] = harris_retval[3][2];
    task[2]->input_size = 131072;
    task[2]->output_size = 65536;
    task[2]->compute_time = RUNTIME_ELEM_MATRIX_ADD;
    task[2]->node_deadline = 16404;

    task[3]->num_children = 1;
    task[3]->children[0] = task[6];
    task[3]->num_parents = 2;
    task[3]->producer[0] = task[0];
    task[3]->producer[1] = task[1];
    task[3]->input_size = 131072;
    task[3]->output_size = 65536;
    task[3]->compute_time = RUNTIME_ELEM_MATRIX_SUB;
    task[3]->node_deadline = 16485;

    task[4]->num_children = 1;
    task[4]->children[0] = task[5];
    task[4]->num_parents = 1;
    task[4]->producer[0] = task[2];
    task[4]->input_size = 65536;
    task[4]->output_size = 65536;
    task[4]->compute_time = RUNTIME_ELEM_MATRIX_SQR;
    task[4]->node_deadline = 16443;

    task[5]->num_children = 1;
    task[5]->children[0] = task[6];
    task[5]->num_parents = 1;
    task[5]->producer[0] = task[4];
    task[5]->input_size = 65540;
    task[5]->output_size = 65536;
    task[5]->compute_time = RUNTIME_ELEM_MATRIX_MUL;
    task[5]->node_deadline = 16485;

    task[6]->num_children = 1;
    task[6]->num_parents = 2;
    task[6]->producer[0] = task[3];
    task[6]->producer[1] = task[5];
    task[6]->input_size = 131072;
    task[6]->output_size = 65536;
    task[6]->compute_time = RUNTIME_ELEM_MATRIX_SUB;
    task[6]->node_deadline = 16542;

    harris_retval[3][0]->children[0] = task[0];
    harris_retval[3][0]->children[1] = task[2];
    harris_retval[3][1]->children[0] = task[1];
    harris_retval[3][2]->children[0] = task[0];
    harris_retval[3][2]->children[1] = task[2];
    harris_retval[4][0] = task[6];
}

void harris_non_max_suppression(harris_data_t *img, task_struct_t **nodes)
{
    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    harris_non_max_args *args =
        (harris_non_max_args*) get_memory(sizeof(harris_non_max_args));

    img->final_img = (uint8_t*) get_memory_aligned(NUM_PIXELS, CACHELINE_SIZE);

    args->input = img->harris_response;
    args->output = img->final_img;

    task->acc_id = ACC_HARRIS_NON_MAX;
    task->acc_args = (void*) args;
    task->num_children = 0;
    task->num_parents = 1;
    task->producer[0] = harris_retval[4][0];
    task->producer_forward[0] = 0;
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    task->input_size = 65536;
    task->output_size = 16384;
    task->compute_time = RUNTIME_HARRIS_NON_MAX;
    task->dag_deadline = HARRIS_DEADLINE;
    task->node_deadline = 16667;

    harris_retval[4][0]->children[0] = task;
    nodes[17] = task;
}

void init_harris()
{
#ifdef VERIFY
    harris_isp_output = (uint8_t*) get_memory_aligned(NUM_PIXELS * 3,
            CACHELINE_SIZE);

    for (int i = 0; i < (NUM_PIXELS * 3); i++) {
        harris_isp_output[i] = i % 256;
    }
#endif
}

void add_harris_dag(task_struct_t ***nodes, int *num_nodes, int num_images)
{
    harris_data_t *imgs = (harris_data_t*)
        get_memory(num_images * sizeof(harris_data_t));

    for (int i = 0; i < num_images; i++) {
#ifdef VERIFY
        // Step 0: Link ISP output
        imgs[i].isp_img = harris_isp_output;
#else
        // Step 0: Run raw image through ISP
        harris_process_raw(&imgs[i], nodes[i]);
#endif

        // Step 1: Convert image to grayscale
        harris_convert_to_grayscale(&imgs[i], nodes[i]);

        // Step 2: Spatial derivative calculation
        harris_spatial_derivative_calc(&imgs[i], nodes[i]);

        // Step 3: Structure tensor setup
        harris_structure_tensor_setup(&imgs[i], nodes[i]);

        // Step 4: Harris response calculation
        harris_response_calc(&imgs[i], nodes[i]);

        // Step 5: Non-max suppression
        harris_non_max_suppression(&imgs[i], nodes[i]);

        num_nodes[i] = 18;
    }
}

void print_harris_output(task_struct_t ***nodes, int num_images)
{
    printf("Printing harris results\n");
    printf("=======================\n");

    for (int i = 0; i < num_images; i++) {
        uint8_t *final_img =
            ((harris_non_max_args*)(nodes[i][17]->acc_args))->output;
        for (int j = 0; j < NUM_PIXELS; j++) {
            printf("Image %2d, pixel %2d, value = %d\n", i, j,
                    final_img[j]);
        }
    }
}
