#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

#define VERBOSE

int num_elems = ROW * COL;
void gen_data(uint32_t*, uint32_t*, uint32_t*, uint32_t*);

int main(void) {
    m5_reset_stats();

    uint32_t base = 0x81000000;
    uint32_t *arg1       = (uint32_t *)(base);
    uint32_t *arg2       = (uint32_t *)(base + 4*ROW*COL);
    uint32_t *add_result = (uint32_t *)(base + 8*ROW*COL);
    uint32_t *sqr_result = (uint32_t *)(base + 12*ROW*COL);

    printf("Generating data\n");
    gen_data(arg1, arg2, add_result, sqr_result);
    printf("Data generated\n");

    driver(num_elems, (uint32_t)arg1, (uint32_t)arg2, (uint32_t)add_result,
            (uint32_t)sqr_result);
    for (int i = 0; i < num_elems; i++) {
        uint32_t temp = arg1[i] + arg2[i];
        uint32_t expected = temp * temp;

        if (sqr_result[i] != expected) {
            printf("ERROR at index %d: expected = %d, got = %d\n", i,
                    expected, sqr_result[i]);
        }
    }

    m5_dump_stats();
    m5_exit();
}

void gen_data(uint32_t *arg1, uint32_t *arg2, uint32_t *add_result,
        uint32_t *sqr_result) {
    for (int i = 0; i < num_elems; i++) {
        arg1[i] = i + 1;
        arg2[i] = 2;
        add_result[i] = 0xffffffff;
        sqr_result[i] = 0xffffffff;
    }
}
