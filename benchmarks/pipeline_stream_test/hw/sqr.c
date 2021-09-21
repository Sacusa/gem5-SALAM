#include "hw_defines.h"

void sqr(uint32_t num_elems) {
    volatile uint32_t *input  = (uint32_t*) SQR_INPUT_STR;
    uint32_t *result = (uint32_t*) SQR_RESULT_SPM;

    #pragma clang loop unroll_count(64)
    for (int i = 0; i < num_elems; i++) {
        uint32_t input_val = *input;
        result[i] = input_val * input_val;
    }
}
