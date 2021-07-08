#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

void gen_data(float*, float*, float*);
void run_and_check(float*, float*, float*, uint8_t);

int main(void) {
    m5_reset_stats();

    uint32_t base = 0x80300000;
    float *arg1   = (float *)(base);
    float *arg2   = (float *)(base + 4*ROW*COL);
    float *result = (float *)(base + 8*ROW*COL);

    printf("Generating data\n");
    gen_data(arg1, arg2, result);
    printf("Data generated\n");

    for (int i = 0; i < 5; i++) {
        run_and_check(arg1, arg2, result, i);
    }

    m5_dump_stats();
    m5_exit();
}

void gen_data(float *arg1, float *arg2, float *result) {
    int num_elems = ROW * COL;

    for (int i = 0; i < num_elems; i++) {
        arg1[i] = i + 1;
        arg2[i] = num_elems - i;
        result[i] = -1;
    }
}

void run_and_check(float *arg1, float *arg2, float *result, uint8_t test_op) {
    elem_matrix_driver(ROW*COL, (uint32_t)arg1, (uint32_t)arg2,
            (uint32_t)result, test_op, 0, 0);

    int num_failures = 0;

    switch (test_op) {
        case ADD:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = arg1[i] + arg2[i];
                if (fabs(expected - result[i]) > 0.0001) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: ADD at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of ADD failures = %d\n", num_failures);
            break;

        case SUB:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = arg1[i] - arg2[i];
                if (fabs(expected - result[i]) > 0.0001) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: SUB at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of SUB failures = %d\n", num_failures);
            break;

        case MUL:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = arg1[i] * arg2[i];
                if (fabs(expected - result[i]) > 0.0001) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: MUL at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of MUL failures = %d\n", num_failures);
            break;

        case DIV:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = arg1[i] / arg2[i];
                if (fabs(expected - result[i]) > 0.0001) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: DIV at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of DIV failures = %d\n", num_failures);
            break;

        case SQR:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = arg1[i] * arg1[i];
                if (fabs(expected - result[i]) > 0.0001) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: SQR at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of SQR failures = %d\n", num_failures);
            break;

        case SQRT:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = sqrtf(arg1[i]);
                if (fabs(expected - result[i]) > 0.0001) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: SQRT at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of SQRT failures = %d\n", num_failures);
            break;

        case ATAN2:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = atan2(arg2[i], arg1[i]);
                if (fabs(expected - result[i]) > 0.0001) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: ATAN2 at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of ATAN2 failures = %d\n", num_failures);
            break;

        case TANH:
            for (int i = 0; i < (ROW*COL); i++) {
                float expected = tanhf(arg1[i]);
                if (fabs(expected - result[i]) > 1) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: TANH at i = %d; expected = %f, got = %f\n",
                            i, expected, result[i]);
#endif
                }
            }
            printf("Number of TANH failures = %d\n", num_failures);
            break;

        case SIGMOID:
            for (int i = 0; i < (ROW*COL); i++) {
                float arg1_exp = expf(arg1[i]);
                float arg1_sigmoid = arg1_exp / (arg1_exp + 1);

                if (fabs(arg1_sigmoid - result[i]) > 0.01) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR: SIGMOID at i = %d; expected = %f, "
                            "got = %f\n", i, arg1_sigmoid, result[i]);
#endif
                }
            }
            printf("Number of SIGMOID failures = %d\n", num_failures);
            break;
    }
}
