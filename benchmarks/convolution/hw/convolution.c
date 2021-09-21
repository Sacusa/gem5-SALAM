#include "hw_defines.h"

void convolution(uint32_t img_height, uint32_t img_width, uint32_t kern_height,
        uint32_t kern_width, uint8_t mod_and_floor) {
    float *input_image  = (float*) INPUT_SPM;
    float *output_image = (float*) OUTPUT_SPM;
    float *kernel       = (float*) KERNEL_SPM;

    const int start_in_i = -((kern_height - 1) / 2);
    const int start_in_j = -((kern_width  - 1) / 2);

    #pragma clang loop unroll_count(32)
    for (int in_i = start_in_i, out_i = 0; out_i < img_height; in_i++,
            out_i++) {
        #pragma clang loop unroll_count(8)
        for (int in_j = start_in_j, out_j = 0; out_j < img_width; in_j++,
                out_j++) {
            float partial_sum = 0;

            #pragma clang loop unroll(disable)
            for (int ki = 0; ki < kern_height; ki++) {
                bool valid_row = ((in_i+ki) >= 0) && ((in_i+ki) < img_height);

                if (!valid_row) { continue; }

                #pragma clang loop unroll(disable)
                for (int kj = 0; kj < kern_width; kj++) {
                    bool valid_col = ((in_j+kj) >= 0) &&
                                     ((in_j+kj) < img_width);

                    if (!valid_col) { continue; }

                    partial_sum += input_image[DIM(in_i+ki, in_j+kj)] *
                        kernel[KERN_DIM(ki, kj)];
                }
            }

            if (mod_and_floor) {
                partial_sum = partial_sum < 0 ? -partial_sum : partial_sum;
                output_image[DIM(out_i, out_j)] = (float)(uint8_t) partial_sum;
            } else {
                output_image[DIM(out_i, out_j)] = partial_sum;
            }
        }
    }
}
