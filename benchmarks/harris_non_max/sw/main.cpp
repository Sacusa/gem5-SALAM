#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

#define VERBOSE

void gen_data(double*, uint64_t*, uint64_t*);
int test_output(double*, uint64_t*, uint64_t*);

int main(void) {
    m5_reset_stats();

    uint32_t base = 0x86000000;
    double *input  = (double*) base;
    uint64_t *output = (uint64_t*) (base + (ROW*COL*8));
    uint64_t *expected = (uint64_t*) (base + (ROW*COL*16));

    printf("Generating data\n");
    gen_data(input, output, expected);
    printf("Data generated\n");

    harris_non_max_driver((uint32_t)input, (uint32_t)output, ROW, COL);

    printf("Number of failures = %d\n", test_output(input, output, expected));

    m5_dump_stats();
    m5_exit();
}

void gen_data(double *input, uint64_t *output, uint64_t *expected) {
    double max_val = ROW * COL * 2;
    int max_val_index = 0;

    for (int i = 0; i < ROW; i += 3) {
        for (int j = 0; j < COL; j += 3) {
            bool max_val_set = false;

            for (int ii = 0; ii < 3; ii++) {
                for (int jj = 0; jj < 3; jj++) {
                    int x = i + ii, y = j + jj;

                    if ((x < ROW) && (y < COL)) {
                        int index = DIM(x, y);

                        if (((ii * 3) + jj) == max_val_index) {
                            max_val_set = true;
                            input[index] = max_val;
                            expected[index] = 255;
                        } else {
                            input[index] = index + 1;
                            expected[index] = 0;
                        }

                        output[index] = 0x80;
                    }
                }
            }

            if (!max_val_set) {
                int index = DIM(i,j);
                input[index] = max_val;
                expected[index] = 255;
            }

            max_val_index = (max_val_index + 1) % 9;
        }
    }
}

int test_output(double *input, uint64_t *output, uint64_t *expected) {
    int max_val_index = 0, num_failures = 0;

    /*
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            int index = DIM(i,j);
            printf("ERROR at (%d,%d): input = %lf, expected = %x, got = %x\n",
                i, j, input[index], expected[index], output[index]);
        }
    }
    return 0;
    */

    for (int i = 0; i < ROW; i++) {
        for (int j = 0; j < COL; j++) {
            int index = DIM(i,j);

            if (output[index] != expected[index]) {
                num_failures++;
#ifdef VERBOSE
                printf("ERROR at (%d,%d): input = %lf, expected = %x, "
                        "got = %x\n", i, j, input[index], expected[index],
                        output[index]);
#endif
            }
        }
    }

    return num_failures;
}
