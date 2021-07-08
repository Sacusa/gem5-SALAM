#include "hw_defines.h"

inline uint32_t float_to_int(uint32_t);

void canny_non_max(uint32_t img_height, uint32_t img_width) {
    float *hypotenuse = (float*) HYPO_SPAD;
    float *theta = (float*) THETA_SPAD;
    uint32_t *result = (uint32_t*) RESULT_SPAD;

    int max_height = img_height - 1, max_width = img_width - 1;

    #pragma clang loop unroll(disable)
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

inline uint32_t float_to_int(uint32_t input) {
    uint8_t sign = input >> 31;
    uint32_t exponent = (input >> 23) & 0x0ff;
    uint32_t mantissa = (input & 0x07fffff) | 0x800000;
    uint32_t result;

    if (exponent < 127) {
        result = 0;
    }
    else {
        exponent -= 127;

        if (exponent == 23) {
            result = mantissa;
        }
        else if (exponent < 23) {
            result = mantissa >> (23 - exponent);
        }
        else {
            result = mantissa << (exponent - 23);
        }
    }

    if (sign) {
        result = -result;
    }

    return result;
}
