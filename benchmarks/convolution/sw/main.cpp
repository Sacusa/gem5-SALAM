#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

void gen_data(float*, float*, float*);
int test_output(float*, float*, float*);

int main(void) {
    m5_reset_stats();

    uint32_t base = 0x80100000;
    float *input  = (float*) base;
    float *output = (float*) (base + (ROW*COL*4));
    float *kernel = (float*) (base + (ROW*COL*8));

    printf("Generating data\n");
    gen_data(input, kernel, output);
    printf("Data generated\n");

    driver((uint32_t)input, (uint32_t)output, (uint32_t)kernel, ROW, COL,
            KERN_ROW, KERN_COL, 0);

    printf("Number of failures = %d\n", test_output(input, kernel, output));

    m5_dump_stats();
    m5_exit();
}

void gen_data(float *input, float *kernel, float *output) {
    for (int i = 0; i < (ROW*COL); i++) {
        input[i] = i + 1;
        output[i] = -1;
    }

    for (int i = 0; i < KERN_ROW; i++) {
        for (int j = 0; j < KERN_COL; j++) {
            int index = (i*KERN_COL) + j;
            kernel[index] = index + 1;
        }
    }
}

int test_output(float *input_image, float *kernel, float *output_image) {
    int delta_i = (KERN_ROW - 1) / 2;
    int delta_j = (KERN_COL - 1) / 2;
    int num_failures = 0;

    for (int i = 0; i < ROW; ++i) {
        for (int j = 0; j < COL; ++j) {
            float partial_sum = 0;

            for (int ki = 0; ki < KERN_ROW; ++ki) {
                for (int kj = 0; kj < KERN_COL; ++kj) {
                    int row = i - delta_i + ki;
                    int col = j - delta_j + kj;

                    if ((row >= 0) && (row < ROW) && (col >= 0) &&
                            (col < COL)) {
                        partial_sum += input_image[DIM(row, col)] *
                            kernel[(ki*KERN_COL) + kj];
                    }
                }
            }

            if (fabs(partial_sum - output_image[DIM(i, j)]) > 0.0001) {
                printf("ERROR at (%d,%d): expected = %f, got = %f\n", i, j,
                        partial_sum, output_image[DIM(i, j)]);
                num_failures++;
            }
        }
    }

    return num_failures;
}
