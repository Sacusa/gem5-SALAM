#include "hw_defines.h"

void top(uint64_t num_elems, uint64_t input_addr, uint64_t output_addr) {
    num_elems = ROW * COL;
    input_addr = 0x80c00000;
    output_addr = input_addr + num_elems;

    // DMA flags
        volatile uint8_t  * DmaFlags   = (uint8_t  *)(DMA);
        volatile uint64_t * DmaRdAddr  = (uint64_t *)(DMA+1);
        volatile uint64_t * DmaWrAddr  = (uint64_t *)(DMA+9);
        volatile uint32_t * DmaCopyLen = (uint32_t *)(DMA+17);

    // Start DMA transfer for input and wait for it
        *DmaRdAddr  = input_addr;
        *DmaWrAddr  = INPUT_SPAD;
        *DmaCopyLen = num_elems;
        *DmaFlags   = DEV_INIT;
        while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // Configure the accelerator
    volatile uint8_t  * GrayscaleFlags    = (uint8_t *)  (GRAYSCALE_MMR);
    volatile uint32_t * GrayscaleNumElems = (uint32_t *) (GRAYSCALE_MMR + 1);

    *GrayscaleNumElems = num_elems;

    // Start the accelerated function and poll for it to finish
    *GrayscaleFlags = DEV_INIT;
    while ((*GrayscaleFlags & DEV_INTR) != DEV_INTR);

    // Start DMA transfer for output and wait for it
        *DmaRdAddr  = OUTPUT_SPAD;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = num_elems * 4;
        *DmaFlags   = DEV_INIT;
        while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    return;
}
