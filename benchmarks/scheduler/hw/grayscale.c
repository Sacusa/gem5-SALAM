#include "hw_defines.h"

void grayscale(uint64_t num_elems, uint32_t output_spm_addr) {
#if ACC_NUM == 0
    uint8_t *input_image  = (uint8_t*) GRAYSCALE0_INPUT_SPM;
#endif
    float *output_image = (float*) output_spm_addr;

    #pragma clang loop unroll_count(8)
    for (int i = 0; i < num_elems; i++) {
        int ii = i * 3;
        uint8_t r = input_image[ii];
        uint8_t g = input_image[ii+1];
        uint8_t b = input_image[ii+2];
        output_image[i] = (uint8_t) ((r * 0.2126f) + (g * 0.7152f) +
                (b * 0.0722f));
    }
}
