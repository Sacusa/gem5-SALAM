#include "hw_defines.h"

void sqr(uint32_t num_elems) {
    uint32_t *input  = (uint32_t*) SQR_INPUT_SPM;
    uint32_t *result = (uint32_t*) SQR_RESULT_SPM;

    #pragma clang loop unroll_count(64)
    for (int i = 0; i < num_elems; i++) {
        result[i] = input[i] * input[i];
    }
}
