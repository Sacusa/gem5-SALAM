#include <stdio.h>
#include <stdlib.h>

#include "../../common/m5ops.h"
#include "scheduler.h"

#define VERBOSE

void test_canny_non_max();
void cnm_gen_data(float*, float*, uint32_t*);
int  cnm_check_output(float*, float*, uint32_t*);

task_struct_t *run_queue[NUM_ACCS][MAX_ACC_INSTANCES][MAX_NODES];
int run_queue_size[NUM_ACCS][MAX_ACC_INSTANCES];

int main(void) {
    m5_reset_stats();

    for (int i = 0; i < NUM_ACCS; i++) {
        for (int j = 0; j < MAX_ACC_INSTANCES; j++) {
            run_queue_size[i][j] = 0;
        }
    }

    test_canny_non_max();

    m5_dump_stats();
    m5_exit();
}

void test_canny_non_max()
{
    canny_non_max_args args;
    task_struct_t req;

    /* This doesn't work for some reason
    args.hypotenuse = (float*)    malloc(NUM_PIXELS * 4);
    args.theta      = (float*)    malloc(NUM_PIXELS * 4);
    args.output     = (uint32_t*) malloc(NUM_PIXELS * 4);
    */
    uint32_t base = 0x81000000;
    args.hypotenuse = (float*)    (base);
    args.theta      = (float*)    (base + 4*IMG_HEIGHT*IMG_WIDTH);
    args.output     = (uint32_t*) (base + 8*IMG_HEIGHT*IMG_WIDTH);

    req.acc_id = ACC_CANNY_NON_MAX;
    req.acc_args = (void*) &args;
    req.num_children = 0;
    req.num_parents = 0;

    for (int i = 0; i < MAX_ACC_ARGS; i++) {
        req.producer[i] = NULL;
        req.producer_forward[i] = 0;
    }

    req.status = REQ_STATUS_READY;

    printf("CNM: generating data\n");
    cnm_gen_data(args.hypotenuse, args.theta, args.output);

    printf("CNM: running scheduler\n");
    run_queue[ACC_CANNY_NON_MAX][0][0] = &req;
    run_queue_size[ACC_CANNY_NON_MAX][0] = 1;
    schedule(run_queue, run_queue_size);

    printf("CNM: checking output\n");
    cnm_check_output(args.hypotenuse, args.theta, args.output);
}

void cnm_gen_data(float *hypotenuse, float *theta, uint32_t *result) {
    float angles[] = {0.349, 0.698, 1.396, 2.094, 2.967};
    int angles_size = 5, angles_index = 0, hypo = 0;

    for (int i = 0; i < IMG_HEIGHT; i++) {
        angles_index = i % angles_size;
        hypo = i;

        for (int j = 0; j < IMG_WIDTH; j++) {
            hypotenuse[DIM(i,j)] = hypo;
            theta[DIM(i,j)] = angles[angles_index];
            result[DIM(i,j)] = 0xffffffff;

            hypo = (hypo + 1) % IMG_WIDTH;
            angles_index = (angles_index + 1) % angles_size;
        }
    }
}

int cnm_check_output(float *hypotenuse, float *theta, uint32_t *result) {
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

            if (result[index] != expected_value) {
                num_failures++;
#ifdef VERBOSE
                printf("ERROR: at (%d,%d); hypotenuse=%f, theta=%f, q=%f, "
                        "r=%f, expected=%d, got=%d\n", i, j, hypotenuse[index],
                        theta[index], q, r, expected_value, result[index]);
#endif
            }
        }
    }

    return num_failures;
}
