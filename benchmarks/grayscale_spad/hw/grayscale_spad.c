#include "hw_defines.h"

void grayscale(uint64_t num_elems) {
    num_elems = ROW*COL;

    volatile uint8_t *input_image_base  = (uint8_t*) INPUT_SPAD;
    volatile float   *output_image_base = (float*)   OUTPUT_SPAD;
    volatile uint8_t *input_image  = (uint8_t*) input_image_base;
    volatile float   *output_image = (float*)   output_image_base;

    #pragma clang loop unroll_count(32)
    for (int i = 0; i < num_elems; i++) {
        int ii = i * 3;
        uint8_t r = input_image[ii];
        uint8_t g = input_image[ii+1];
        uint8_t b = input_image[ii+2];
        output_image[i] = (uint8_t) ((r * 0.2126) + (g * 0.7152) +
                (b * 0.0722));
    }
}
