#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../defines.h"

volatile int acc_finished;

void edge_tracking_driver(uint32_t input_addr, uint32_t output_addr,
        uint32_t img_height, uint32_t img_width, float thr_weak_ratio,
        float thr_strong_ratio) {
    // DMA flags
    volatile uint8_t  * DmaFlags   = (uint8_t  *)(EDGE_TRACKING_DMA);
    volatile uint64_t * DmaRdAddr  = (uint64_t *)(EDGE_TRACKING_DMA + 1);
    volatile uint64_t * DmaWrAddr  = (uint64_t *)(EDGE_TRACKING_DMA + 9);
    volatile uint32_t * DmaCopyLen = (uint32_t *)(EDGE_TRACKING_DMA + 17);

    // DMA transfer for input data
    *DmaRdAddr  = input_addr;
    *DmaWrAddr  = INPUT_SPM;
    *DmaCopyLen = img_height * img_width * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // Configure the accelerator
    volatile uint8_t  * EdgeTrackingFlags     = (uint8_t *)
        (EDGE_TRACKING_MMR);
    volatile uint32_t * EdgeTrackingImgHeight = (uint32_t *)
        (EDGE_TRACKING_MMR + 1);
    volatile uint32_t * EdgeTrackingImgWidth  = (uint32_t *)
        (EDGE_TRACKING_MMR + 9);
    volatile float    * EdgeTrackingWeak      = (float *)
        (EDGE_TRACKING_MMR + 17);
    volatile float    * EdgeTrackingStrong    = (float *)
        (EDGE_TRACKING_MMR + 25);

    *EdgeTrackingImgHeight = img_height;
    *EdgeTrackingImgWidth = img_width;
    *EdgeTrackingWeak = thr_weak_ratio;
    *EdgeTrackingStrong = thr_strong_ratio;

    // Start the accelerator
    printf("Starting accelerator\n");
    acc_finished = 0;
    *EdgeTrackingFlags = DEV_INIT;
    while (!acc_finished) {}
    printf("Accelerator finished\n");

    // DMA transfer for output data
    *DmaRdAddr  = OUTPUT_SPM;
    *DmaWrAddr  = output_addr;
    *DmaCopyLen = img_height * img_width * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    return;
}
