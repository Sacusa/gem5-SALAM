#include "hw_defines.h"

void edge_tracking(uint32_t img_height, uint32_t img_width,
        float thr_weak_ratio, float thr_strong_ratio) {
    thr_weak_ratio = 0.5;
    thr_strong_ratio = 0.503;

    uint32_t *input_image = (uint32_t*) INPUT_SPM;
    uint8_t *output_image = (uint8_t*) OUTPUT_SPM;
    uint32_t *local_maxima = (uint32_t*) LOCAL_MAXIMA_SPM;

    int max_height = img_height - 1, max_width = img_width - 1;

    uint32_t img_max = 0;
    int num_pixels = img_height * img_width;
    #pragma clang loop unroll(disable)
    for (int i = 0; i < num_pixels; i++) {
        if (input_image[i] > img_max) { img_max = input_image[i]; }
    }

    float thr_strong = img_max * thr_strong_ratio;
    float thr_weak   = thr_strong * thr_weak_ratio;

    #pragma clang loop unroll_count(4)
    for (int i = 0; i < img_height; i++) {
        #pragma clang loop unroll(disable)
        for (int j = 0; j < img_width; j++) {
            int index = DIM(i,j);

            if (input_image[index] < thr_weak) {
                input_image[index] = 0;
            }
            else if (input_image[index] >= thr_strong) {
                input_image[index] = STRONG;
            }
            else {
                input_image[index] = WEAK;
            }
        }
    }

    #pragma clang loop unroll_count(4)
    for (int i = 0; i < img_height; i++) {
        #pragma clang loop unroll(disable)
        for (int j = 0; j < img_width; j++) {
            int index = DIM(i,j);

            if ((i == 0) || (i == max_height) || (j == 0) ||
                    (j == max_width)) {
                output_image[index] = 0;
            } else if (input_image[index] == WEAK) {
                if ((input_image[DIM(i-1,j-1)] == STRONG) ||
                    (input_image[DIM(i-1,j  )] == STRONG) ||
                    (input_image[DIM(i-1,j+1)] == STRONG) ||
                    (input_image[DIM(i  ,j-1)] == STRONG) ||
                    (input_image[DIM(i  ,j+1)] == STRONG) ||
                    (input_image[DIM(i+1,j-1)] == STRONG) ||
                    (input_image[DIM(i+1,j  )] == STRONG) ||
                    (input_image[DIM(i+1,j+1)] == STRONG)) {
                    output_image[index] = STRONG;
                } else {
                    output_image[index] = 0;
                }
            } else {
                output_image[index] = input_image[index];
            }
        }
    }
}
