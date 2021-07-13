#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

#define VERBOSE

void gen_data(uint32_t*, uint8_t*);
int test_output(uint8_t*);

int main(void) {
    m5_reset_stats();

    uint32_t base = 0x83000000;
    uint32_t *input = (uint32_t*) base;
    uint8_t *output = (uint8_t*) (base + (ROW*COL*4));

    printf("Generating data\n");
    gen_data(input, output);
    printf("Data generated\n");

    edge_tracking_driver((uint32_t)input, (uint32_t)output, ROW, COL, 0.5,
            0.503);

    printf("Number of failures = %d\n", test_output(output));

    m5_dump_stats();
    m5_exit();
}

void gen_data(uint32_t *input_image, uint8_t *output_image) {
    for (int i = 0; i < ROW; i++) {
        for (int j = 0; j < COL; j++) {
            int index = DIM(i, j);

            input_image[index] = i;
            output_image[index] = 0xff;
        }
    }
}

int test_output(uint8_t *output_image) {
    int num_failures = 0;

    for (int i = 0; i < ROW; i++) {
        for (int j = 0; j < COL; j++) {
            int index = DIM(i, j);
            uint8_t expected_image;

            if ((i == 0) || (i == (ROW-1)) || (j == 0) || (j == (COL-1))) {
                expected_image = 0;
            } else if (index < (((ROW*COL) / 2) - COL)) {
                expected_image = 0;
            } else {
                expected_image = STRONG;
            }

            if (output_image[index] != expected_image) {
#ifdef VERBOSE
                printf("ERROR at (%d,%d): expected = %x, got = %x\n", i, j,
                        expected_image, output_image[index]);
#endif
                num_failures++;
            }
        }
    }

    return num_failures;
}
