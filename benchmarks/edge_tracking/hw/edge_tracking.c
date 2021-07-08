#include "hw_defines.h"

void edge_tracking(uint32_t img_height, uint32_t img_width,
        float thr_weak_ratio, float thr_strong_ratio) {
    img_height = ROW;
    img_width = COL;
    thr_weak_ratio = 0.5;
    thr_strong_ratio = 0.503;

    uint32_t *input_image = (uint32_t*) INPUT_SPM;
    uint8_t *output_image = (uint8_t*) OUTPUT_SPM;

    int max_height = img_height - 1, max_width = img_width - 1;
    uint32_t local_maxima[MAX_LOOP_UNFOLD];

    #pragma clang loop unroll(full)
    for (int i = 0; i < MAX_LOOP_UNFOLD; i++) {
        local_maxima[i] = 0;
    }

    /*
    int num_pixels = img_height * img_width;
    #pragma clang loop unroll(disable)
    for (int i = 0; i < num_pixels; i += MAX_LOOP_UNFOLD) {
        #pragma clang loop unroll(full)
        for (int j = 0; j < MAX_LOOP_UNFOLD; j++) {
            if (input_image[i+j] > local_maxima[j]) {
                local_maxima[j] = input_image[i+j];
            }
        }
    }
    */

    uint32_t img_max = 0;
    #pragma clang loop unroll(disable)
    for (int i = 0; i < MAX_LOOP_UNFOLD; i++) {
        if (local_maxima[i] > img_max) { img_max = local_maxima[i]; }
    }

    float thr_strong = img_max * thr_strong_ratio;
    float thr_weak   = thr_strong * thr_weak_ratio;

    /*
    #pragma clang loop unroll_count(32)
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
    */

    #pragma clang loop unroll_count(32)
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
