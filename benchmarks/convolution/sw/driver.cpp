#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../defines.h"

volatile int acc_finished;

void driver(uint32_t input_addr, uint32_t output_addr, uint32_t kernel_addr,
            uint32_t img_height, uint32_t img_width, uint32_t kern_height,
            uint32_t kern_width, uint8_t mod_and_floor) {
    // DMA flags
    volatile uint8_t  * DmaFlags   = (uint8_t  *)(CONVOLUTION_DMA);
    volatile uint64_t * DmaRdAddr  = (uint64_t *)(CONVOLUTION_DMA+1);
    volatile uint64_t * DmaWrAddr  = (uint64_t *)(CONVOLUTION_DMA+9);
    volatile uint32_t * DmaCopyLen = (uint32_t *)(CONVOLUTION_DMA+17);

    // DMA transfer for input data
    *DmaRdAddr  = input_addr;
    *DmaWrAddr  = INPUT_SPM;
    *DmaCopyLen = img_height * img_width * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // DMA transfer for kernel
    *DmaRdAddr  = kernel_addr;
    *DmaWrAddr  = KERNEL_SPM;
    *DmaCopyLen = kern_height * kern_width * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // Configure the accelerator
    volatile uint8_t  *ConvolutionFlags      = (uint8_t *)  (CONVOLUTION_MMR);
    volatile uint32_t *ConvolutionImgHeight  = (uint32_t *)
        (CONVOLUTION_MMR + 1);
    volatile uint32_t *ConvolutionImgWidth   = (uint32_t *)
        (CONVOLUTION_MMR + 9);
    volatile uint32_t *ConvolutionKernHeight = (uint32_t *)
        (CONVOLUTION_MMR + 17);
    volatile uint32_t *ConvolutionKernWidth  = (uint32_t *)
        (CONVOLUTION_MMR + 25);
    volatile uint8_t  *ConvolutionModFloor   = (uint8_t *)
        (CONVOLUTION_MMR + 33);

    *ConvolutionImgHeight = img_height;
    *ConvolutionImgWidth = img_width;
    *ConvolutionKernHeight = kern_height;
    *ConvolutionKernWidth = kern_width;
    *ConvolutionModFloor = mod_and_floor;

    // Start the accelerator
    printf("Starting accelerator\n");
    acc_finished = 0;
    *ConvolutionFlags = DEV_INIT;
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
