#include "hw_defines.h"

void add(uint32_t num_elems, uint32_t arg1_addr, uint32_t arg2_addr,
        uint32_t result_add) {
    /*
    uint32_t *arg1   = (uint32_t*) arg1_addr;
    uint32_t *arg2   = (uint32_t*) arg2_addr;
    uint32_t *result = (uint32_t*) result_addr;
    */
    uint32_t *arg1   = (uint32_t*) 0x81000000;
    uint32_t *arg2   = (uint32_t*) 0x81004000;
    uint32_t *result = (uint32_t*) 0x81008000;

    #pragma clang loop unroll_count(64)
    for (int i = 0; i < num_elems; i++) {
        result[i] = arg1[i] + arg2[i];
    }
}
