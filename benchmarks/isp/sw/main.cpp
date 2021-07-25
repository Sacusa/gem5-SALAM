#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

#define VERBOSE

int test_output(uint8_t*, uint8_t*);
static inline float sqrtf(float, float);
void isp(uint32_t, uint32_t, uint8_t*, uint8_t*);

int main(void) {
    m5_reset_stats();
    int input_size = (ROW + 2) * (COL + 2);
    int output_size = ROW * COL * 3;

    uint32_t base = 0x87000000;
    uint8_t *input  = (uint8_t*) base;
    uint8_t *output = (uint8_t*) (base + input_size);
    uint8_t *expected = (uint8_t*) (base + input_size + output_size);

    printf("Generating data\n");
    memset(input, 128, input_size);
    printf("Data generated\n");

    isp_driver((uint32_t)input, (uint32_t)output, ROW, COL);
    isp(ROW, COL, input, expected);

    printf("Testing output\n");
    printf("Number of failures = %d\n", test_output(output, expected));

    m5_dump_stats();
    m5_exit();
}

int test_output(uint8_t *output, uint8_t *expected) {
    int num_failures = 0;

    for (int i = 0; i < ROW; i++) {
        for (int j = 0; j < COL; j++) {
            for (int k = 0; k < 3; k++) {
                int index = ISP_OUT_DIM(i,j,k);

                if (output[index] != expected[index]) {
                    num_failures++;
#ifdef VERBOSE
                    printf("ERROR at (%d,%d,%d): expected = %3d, got = %3d\n",
                            i, j, k, expected[index], output[index]);
#endif
                }
            }
        }
    }

    return num_failures;
}

void isp(uint32_t img_height, uint32_t img_width, uint8_t *input_image,
        uint8_t *output_image) {
    enum channels { R=0, G, B };
    float ccm[3] = {255/142, 196/255, 1};

    for (int i = 0; i < img_height; i += 2) {
        for (int j = 0; j < img_width; j += 2) {
            int x, y;
            float pixel_tl[3], pixel_tr[3], pixel_bl[3], pixel_br[3];

            // top-left
            x = i; y = j;
            pixel_tl[R] = (input_image[ISP_IN_DIM(x-1,y-1)] +
                    input_image[ISP_IN_DIM(x-1,y+1)] +
                    input_image[ISP_IN_DIM(x+1,y-1)] +
                    input_image[ISP_IN_DIM(x+1,y+1)]) >> 2;
            pixel_tl[G] = (input_image[ISP_IN_DIM(x-1,y)] +
                    input_image[ISP_IN_DIM(x,y-1)] +
                    input_image[ISP_IN_DIM(x+1,y)] +
                    input_image[ISP_IN_DIM(x,y+1)]) >> 2;
            pixel_tl[B] = input_image[ISP_IN_DIM(x,y)];

            pixel_tl[R] = sqrtf((pixel_tl[R] * ccm[R]) / 255) * 255;
            pixel_tl[G] = sqrtf((pixel_tl[G] * ccm[G]) / 255) * 255;
            pixel_tl[B] = sqrtf((pixel_tl[B] * ccm[B]) / 255) * 255;

            output_image[ISP_OUT_DIM(x,y,R)] = (pixel_tl[R] > 255) ?
                255 : pixel_tl[R];
            output_image[ISP_OUT_DIM(x,y,G)] = (pixel_tl[G] > 255) ?
                255 : pixel_tl[G];
            output_image[ISP_OUT_DIM(x,y,B)] = (pixel_tl[B] > 255) ?
                255 : pixel_tl[B];

            // top-right
            x = i; y = j+1;
            pixel_tr[R] = (input_image[ISP_IN_DIM(x-1,y)] +
                    input_image[ISP_IN_DIM(x+1,y)]) >> 1;
            pixel_tr[G] = input_image[ISP_IN_DIM(x,y)];
            pixel_tr[B] = (input_image[ISP_IN_DIM(x,y-1)] +
                    input_image[ISP_IN_DIM(x,y+1)]) >> 1;

            pixel_tr[R] = sqrtf((pixel_tr[R] * ccm[R]) / 255) * 255;
            pixel_tr[G] = sqrtf((pixel_tr[G] * ccm[G]) / 255) * 255;
            pixel_tr[B] = sqrtf((pixel_tr[B] * ccm[B]) / 255) * 255;

            output_image[ISP_OUT_DIM(x,y,R)] = pixel_tr[R] > 255 ?
                255 : pixel_tr[R];
            output_image[ISP_OUT_DIM(x,y,G)] = pixel_tr[G] > 255 ?
                255 : pixel_tr[G];
            output_image[ISP_OUT_DIM(x,y,B)] = pixel_tr[B] > 255 ?
                255 : pixel_tr[B];

            // bottom-left
            x = i+1; y = j;
            pixel_bl[R] = (input_image[ISP_IN_DIM(x,y-1)] +
                    input_image[ISP_IN_DIM(x,y+1)]) >> 1;
            pixel_bl[G] = input_image[ISP_IN_DIM(x,y)];
            pixel_bl[B] = (input_image[ISP_IN_DIM(x-1,y)] +
                    input_image[ISP_IN_DIM(x+1,y)]) >> 1;

            pixel_bl[R] = sqrtf((pixel_bl[R] * ccm[R]) / 255) * 255;
            pixel_bl[G] = sqrtf((pixel_bl[G] * ccm[G]) / 255) * 255;
            pixel_bl[B] = sqrtf((pixel_bl[B] * ccm[B]) / 255) * 255;

            output_image[ISP_OUT_DIM(x,y,R)] = pixel_bl[R] > 255 ?
                255 : pixel_bl[R];
            output_image[ISP_OUT_DIM(x,y,G)] = pixel_bl[G] > 255 ?
                255 : pixel_bl[G];
            output_image[ISP_OUT_DIM(x,y,B)] = pixel_bl[B] > 255 ?
                255 : pixel_bl[B];

            // bottom-right
            x = i+1; y = j+1;
            pixel_br[R] = input_image[ISP_IN_DIM(x,y)];
            pixel_br[G] = (input_image[ISP_IN_DIM(x-1,y)] +
                    input_image[ISP_IN_DIM(x,y-1)] +
                    input_image[ISP_IN_DIM(x+1,y)] +
                    input_image[ISP_IN_DIM(x,y+1)]) >> 2;
            pixel_br[B] = (input_image[ISP_IN_DIM(x-1,y-1)] +
                    input_image[ISP_IN_DIM(x-1,y+1)] +
                    input_image[ISP_IN_DIM(x+1,y-1)] +
                    input_image[ISP_IN_DIM(x+1,y+1)]) >> 2;

            pixel_br[R] = sqrtf((pixel_br[R] * ccm[R]) / 255) * 255;
            pixel_br[G] = sqrtf((pixel_br[G] * ccm[G]) / 255) * 255;
            pixel_br[B] = sqrtf((pixel_br[B] * ccm[B]) / 255) * 255;

            output_image[ISP_OUT_DIM(x,y,R)] = pixel_br[R] > 255 ?
                255 : pixel_br[R];
            output_image[ISP_OUT_DIM(x,y,G)] = pixel_br[G] > 255 ?
                255 : pixel_br[G];
            output_image[ISP_OUT_DIM(x,y,B)] = pixel_br[B] > 255 ?
                255 : pixel_br[B];
        }
    }
}
