#include "hw_defines.h"

void canny_non_max(uint32_t img_height, uint32_t img_width, uint8_t spm_part) {
#if ACC_NUM == 0
    float *hypotenuse = (float*) CNM0_HYPO_SPM;
    float *theta = (float*) CNM0_THETA_SPM;
    uint32_t *result;

    if (spm_part == 1) {
        result = (uint32_t*) CNM0_OUTPUT1_SPM;
    }
    else {
        result = (uint32_t*) CNM0_OUTPUT0_SPM;
    }
#endif

    int max_height = img_height - 1, max_width = img_width - 1;

    #pragma clang loop unroll_count(32)
    for (int i = 0; i < img_height; i++) {
        #pragma clang loop unroll(disable)
        for (int j = 0; j < img_width; j++) {
            float q = 255, r = 255;
            int index = DIM(i,j);

            if ((i == 0) || (i == max_height) || (j == 0) ||
                (j == max_width)) {
                result[index] = 0;
            }
            else {
                float angle = theta[index] * (180 / PI);
                if (angle < 0) { angle += 180; }

                // angle 0
                if (((angle >= 0)     && (angle < 22.5)) ||
                    ((angle >= 157.5) && (angle <= 180))) {
                    q = hypotenuse[DIM(i,j+1)];
                    r = hypotenuse[DIM(i,j-1)];
                }

                // angle 45
                else if ((angle >= 22.5) && (angle < 67.5)) {
                    q = hypotenuse[DIM(i+1,j-1)];
                    r = hypotenuse[DIM(i-1,j+1)];
                }

                // angle 90
                else if ((angle >= 67.5) && (angle < 112.5)) {
                    q = hypotenuse[DIM(i+1,j)];
                    r = hypotenuse[DIM(i-1,j)];
                }

                // angle 135
                else if ((angle >= 112.5) && (angle < 157.5)) {
                    q = hypotenuse[DIM(i-1,j-1)];
                    r = hypotenuse[DIM(i+1,j+1)];
                }

                if ((hypotenuse[index] >= q) && (hypotenuse[index] >= r)) {
                    result[index] = hypotenuse[index];
                }
                else {
                    result[index] = 0;
                }
            }
        }
    }
}
