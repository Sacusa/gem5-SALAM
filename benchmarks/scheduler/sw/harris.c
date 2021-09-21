#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/m5ops.h"
#include "scheduler.h"

#define NUM_IMAGES 1

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
    uint8_t *max_values;
} image_data_t;

task_struct_t *retval[5][3];

void process_raw(image_data_t *img, task_struct_t **nodes)
{
    printf("Adding ISP\n");

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
    printf("Adding grayscale\n");

    task_struct_t *task = (task_struct_t*) get_memory(sizeof(task_struct_t));
    grayscale_args *args = (grayscale_args*)
        get_memory(sizeof(grayscale_args));

    img->grayscale_img = (float*) get_memory(NUM_PIXELS * 4);

    args->input = img->isp_img;
    args->output = img->grayscale_img;

    task->acc_id = ACC_GRAYSCALE;
    task->acc_args = (void*) args;
    task->num_children = 2;
    task->num_parents = 1;
    task->producer[0] = retval[0][0];
    task->producer_forward[0] = 0;
#ifdef VERIFY
    task->status = REQ_STATUS_READY;
#else
    task->status = REQ_STATUS_WAITING;
#endif
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
        task[i]->producer_forward[0] = 0;
        task[i]->producer_forward[1] = 0;
        task[i]->completed_parents = 0;

        task[i+3]->acc_id = ACC_CONVOLUTION;
        task[i+3]->acc_args = (void*) c_args[i];
        task[i+3]->status = REQ_STATUS_WAITING;
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

    img->max_values = (uint8_t*) get_memory(NUM_PIXELS);

    args->input = img->harris_response;
    args->output = img->max_values;

    task->acc_id = ACC_HARRIS_NON_MAX;
    task->acc_args = (void*) args;
    task->num_children = 0;
    task->num_parents = 1;
    task->producer[0] = retval[4][0];
    task->status = REQ_STATUS_WAITING;
    task->completed_parents = 0;

    retval[4][0]->children[0] = task;
    nodes[17] = task;
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

    run_queue_size[0][0] = 0;
    run_queue_size[1][0] = 5;
    run_queue[1][0][0] = nodes[0][2];
    run_queue[1][0][1] = nodes[0][3];
    run_queue[1][0][2] = nodes[0][7];
    run_queue[1][0][3] = nodes[0][8];
    run_queue[1][0][4] = nodes[0][9];
    run_queue_size[2][0] = 0;
    run_queue_size[3][0] = 6;
    run_queue[3][0][0] = nodes[0][4];
    run_queue[3][0][1] = nodes[0][5];
    run_queue[3][0][2] = nodes[0][11];
    run_queue[3][0][3] = nodes[0][10];
    run_queue[3][0][4] = nodes[0][15];
    run_queue[3][0][5] = nodes[0][16];
    run_queue_size[3][1] = 4;
    run_queue[3][1][0] = nodes[0][6];
    run_queue[3][1][1] = nodes[0][12];
    run_queue[3][1][2] = nodes[0][13];
    run_queue[3][1][3] = nodes[0][14];
    run_queue_size[4][0] = 1;
    run_queue[4][0][0] = nodes[0][1];
    run_queue_size[5][0] = 1;
    run_queue[5][0][0] = nodes[0][17];
#ifdef VERIFY
    run_queue_size[6][0] = 0;
#else
    run_queue_size[6][0] = 1;
#endif
    run_queue[6][0][0] = nodes[0][0];

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
    if (argc != 3) {
        printf("Usage: %s <input image> <expected output image>\n", argv[0]);
        return -1;
    }

    uint8_t input_img[NUM_PIXELS*3];
    float expected_output[NUM_PIXELS];

    FILE *fp;
    char *line = NULL;
    size_t len = 0;
    ssize_t read;

    // read input image
    int index = 0;
    fp = fopen(argv[1], "r");
    while ((read = getline(&line, &len, fp)) != -1) {
        input_img[index] = atoi(line);
        index++;
    }
    fclose(fp);

    // read reference output
    index = 0;
    fp = fopen(argv[2], "r");
    while ((read = getline(&line, &len, fp)) != -1) {
        expected_output[index] = atof(line);
        index++;
    }
    fclose(fp);
#endif

    // For recording and printing dags
    //task_struct_t *dags[NUM_IMAGES];

    for (int i = 0; i < NUM_IMAGES; i++) {
#ifdef VERIFY
        // Step 0: Load input image as ISP output
        int err = posix_memalign((void**)&imgs[i].isp_img, CACHELINE_SIZE, NUM_PIXELS * 3);
        assert(err == 0 && "Failed to allocate memory");

        for (int j = 0; j < (NUM_PIXELS * 3); j++) {
            imgs[i].isp_img[j] = input_img[j];
        }
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

        // For recording and printing dags
        //dags[i] = retval[0][0];
        //print_dag(dags[i]);
    }

    gedf(nodes);

#ifdef VERIFY
    int num_failures = 0;
    float max_diff = 0;

    for (int i = 0; i < NUM_IMAGES; i++) {
        for (int j = 0; j < NUM_PIXELS; j++) {
            float diff = fabs(imgs[i].max_values[j] - expected_output[j]);

            if (diff > 0.5) {
                num_failures++;
                printf("ERROR in image %d, pixel %d: expected %f, got %d\n", i, j,
                        expected_output[j], imgs[i].max_values[j]);
            }

            if (diff > max_diff) { max_diff = diff; }
        }
    }

    printf("Number of failures = %d\n", num_failures);
    printf("Max difference = %f\n", max_diff);
#endif

    m5_dump_stats();
    m5_exit();
}
