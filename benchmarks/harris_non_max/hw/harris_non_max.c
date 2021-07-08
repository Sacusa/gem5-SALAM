#include "hw_defines.h"

inline void gen_data_acc(double*);

void harris_non_max(uint32_t img_height, uint32_t img_width) {
    uint8_t *hr_base = (uint8_t*) INPUT_SPM;
    double *harris_response = (double*) INPUT_SPM;

    uint8_t *mv_base = (uint8_t*) OUTPUT_SPM;
    uint64_t *max_values = (uint64_t*) OUTPUT_SPM;

    #pragma clang loop unroll_count(32)
    for (int i = 0; i < img_height; i += 3) {
        #pragma clang loop unroll(disable)
        for (int j = 0; j < img_width; j += 3) {
            int max_i = -1, max_j = -1;
            double max_value = -1;

            #pragma clang loop unroll(disable)
            for (int ii = 0; ii < 3; ii++) {
                #pragma clang loop unroll(disable)
                for (int jj = 0; jj < 3; jj++) {
                    int x = i+ii, y = j+jj;

                    if ((x < img_height) && (y < img_width)) {
                        double value = harris_response[DIM(x, y)];
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

inline void gen_data_acc(double *input) {
    double max_val = ROW * COL * 2;
    int max_val_index = 0;

    #pragma clang loop unroll_count(32)
    for (int i = 0; i < ROW; i += 3) {
        #pragma clang loop unroll(disable)
        for (int j = 0; j < COL; j += 3) {
            bool max_val_set = false;

            #pragma clang loop unroll(disable)
            for (int ii = 0; ii < 3; ii++) {
                #pragma clang loop unroll(disable)
                for (int jj = 0; jj < 3; jj++) {
                    int x = i + ii, y = j + jj;

                    if ((x < ROW) && (y < COL)) {
                        int index = DIM(x, y);

                        if (((ii * 3) + jj) == max_val_index) {
                            max_val_set = true;
                            input[index] = max_val;
                        } else {
                            input[index] = index + 1;
                        }
                    }
                }
            }

            if (!max_val_set) {
                int index = DIM(i,j);
                input[index] = max_val;
            }

            max_val_index = (max_val_index + 1) % 9;
        }
    }
}
