#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

int test_output(uint8_t*);

int main(void) {
    m5_reset_stats();
    int input_size = (ROW + 2) * (COL + 2);

    uint32_t base = 0x87000000;
    uint8_t *input  = (uint8_t*) base;
    uint8_t *output = (uint8_t*) (base + input_size);

    printf("Generating data\n");
    memset(input, 128, input_size);
    printf("Data generated\n");

    isp_driver((uint32_t)input, (uint32_t)output, ROW, COL);

    printf("Number of failures = %d\n", test_output(output));

    m5_dump_stats();
    m5_exit();
}

int test_output(uint8_t *output) {
    int num_failures = 0;

    for (int i = 0; i < ROW; i++) {
        for (int j = 0; j < COL; j++) {
            if (output[ISP_OUT_DIM(i,j,0)] != 191) {
                num_failures++;
            }
            if (output[ISP_OUT_DIM(i,j,1)] != 0) {
                num_failures++;
            }
            if (output[ISP_OUT_DIM(i,j,2)] != 191) {
                num_failures++;
            }
        }
    }

    return num_failures;
}
