#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

#define VERBOSE

void gen_data(uint8_t*, float*);

int main(void) {
        m5_reset_stats();

    uint32_t base = 0x80400000;
        uint8_t *input = (uint8_t *)(base);
        float *output  = (float *)(base + ROW*COL*3);

    printf("Generating data\n");
    gen_data(input, output);
    printf("Data generated\n");

    grayscale_driver(ROW * COL, (uint32_t)input, (uint32_t)output);

    int num_failures = 0;

    for (int i = 0; i < (ROW*COL); i++) {
        int ii = i * 3;  // scale the index into the input image
        float expected = (uint8_t) ((input[ii]   * 0.2126) +
                (input[ii+1] * 0.7152) +
                (input[ii+2] * 0.0722));
        //float expected = (uint8_t) (input[i] * 0.2126);
        if (fabs(output[i] - expected) > 0.0001) {
            num_failures++;
#ifdef VERBOSE
            printf("ERROR: at i = %d, input = %d, expected = %f, got = %f\n",
                    i, input[i], expected, output[i]);
#endif
        }
    }

    printf("Number of failures = %d\n", num_failures);

        m5_dump_stats();
        m5_exit();
}

void gen_data(uint8_t *input, float *output) {
    for (int i = 0; i < (ROW*COL); i++) {
        int ii = i * 3;  // scale the index into the input image
        input[ii] = ii;
        input[ii+1] = ii + 1;
        input[ii+2] = ii + 2;
        output[i] = -1;
    }
}
