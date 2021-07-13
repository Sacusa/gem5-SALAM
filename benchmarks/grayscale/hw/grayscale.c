#include "hw_defines.h"

void grayscale(uint64_t num_elems) {
    uint8_t *input_image  = (uint8_t*) INPUT_SPM;
    float   *output_image = (float*)   OUTPUT_SPM;

    #pragma clang loop unroll(disable)
    for (int i = 0; i < num_elems; i++) {
        int ii = i * 3;
        uint8_t r = input_image[ii];
        uint8_t g = input_image[ii+1];
        uint8_t b = input_image[ii+2];
        output_image[i] = (uint8_t) ((r * 0.2126f) + (g * 0.7152f) +
                (b * 0.0722f));
    }
}
