#include "hw_defines.h"

void convolution0(uint32_t img_height, uint32_t img_width, uint32_t kern_height,
        uint32_t kern_width, uint8_t mod_and_floor, uint8_t spm_part) {
#if ACC_NUM == 0
    float *input_image = (float*) CONVOLUTION0_INPUT_SPM;
    float *kernel      = (float*) CONVOLUTION0_KERNEL_SPM;
    float *output_image;

    if (spm_part == 1) {
        output_image = (float*) CONVOLUTION0_OUTPUT1_SPM;
    }
    else {
        output_image = (float*) CONVOLUTION0_OUTPUT0_SPM;
    }
#elif ACC_NUM == 1
    float *input_image = (float*) CONVOLUTION1_INPUT_SPM;
    float *kernel      = (float*) CONVOLUTION1_KERNEL_SPM;
    float *output_image;

    if (spm_part == 1) {
        output_image = (float*) CONVOLUTION1_OUTPUT1_SPM;
    }
    else {
        output_image = (float*) CONVOLUTION1_OUTPUT0_SPM;
    }
#endif

    const int start_in_i = -((kern_height - 1) / 2);
    const int start_in_j = -((kern_width  - 1) / 2);

    #pragma clang loop unroll_count(32)
    for (int in_i = start_in_i, out_i = 0; out_i < img_height; in_i++,
            out_i++) {
        #pragma clang loop unroll(disable)
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
