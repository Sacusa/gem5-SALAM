#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

#define VERBOSE

void gen_data(float*, float*, uint32_t*);
int  check_output(float*, float*, uint32_t*);

int main(void) {
    m5_reset_stats();

    uint32_t base = 0x81000000;
    float *hypotenuse = (float *)(base);
    float *theta      = (float *)(base + 4*ROW*COL);
    uint32_t *result  = (uint32_t *)(base + 8*ROW*COL);

    printf("Generating data\n");
    gen_data(hypotenuse, theta, result);
    printf("Data generated\n");

    canny_non_max_driver(ROW, COL, (uint32_t)hypotenuse, (uint32_t)theta,
            (uint32_t)result);

    printf("Number of errors = %d\n", check_output(hypotenuse, theta, result));

    m5_dump_stats();
    m5_exit();
}

void gen_data(float *hypotenuse, float *theta, uint32_t *result) {
    //float angles[] = {0.349, 0.698, 1.396, 2.094, 2.967};
    float angles[] = {0.349};
    int angles_size = 1, angles_index = 0, hypo = 0;

    for (int i = 0; i < ROW; i++) {
        angles_index = i % angles_size;
        hypo = i;

        for (int j = 0; j < COL; j++) {
            hypotenuse[DIM(i,j)] = hypo;
            theta[DIM(i,j)] = angles[angles_index];
            result[DIM(i,j)] = 0xffffffff;

            hypo = (hypo + 1) % COL;
            angles_index = (angles_index + 1) % angles_size;
        }
    }
}

int check_output(float *hypotenuse, float *theta, uint32_t *result) {
    int max_height = ROW - 1, max_width = COL - 1;
    int num_failures = 0;

    for (int i = 0; i < ROW; i++) {
        for (int j = 0; j < COL; j++) {
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

            float result_float;
            memcpy(&result_float, &(result[index]), 4);
            result[index] = result_float;

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
