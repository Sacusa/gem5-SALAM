#include <stdio.h>
#include <stdlib.h>

#include "../../common/m5ops.h"
#include "runtime.h"

//#define VERBOSE

void add_canny_non_max();
void canny_non_max_check_output(canny_non_max_args*);

void add_convolution();
void convolution_check_output(convolution_args*);

void add_edge_tracking();
void edge_tracking_check_output(edge_tracking_args*);

void add_elem_matrix();
void elem_matrix_check_output(elem_matrix_args*);

void add_grayscale();
void grayscale_check_output(grayscale_args*);

uint8_t *add_harris_non_max();
void harris_non_max_check_output(harris_non_max_args*, uint8_t*);

void add_isp();
void isp_check_output(isp_args*);

task_struct_t ****run_queue;
int **run_queue_size;

int main(void)
{
    run_queue = (task_struct_t****)
        get_memory(NUM_ACCS * sizeof(task_struct_t***));
    run_queue_size = (int**) get_memory(NUM_ACCS * sizeof(int*));

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

    for (int i = 0; i < NUM_ACCS; i++) {
        for (int j = 0; j < MAX_ACC_INSTANCES; j++) {
            run_queue_size[i][j] = 0;
        }
    }

    add_canny_non_max();
    add_convolution();
    add_edge_tracking();
    add_elem_matrix();
    add_grayscale();
    uint8_t *expected = add_harris_non_max();
    add_isp();

    runtime(run_queue, run_queue_size);

#ifdef VERIFY
    canny_non_max_check_output((canny_non_max_args*)
            run_queue[ACC_CANNY_NON_MAX][0][0]->acc_args);
    convolution_check_output((convolution_args*)
            run_queue[ACC_CONVOLUTION][0][0]->acc_args);
    edge_tracking_check_output((edge_tracking_args*)
            run_queue[ACC_EDGE_TRACKING][0][0]->acc_args);
    elem_matrix_check_output((elem_matrix_args*)
            run_queue[ACC_ELEM_MATRIX][0][0]->acc_args);
    grayscale_check_output((grayscale_args*)
            run_queue[ACC_GRAYSCALE][0][0]->acc_args);
    harris_non_max_check_output((harris_non_max_args*)
            run_queue[ACC_HARRIS_NON_MAX][0][0]->acc_args, expected);
    isp_check_output((isp_args*)
            run_queue[ACC_ISP][0][0]->acc_args);
#endif

    m5_exit();
}

void add_canny_non_max()
{
    canny_non_max_args *args = (canny_non_max_args*)
        get_memory(sizeof(canny_non_max_args));
    task_struct_t * volatile req = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    args->hypotenuse = (float*)    get_memory_aligned(NUM_PIXELS * 4,
            CACHELINE_SIZE);
    args->theta      = (float*)    get_memory_aligned(NUM_PIXELS * 4,
            CACHELINE_SIZE);
    args->output     = (uint32_t*) get_memory_aligned(NUM_PIXELS * 4,
            CACHELINE_SIZE);

    req->acc_id = ACC_CANNY_NON_MAX;
    req->acc_args = (void*) args;
    req->num_children = 0;
    req->num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req->producer[i] = NULL;
        req->producer_forward[i] = 0;
    }

    req->status = REQ_STATUS_READY;

    float angles[] = {0.349, 0.698, 1.396, 2.094, 2.967};
    int angles_size = 5, angles_index = 0, hypo = 0;

    for (int i = 0; i < IMG_HEIGHT; i++) {
        angles_index = i % angles_size;
        hypo = i;

        for (int j = 0; j < IMG_WIDTH; j++) {
            args->hypotenuse[DIM(i,j)] = hypo;
            args->theta[DIM(i,j)] = angles[angles_index];
            args->output[DIM(i,j)] = 0xffffffff;

            hypo = (hypo + 1) % IMG_WIDTH;
            angles_index = (angles_index + 1) % angles_size;
        }
    }

    run_queue[ACC_CANNY_NON_MAX][0][0] = req;
    run_queue_size[ACC_CANNY_NON_MAX][0] = 1;
}

void canny_non_max_check_output(canny_non_max_args *args)
{
    printf("CNM: checking output\n");

    float *hypotenuse = args->hypotenuse;
    float *theta = args->theta;
    uint32_t *output = args->output;

    int max_height = IMG_HEIGHT - 1, max_width = IMG_WIDTH - 1;
    int num_failures = 0;

    for (int i = 0; i < IMG_HEIGHT; i++) {
        for (int j = 0; j < IMG_WIDTH; j++) {
            float q = 255, r = 255;
            int index = DIM(i,j);
            uint32_t expected_value;

            if ((i == 0) || (i == max_height) || (j == 0) ||
                    (j == max_width)) {
                expected_value = 0;
            }
            else {
                float angle = theta[index] * (180 / PI);
                if (angle < 0) { angle += 180; }

                // angle 0
                if (((angle >= 0)     && (angle < 22.5)) ||
                    ((angle >= 157.5) && (angle <= 180))) {
                    q = hypotenuse[DIM(i,j+1)];
                    r = hypotenuse[DIM(i,j-1)];
                }

                // angle 45
                else if ((angle >= 22.5) && (angle < 67.5)) {
                    q = hypotenuse[DIM(i+1,j-1)];
                    r = hypotenuse[DIM(i-1,j+1)];
                }

                // angle 90
                else if ((angle >= 67.5) && (angle < 112.5)) {
                    q = hypotenuse[DIM(i+1,j)];
                    r = hypotenuse[DIM(i-1,j)];
                }

                // angle 135
                else if ((angle >= 112.5) && (angle < 157.5)) {
                    q = hypotenuse[DIM(i-1,j-1)];
                    r = hypotenuse[DIM(i+1,j+1)];
                }

                if ((hypotenuse[index] >= q) && (hypotenuse[index] >= r)) {
                    expected_value = hypotenuse[index];
                }
                else {
                    expected_value = 0;
                }
            }

            if (output[index] != expected_value) {
                num_failures++;
#ifdef VERBOSE
                printf("ERROR: at (%d,%d); hypotenuse=%f, theta=%f, q=%f, "
                        "r=%f, expected=%d, got=%d\n", i, j, hypotenuse[index],
                        theta[index], q, r, expected_value, output[index]);
#endif
            }
        }
    }

    printf("CNM: number of failures: %d\n", num_failures);
}

void add_convolution()
{
    int kern_height = 5, kern_width = 5;

    convolution_args *args = (convolution_args*)
        get_memory(sizeof(convolution_args));
    task_struct_t * volatile req = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    args->input  = (float*) get_memory_aligned(4 * NUM_PIXELS, CACHELINE_SIZE);
    args->output = (float*) get_memory_aligned(4 * NUM_PIXELS, CACHELINE_SIZE);
    args->kernel = (float*) get_memory_aligned(4 * kern_height * kern_width,
            CACHELINE_SIZE);
    args->kern_height = kern_height;
    args->kern_width = kern_width;
    args->mod_and_floor = 0;

    req->acc_id = ACC_CONVOLUTION;
    req->acc_args = (void*) args;
    req->num_children = 0;
    req->num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req->producer[i] = NULL;
        req->producer_forward[i] = 0;
    }

    req->status = REQ_STATUS_READY;

    for (int i = 0; i < NUM_PIXELS; i++) {
        args->input[i] = (i % 256) + 1;
        args->output[i] = -1;
    }

    for (int i = 0; i < kern_height; i++) {
        for (int j = 0; j < kern_width; j++) {
            int index = KERN_DIM(i,j);
            args->kernel[index] = index + 1;
        }
    }

    run_queue[ACC_CONVOLUTION][0][0] = req;
    run_queue_size[ACC_CONVOLUTION][0] = 1;
}

void convolution_check_output(convolution_args *args)
{
    printf("CONVOLUTION: checking output\n");

    float *input_image = args->input;
    float *kernel = args->kernel;
    float *output_image = args->output;
    uint8_t mod_and_floor = args->mod_and_floor;
    int kern_height = args->kern_height;
    int kern_width = args->kern_width;

    int delta_i = (kern_height - 1) / 2;
    int delta_j = (kern_width - 1) / 2;
    int num_failures = 0;

    for (int i = 0; i < IMG_HEIGHT; ++i) {
        for (int j = 0; j < IMG_WIDTH; ++j) {
            float partial_sum = 0;

            for (int ki = 0; ki < kern_height; ++ki) {
                for (int kj = 0; kj < kern_width; ++kj) {
                    int row = i - delta_i + ki;
                    int col = j - delta_j + kj;

                    if ((row >= 0) && (row < IMG_HEIGHT) && (col >= 0) &&
                            (col < IMG_WIDTH)) {
                        partial_sum += input_image[DIM(row, col)] *
                            kernel[KERN_DIM(ki,kj)];
                    }
                }
            }

            if (mod_and_floor) {
                partial_sum = partial_sum < 0 ? -partial_sum : partial_sum;
                partial_sum = (float)(uint8_t) partial_sum;
            }

            if (fabs(partial_sum - output_image[DIM(i, j)]) > 0.0001) {
#ifdef VERBOSE
                printf("ERROR at (%d,%d): expected = %f, got = %f\n", i, j,
                        partial_sum, output_image[DIM(i, j)]);
#endif
                num_failures++;
            }
        }
    }

    printf("CONVOLUTION: number of failures = %d\n", num_failures);
}

void add_edge_tracking()
{
    edge_tracking_args *args = (edge_tracking_args*)
        get_memory(sizeof(edge_tracking_args));
    task_struct_t * volatile req = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    args->input  = (uint32_t*) get_memory_aligned(4 * NUM_PIXELS,
            CACHELINE_SIZE);
    args->output = (uint8_t*)  get_memory_aligned(NUM_PIXELS, CACHELINE_SIZE);
    args->thr_weak_ratio = 0.5;
    args->thr_strong_ratio = 0.503;

    req->acc_id = ACC_EDGE_TRACKING;
    req->acc_args = (void*) args;
    req->num_children = 0;
    req->num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req->producer[i] = NULL;
        req->producer_forward[i] = 0;
    }

    req->status = REQ_STATUS_READY;

    for (int i = 0; i < IMG_HEIGHT; i++) {
        for (int j = 0; j < IMG_WIDTH; j++) {
            int index = DIM(i, j);

            args->input[index] = i;
            args->output[index] = 0xff;
        }
    }

    run_queue[ACC_EDGE_TRACKING][0][0] = req;
    run_queue_size[ACC_EDGE_TRACKING][0] = 1;
}

void edge_tracking_check_output(edge_tracking_args* args)
{
    printf("ET: checking output\n");

    int num_failures = 0;
    uint8_t *output_image = args->output;

    for (int i = 0; i < IMG_HEIGHT; i++) {
        for (int j = 0; j < IMG_WIDTH; j++) {
            int index = DIM(i, j);
            uint8_t expected_image;

            if ((i == 0) || (i == (IMG_HEIGHT-1)) || (j == 0) ||
                    (j == (IMG_WIDTH-1))) {
                expected_image = 0;
            } else if (index < (((IMG_HEIGHT*IMG_WIDTH) / 2) - IMG_WIDTH)) {
                expected_image = 0;
            } else {
                expected_image = STRONG;
            }

            if (output_image[index] != expected_image) {
#ifdef VERBOSE
                printf("ET: ERROR at (%d,%d): expected = %x, got = %x\n", i, j,
                        expected_image, output_image[index]);
#endif
                num_failures++;
            }
        }
    }

    printf("ET: number of failures = %d\n", num_failures);
}

void add_elem_matrix()
{
    elem_matrix_args *args = (elem_matrix_args*)
        get_memory(sizeof(elem_matrix_args));
    task_struct_t * volatile req = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    args->arg1   = (float*) get_memory_aligned(4 * NUM_PIXELS, CACHELINE_SIZE);
    args->arg2   = (float*) get_memory_aligned(4 * NUM_PIXELS, CACHELINE_SIZE);
    args->output = (float*) get_memory_aligned(4 * NUM_PIXELS, CACHELINE_SIZE);
    args->is_arg2_scalar = 0;
    args->op = ADD;
    args->do_one_minus = 1;

    req->acc_id = ACC_ELEM_MATRIX;
    req->acc_args = (void*) args;
    req->num_children = 0;
    req->num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req->producer[i] = NULL;
        req->producer_forward[i] = 0;
    }

    req->status = REQ_STATUS_READY;

    for (int i = 0; i < NUM_PIXELS; i++) {
        args->arg1[i] = (i % 128) + 1;
        args->arg2[i] = NUM_PIXELS - i;
        args->output[i] = -1;
    }

    run_queue[ACC_ELEM_MATRIX][0][0] = req;
    run_queue_size[ACC_ELEM_MATRIX][0] = 1;
}

void elem_matrix_check_output(elem_matrix_args* args)
{
    printf("EM: checking output\n");

    int num_failures = 0;

    for (int i = 0; i < NUM_PIXELS; i++) {
        float expected = args->arg1[i] + (1 - args->arg2[i]);
        if (fabs(expected - args->output[i]) > 0.0001) {
            num_failures++;
#ifdef VERBOSE
            printf("EM: Error at i = %d; expected = %f, got = %f\n",
                    i, expected, args->output[i]);
#endif
        }
    }

    printf("EM: number of failures = %d\n", num_failures);
}

void add_grayscale()
{
    grayscale_args *args = (grayscale_args*)
        get_memory(sizeof(grayscale_args));
    task_struct_t * volatile req = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    args->input  = (uint8_t*) get_memory_aligned(3 * NUM_PIXELS,
            CACHELINE_SIZE);
    args->output = (float*)   get_memory_aligned(4 * NUM_PIXELS,
            CACHELINE_SIZE);

    req->acc_id = ACC_GRAYSCALE;
    req->acc_args = (void*) args;
    req->num_children = 0;
    req->num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req->producer[i] = NULL;
        req->producer_forward[i] = 0;
    }

    req->status = REQ_STATUS_READY;

    for (int i = 0; i < NUM_PIXELS; i++) {
        int ii = i * 3;  // scale the index into the input image
        args->input[ii] = ii;
        args->input[ii+1] = ii + 1;
        args->input[ii+2] = ii + 2;
        args->output[i] = -1;
    }

    run_queue[ACC_GRAYSCALE][0][0] = req;
    run_queue_size[ACC_GRAYSCALE][0] = 1;
}

void grayscale_check_output(grayscale_args *args)
{
    printf("GRAYSCALE: checking output\n");

    uint8_t *input = args->input;
    float* output = args->output;

    int num_failures = 0;

    for (int i = 0; i < NUM_PIXELS; i++) {
        int ii = i * 3;  // scale the index into the input image
        float expected = (uint8_t) ((input[ii]   * 0.2126) +
                                    (input[ii+1] * 0.7152) +
                                    (input[ii+2] * 0.0722));
        //float expected = (uint8_t) (input[i] * 0.2126);
        if (fabs(output[i] - expected) > 0.0001) {
            num_failures++;
#ifdef VERBOSE
            printf("GRAYSCALE: error at i = %d, input = %d, expected = %f, got = %f\n",
                    i, input[i], expected, output[i]);
#endif
        }
    }

    printf("GRAYSCALE: number of failures = %d\n", num_failures);
}

uint8_t *add_harris_non_max()
{
    harris_non_max_args *args = (harris_non_max_args*)
        get_memory(sizeof(harris_non_max_args));
    task_struct_t * volatile req = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    args->input       = (float*)   get_memory_aligned(4 * NUM_PIXELS,
            CACHELINE_SIZE);
    args->output      = (uint8_t*) get_memory_aligned(NUM_PIXELS,
            CACHELINE_SIZE);
    uint8_t *expected = (uint8_t*) get_memory_aligned(NUM_PIXELS,
            CACHELINE_SIZE);

    req->acc_id = ACC_HARRIS_NON_MAX;
    req->acc_args = (void*) args;
    req->num_children = 0;
    req->num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req->producer[i] = NULL;
        req->producer_forward[i] = 0;
    }

    req->status = REQ_STATUS_READY;

    float max_val = IMG_HEIGHT * IMG_WIDTH * 2;
    int max_val_index = 0;

    for (int i = 0; i < IMG_HEIGHT; i += 3) {
        for (int j = 0; j < IMG_WIDTH; j += 3) {
            bool max_val_set = false;

            for (int ii = 0; ii < 3; ii++) {
                for (int jj = 0; jj < 3; jj++) {
                    int x = i + ii, y = j + jj;

                    if ((x < IMG_HEIGHT) && (y < IMG_WIDTH)) {
                        int index = DIM(x, y);

                        if (((ii * 3) + jj) == max_val_index) {
                            max_val_set = true;
                            args->input[index] = max_val;
                            expected[index] = 255;
                        } else {
                            args->input[index] = index + 1;
                            expected[index] = 0;
                        }

                        args->output[index] = 0x80;
                    }
                }
            }

            if (!max_val_set) {
                int index = DIM(i,j);
                args->input[index] = max_val;
                expected[index] = 255;
            }

            max_val_index = (max_val_index + 1) % 9;
        }
    }

    run_queue[ACC_HARRIS_NON_MAX][0][0] = req;
    run_queue_size[ACC_HARRIS_NON_MAX][0] = 1;

    return expected;
}

void harris_non_max_check_output(harris_non_max_args *args, uint8_t *expected)
{
    printf("HNM: checking output\n");

    int num_failures = 0;

    for (int i = 0; i < IMG_HEIGHT; i++) {
        for (int j = 0; j < IMG_WIDTH; j++) {
            int index = DIM(i,j);

            if (args->output[index] != expected[index]) {
                num_failures++;
#ifdef VERBOSE
                printf("ERROR at (%d,%d): input = %lf, expected = %x, "
                        "got = %x\n", i, j, args->input[index],
                        expected[index], args->output[index]);
#endif
            }
        }
    }

    printf("HARRIS_NON_MAX: number of failures = %d\n", num_failures);
}

void add_isp()
{
    isp_args *args = (isp_args*) get_memory(sizeof(isp_args));
    task_struct_t * volatile req = (task_struct_t*)
        get_memory(sizeof(task_struct_t));

    args->input  = (uint8_t*) get_memory_aligned(
            (IMG_HEIGHT+2) * (IMG_WIDTH+2), CACHELINE_SIZE);
    args->output = (uint8_t*) get_memory_aligned(3 * NUM_PIXELS,
            CACHELINE_SIZE);

    req->acc_id = ACC_ISP;
    req->acc_args = (void*) args;
    req->num_children = 0;
    req->num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req->producer[i] = NULL;
        req->producer_forward[i] = 0;
    }

    req->status = REQ_STATUS_READY;

    memset(args->input, 128, (IMG_HEIGHT+2) * (IMG_WIDTH+2));

    run_queue[ACC_ISP][0][0] = req;
    run_queue_size[ACC_ISP][0] = 1;
}

void isp_check_output(isp_args *args)
{
    printf("ISP: checking output\n");

    int num_failures = 0, img_width = IMG_WIDTH;

    for (int i = 0; i < IMG_HEIGHT; i++) {
        for (int j = 0; j < IMG_WIDTH; j++) {
            uint8_t expected[3] = {180, 0, 180};

            for (int k = 0; k < 3; k++) {
                int index = ISP_OUT_DIM(i,j,k);

                if (args->output[index] != expected[k]) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR at (%d,%d,%d): expected = %3d, got = %3d\n",
                            i, j, k, expected[k], args->output[index]);
#endif
                }
            }
        }
    }

    printf("ISP: number of failures = %d\n", num_failures);
}
