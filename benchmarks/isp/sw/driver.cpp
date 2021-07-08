#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../defines.h"

volatile int acc_finished;

void isp_driver(uint32_t input_addr, uint32_t output_addr, uint32_t img_height,
                uint32_t img_width) {
    // DMA flags
    volatile uint8_t  * DmaFlags   = (uint8_t  *)(ISP_DMA);
    volatile uint64_t * DmaRdAddr  = (uint64_t *)(ISP_DMA+1);
    volatile uint64_t * DmaWrAddr  = (uint64_t *)(ISP_DMA+9);
    volatile uint32_t * DmaCopyLen = (uint32_t *)(ISP_DMA+17);

    // DMA transfer for input data
    *DmaRdAddr  = input_addr;
    *DmaWrAddr  = INPUT_SPM;
    *DmaCopyLen = (img_height + 2) * (img_width + 2);
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // Configure the accelerator
    volatile uint8_t  * IspFlags      = (uint8_t *)  (ISP_MMR);
    volatile uint32_t * IspImgHeight  = (uint32_t *) (ISP_MMR + 1);
    volatile uint32_t * IspImgWidth   = (uint32_t *) (ISP_MMR + 9);

    *IspImgHeight = img_height;
    *IspImgWidth = img_width;

    // Start the accelerator
    printf("Starting accelerator\n");
    acc_finished = 0;
    *IspFlags = DEV_INIT;
    while (!acc_finished) {}
    printf("Accelerator finished\n");

    // DMA transfer for output data
    *DmaRdAddr  = OUTPUT_SPM;
    *DmaWrAddr  = output_addr;
    *DmaCopyLen = img_height * img_width * 3;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    return;
}
