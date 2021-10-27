#include "hw_defines.h"

void harris_non_max(uint32_t img_height, uint32_t img_width) {
    float *harris_response = (float*) INPUT_SPM;
    uint32_t *max_values = (uint32_t*) OUTPUT_SPM;

    #pragma clang loop unroll_count(1)
    for (int i = 0; i < img_height; i += 3) {
        #pragma clang loop unroll(disable)
        for (int j = 0; j < img_width; j += 3) {
            int max_i = -1, max_j = -1;
            float max_value = -1;

            #pragma clang loop unroll(disable)
            for (int ii = 0; ii < 3; ii++) {
                #pragma clang loop unroll(disable)
                for (int jj = 0; jj < 3; jj++) {
                    int x = i+ii, y = j+jj;

                    if ((x < img_height) && (y < img_width)) {
                        float value = harris_response[DIM(x, y)];
                        if (value > max_value) {
                            max_i = ii;
                            max_j = jj;
                            max_value = value;
                        }
                    }
                }
            }

            #pragma clang loop unroll(full)
            for (int ii = 0; ii < 3; ii++) {
                #pragma clang loop unroll(full)
                for (int jj = 0; jj < 3; jj++) {
                    int x = i+ii, y = j+jj;

                    if ((x < img_height) && (y < img_width)) {
                        int index = DIM(x, y);
                        if ((ii == max_i) && (jj == max_j)) {
                            max_values[index] = 255;
                        } else {
                            max_values[index] = 0;
                        }
                    }
                }
            }
        }
    }
}
