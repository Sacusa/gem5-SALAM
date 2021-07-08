#include "hw_defines.h"

// Helper method declarations
inline float em_sqrt(float x);
inline float em_atan2(float y, float x);
inline float em_exp(float x);

void elem_matrix(uint64_t num_elems, uint64_t op, uint64_t is_arg2_scalar,
        uint64_t do_one_minus) {
    volatile float *arg1   = (float*) ARG1_STR;
    volatile float *arg2   = (float*) ARG2_STR;
    volatile float *result = (float*) RESULT_STR;

    float arg2_val;

    switch (op) {
        case ADD:
        case SUB:
        case MUL:
        case DIV:
        case ATAN2: if (is_arg2_scalar) { arg2_val = *arg2; }
    }

    #pragma clang loop unroll_count(64)
    for (int i = 0; i < num_elems; i++) {
        float arg1_val = *arg1;

        switch (op) {
            case ADD:
                if (!is_arg2_scalar) { arg2_val = *arg2; }

                if (do_one_minus) { *result = arg1_val + (1 - arg2_val); }
                else              { *result = arg1_val + arg2_val;  }
                break;

            case SUB:
                if (!is_arg2_scalar) { arg2_val = *arg2; }

                if (do_one_minus) { *result = arg1_val - (1 - arg2_val); }
                else              { *result = arg1_val - arg2_val;  }
                break;

            case MUL:
                if (!is_arg2_scalar) { arg2_val = *arg2; }

                if (do_one_minus) { *result = arg1_val * (1 - arg2_val); }
                else              { *result = arg1_val * arg2_val;  }
                break;

            case DIV:
                if (!is_arg2_scalar) { arg2_val = *arg2; }

                if (do_one_minus) { *result = arg1_val / (1 - arg2_val); }
                else              { *result = arg1_val / arg2_val;  }
                break;

            case SQR:
                *result = arg1_val * arg1_val;
                break;

            case SQRT:
                *result = em_sqrt(arg1_val);
                break;

            case ATAN2:
                if (!is_arg2_scalar) { arg2_val = *arg2; }

                if (do_one_minus) { *result = em_atan2(1-arg2_val, arg1_val); }
                else              { *result = em_atan2(arg2_val, arg1_val); }
                break;

            case TANH: {
                float my_exp = em_exp(arg1_val);
                float my_exp_sqr = my_exp * my_exp;
                *result = (my_exp_sqr - 1) / (my_exp_sqr + 1);
                break;
            }

            case SIGMOID: {
                float my_exp = em_exp(arg1_val);
                *result = my_exp / (my_exp + 1);
                break;
            }

            default:
                *result = -100;
                break;
        }
    }
}

/*
 * Helper methods definitions
 */

inline float em_sqrt(float x) {
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

inline float em_atan2(float y, float x) {
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

inline float em_exp(float x) {
    union { float f; int i; } u, v;
    u.i = (long long) (6051102 * x + 1056478197);
    v.i = (long long) (1056478197 - 6051102 * x);
    return u.f / v.f;
}
