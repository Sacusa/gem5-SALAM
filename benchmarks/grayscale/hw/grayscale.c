#include "hw_defines.h"

void grayscale(uint64_t num_elems) {
    volatile uint8_t *input_image  = (uint8_t*) INPUT_STR;
    volatile float   *output_image = (float*)   OUTPUT_STR;

    #pragma clang loop unroll(disable)
    for (int i = 0; i < num_elems; i++) {
        uint8_t r = *input_image;
        uint8_t g = *input_image;
        uint8_t b = *input_image;
        *output_image = (uint8_t) ((r * 0.2126) + (g * 0.7152) + (b * 0.0722));
        //*output_image = (uint8_t) (r * 0.2126);
    }
}
