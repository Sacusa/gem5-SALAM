#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

volatile int acc_finished;

void grayscale_driver(uint32_t num_elems, uint32_t input_addr,
        uint32_t output_addr) {
    // DMA flags
    volatile uint8_t  * DmaFlags   = (uint8_t  *)(GRAYSCALE_DMA);
    volatile uint64_t * DmaRdAddr  = (uint64_t *)(GRAYSCALE_DMA + 1);
    volatile uint64_t * DmaWrAddr  = (uint64_t *)(GRAYSCALE_DMA + 9);
    volatile uint32_t * DmaCopyLen = (uint32_t *)(GRAYSCALE_DMA + 17);

    // DMA transfer for input data
    *DmaRdAddr  = input_addr;
    *DmaWrAddr  = INPUT_SPM;
    *DmaCopyLen = num_elems * 3;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

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

    // DMA transfer for output data
    *DmaRdAddr  = OUTPUT_SPM;
    *DmaWrAddr  = output_addr;
    *DmaCopyLen = num_elems * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    return;
}
