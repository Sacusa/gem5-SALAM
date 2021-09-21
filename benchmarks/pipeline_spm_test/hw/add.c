#include "hw_defines.h"

void add(uint32_t num_elems) {
    uint32_t *arg1   = (uint32_t*) ADD_ARG1_SPM;
    uint32_t *arg2   = (uint32_t*) ADD_ARG2_SPM;
    uint32_t *result = (uint32_t*) ADD_RESULT_SPM;

    #pragma clang loop unroll_count(64)
    for (int i = 0; i < num_elems; i++) {
        result[i] = arg1[i] + arg2[i];
    }
}
