#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../common/m5ops.h"
#include "../defines.h"

volatile int acc_finished;

void canny_non_max_driver(uint32_t img_height, uint32_t img_width,
        uint32_t hypo_addr, uint32_t theta_addr, uint32_t result_addr) {
    uint32_t data_size = img_height * img_width * 4;

    // DMA flags
        volatile uint8_t  * DmaFlags   = (uint8_t  *)(DMA);
        volatile uint64_t * DmaRdAddr  = (uint64_t *)(DMA+1);
        volatile uint64_t * DmaWrAddr  = (uint64_t *)(DMA+9);
        volatile uint32_t * DmaCopyLen = (uint32_t *)(DMA+17);

    // DMA transfer for hypotenuse
        *DmaRdAddr  = hypo_addr;
        *DmaWrAddr  = HYPO_SPAD;
        *DmaCopyLen = data_size;
        *DmaFlags   = DEV_INIT;
        while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // DMA transfer for theta
        *DmaRdAddr  = theta_addr;
        *DmaWrAddr  = THETA_SPAD;
        *DmaCopyLen = data_size;
        *DmaFlags   = DEV_INIT;
        while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // Configure the accelerator
    volatile uint8_t  * CNMFlags     = (uint8_t *)  (CANNY_NON_MAX_MMR);
    volatile uint32_t * CNMImgHeight = (uint32_t *) (CANNY_NON_MAX_MMR + 1);
    volatile uint32_t * CNMImgWidth  = (uint32_t *) (CANNY_NON_MAX_MMR + 9);

    *CNMImgHeight = img_height;
    *CNMImgWidth  = img_width;

    // Start the accelerator
    printf("Starting accelerator\n");
    acc_finished = 0;
    *CNMFlags = DEV_INIT;
    while (!acc_finished) {}
    printf("Accelerator finished\n");

    // DMA transfer for result
        *DmaRdAddr  = RESULT_SPAD;
        *DmaWrAddr  = result_addr;
        *DmaCopyLen = data_size;
        *DmaFlags   = DEV_INIT;
        while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    return;
}
