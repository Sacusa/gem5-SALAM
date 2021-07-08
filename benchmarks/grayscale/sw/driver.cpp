#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

volatile int acc_finished;

void grayscale_driver(uint32_t num_elems, uint64_t input_addr,
        uint64_t output_addr) {
    // DMA stream for data
    volatile uint8_t  * StreamFlags           = (uint8_t  *)(STREAM_MMR);
    volatile uint64_t * StreamRdAddr          = (uint64_t *)(STREAM_MMR+4);
    volatile uint64_t * StreamWrAddr          = (uint64_t *)(STREAM_MMR+12);
    volatile uint32_t * StreamRdFrameSize     = (uint32_t *)(STREAM_MMR+20);
    volatile uint8_t  * StreamNumRdFrames     = (uint8_t  *)(STREAM_MMR+24);
    volatile uint8_t  * StreamRdFrameBuffSize = (uint8_t  *)(STREAM_MMR+25);
    volatile uint32_t * StreamWrFrameSize     = (uint32_t *)(STREAM_MMR+26);
    volatile uint8_t  * StreamNumWrFrames     = (uint8_t  *)(STREAM_MMR+30);
    volatile uint8_t  * StreamWrFrameBuffSize = (uint8_t  *)(STREAM_MMR+31);

        *StreamRdAddr = input_addr;
        *StreamRdFrameSize = num_elems * 3;
        *StreamNumRdFrames = 1;
        *StreamRdFrameBuffSize = 1;

    *StreamWrAddr = output_addr;
    *StreamWrFrameSize = num_elems * 4;
    *StreamNumWrFrames = 1;
    *StreamWrFrameBuffSize = 1;

        *StreamFlags = STR_DMA_INIT_RD | STR_DMA_INIT_WR;

    // Configure the accelerator
    volatile uint8_t  * GrayscaleFlags    = (uint8_t *)  (GRAYSCALE_MMR);
    volatile uint32_t * GrayscaleNumElems = (uint32_t *) (GRAYSCALE_MMR + 1);

    *GrayscaleNumElems = num_elems;

    // Start the accelerator
    printf("Starting accelerator\n");
    acc_finished = 0;
    *GrayscaleFlags = DEV_INIT;
    while (!acc_finished);
    printf("Accelerator finished\n");

    // Wait for output stream to finish
    while ((*StreamFlags & STR_DMA_WR_RUNNING) == STR_DMA_WR_RUNNING);
    *StreamFlags = 0;

    return;
}
