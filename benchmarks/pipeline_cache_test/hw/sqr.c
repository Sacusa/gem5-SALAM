#include "hw_defines.h"

void sqr(uint32_t num_elems, uint32_t input_addr, uint32_t result_addr) {
    /*
    uint32_t *input  = (uint32_t*) input_addr;
    uint32_t *result = (uint32_t*) result_addr;
    */
    uint32_t *input  = (uint32_t*) 0x81008000;
    uint32_t *result = (uint32_t*) 0x8100c000;

    #pragma clang loop unroll_count(64)
    for (int i = 0; i < num_elems; i++) {
        result[i] = input[i] * input[i];
    }
}
