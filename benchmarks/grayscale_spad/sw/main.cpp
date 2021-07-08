#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

// MMRs for CommInterface
volatile uint8_t  * top            = (uint8_t  *) (TOP_MMR);
volatile uint32_t * num_elems      = (uint32_t *) (top + 1);

volatile int acc_finished;

void gen_data(uint8_t*, float*);

int main(void) {
        m5_reset_stats();

    uint32_t base = 0x80c00000;
        uint8_t *input = (uint8_t *)(base);
        float *output  = (float *)(base + ROW*COL);
        acc_finished = 0;

    printf("Generating data\n");
    gen_data(input, output);
    printf("Data generated\n");

    printf("Starting accelerator\n");
    acc_finished = 0;
    *num_elems = (uint32_t) (ROW * COL);
    *top = 0x01;
    while (!acc_finished) {}
    printf("Accelerator finished\n");

    int num_failures = 0;

    for (int i = 0; i < (ROW*COL); i++) {
        int ii = i * 3;  // scale the index into the input image
        float expected = (uint8_t) ((input[ii]   * 0.2126) +
                (input[ii+1] * 0.7152) + (input[ii+2] * 0.0722));
        //float expected = (uint8_t) (input[i] * 0.2126);
        if (fabs(output[i] - expected) > 0.0001) {
            num_failures++;
            printf("ERROR: at i = %d, input = %d, expected = %f, got = %f\n",
                    i, input[i], expected, output[i]);
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
