#include "hw_defines.h"

// Helper method declarations
static inline float em_sqrt(float x);
static inline float em_atan2(float y, float x);
static inline float em_exp(float x);

void elem_matrix(uint32_t num_elems, uint8_t op, uint8_t is_arg2_scalar,
        uint8_t do_one_minus, uint8_t spm_part) {
#if ACC_NUM == 0
    float *arg1 = (float*) ELEM_MATRIX0_ARG1_SPM;
    float *arg2 = (float*) ELEM_MATRIX0_ARG2_SPM;
    float *result;

    if (spm_part == 1) {
        result = (float*) ELEM_MATRIX0_OUTPUT1_SPM;
    }
    else {
        result = (float*) ELEM_MATRIX0_OUTPUT0_SPM;
    }
#elif ACC_NUM == 1
    float *arg1 = (float*) ELEM_MATRIX1_ARG1_SPM;
    float *arg2 = (float*) ELEM_MATRIX1_ARG2_SPM;
    float *result;

    if (spm_part == 1) {
        result = (float*) ELEM_MATRIX1_OUTPUT1_SPM;
    }
    else {
        result = (float*) ELEM_MATRIX1_OUTPUT0_SPM;
    }
#elif ACC_NUM == 2
    float *arg1 = (float*) ELEM_MATRIX2_ARG1_SPM;
    float *arg2 = (float*) ELEM_MATRIX2_ARG2_SPM;
    float *result;

    if (spm_part == 1) {
        result = (float*) ELEM_MATRIX2_OUTPUT1_SPM;
    }
    else {
        result = (float*) ELEM_MATRIX2_OUTPUT0_SPM;
    }
#elif ACC_NUM == 3
    float *arg1 = (float*) ELEM_MATRIX3_ARG1_SPM;
    float *arg2 = (float*) ELEM_MATRIX3_ARG2_SPM;
    float *result;

    if (spm_part == 1) {
        result = (float*) ELEM_MATRIX3_OUTPUT1_SPM;
    }
    else {
        result = (float*) ELEM_MATRIX3_OUTPUT0_SPM;
    }
#endif

    float arg2_val;

    switch (op) {
        case ADD:
        case SUB:
        case MUL:
        case DIV:
        case ATAN2: if (is_arg2_scalar) { arg2_val = arg2[0]; }
    }

    #pragma clang loop unroll_count(32)
    for (int i = 0; i < num_elems; i++) {
        switch (op) {
            case ADD: {
                if (!is_arg2_scalar) { arg2_val = arg2[i]; }

                if (do_one_minus) { result[i] = arg1[i] + (1 - arg2_val); }
                else              { result[i] = arg1[i] + arg2_val;  }
                break;
            }

            case SUB: {
                if (!is_arg2_scalar) { arg2_val = arg2[i]; }

                if (do_one_minus) { result[i] = arg1[i] - (1 - arg2_val); }
                else              { result[i] = arg1[i] - arg2_val;  }
                break;
            }

            case MUL: {
                if (!is_arg2_scalar) { arg2_val = arg2[i]; }

                if (do_one_minus) { result[i] = arg1[i] * (1 - arg2_val); }
                else              { result[i] = arg1[i] * arg2_val;  }
                break;
            }

            case DIV: {
                if (!is_arg2_scalar) { arg2_val = arg2[i]; }

                if (do_one_minus) { result[i] = arg1[i] / (1 - arg2_val); }
                else              { result[i] = arg1[i] / arg2_val;  }
                break;
            }

            case SQR: {
                result[i] = arg1[i] * arg1[i];
                break;
            }

            case SQRT: {
                result[i] = em_sqrt(arg1[i]);
                break;
            }

            case ATAN2: {
                if (!is_arg2_scalar) { arg2_val = arg2[i]; }

                if (do_one_minus) { result[i] = em_atan2(1-arg2_val, arg1[i]); }
                else              { result[i] = em_atan2(arg2_val, arg1[i]); }
                break;
            }

            case TANH: {
                float my_exp = em_exp(arg1[i]);
                float my_exp_sqr = my_exp * my_exp;
                result[i] = (my_exp_sqr - 1) / (my_exp_sqr + 1);
                break;
            }

            case SIGMOID: {
                float my_exp = em_exp(arg1[i]);
                result[i] = my_exp / (my_exp + 1);
                break;
            }

            default: {
                result[i] = -100;
                break;
            }
        }
    }
}

/*
 * Helper methods definitions
 */

static inline __attribute__((always_inline)) float em_sqrt(float x) {
    const float threehalfs = 1.5F;

    union sqrt_t {
        float f;
        uint32_t i;
    };

    float x2 = x * 0.5F;
    union sqrt_t conv = { .f = x };
    conv.i = 0x5f3759df - (conv.i >> 1);
    conv.f *= threehalfs - (x2 * conv.f * conv.f);
    conv.f *= threehalfs - (x2 * conv.f * conv.f);
    conv.f *= threehalfs - (x2 * conv.f * conv.f);
    return 1/conv.f;
}

static inline __attribute__((always_inline)) float em_atan2(float y, float x) {
    float a, r, s, t, c, q, ax, ay, mx, mn;
    ax = x < 0 ? -x : x;
    ay = y < 0 ? -y : y;
    mx = ay > ax ? ay : ax;
    mn = ay < ax ? ay : ax;
    a = mn / mx;
    /* Minimax polynomial approximation to atan(a) on [0,1] */
    s = a * a;
    c = s * a;
    q = s * s;
    r =  0.024840285f * q + 0.18681418f;
    t = -0.094097948f * q - 0.33213072f;
    r = r * s + t;
    r = r * c + a;
    /* Map to full circle */
    if (ay > ax) r = 1.57079637f - r;
    if (x <   0) r = 3.14159274f - r;
    if (y <   0) r = -r;
    return r;
}

static inline __attribute__((always_inline)) float em_exp(float x) {
    union { float f; uint32_t i; } u, v;
    u.i = (uint32_t) (6051102 * x + 1056478197);
    v.i = (uint32_t) (1056478197 - 6051102 * x);
    return u.f / v.f;
}
