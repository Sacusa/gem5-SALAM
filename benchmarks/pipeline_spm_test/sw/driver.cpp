#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../defines.h"

volatile int acc_finished;

void driver(uint32_t num_elems, uint32_t arg1_addr, uint32_t arg2_addr,
        uint32_t result_addr) {
    // DMA flags
    volatile uint8_t  * DmaFlags   = (uint8_t  *)(DMA);
    volatile uint64_t * DmaRdAddr  = (uint64_t *)(DMA + 1);
    volatile uint64_t * DmaWrAddr  = (uint64_t *)(DMA + 9);
    volatile uint32_t * DmaCopyLen = (uint32_t *)(DMA + 17);

    // DMA transfer for arg1
    *DmaRdAddr  = arg1_addr;
    *DmaWrAddr  = ADD_ARG1_SPM;
    *DmaCopyLen = num_elems * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // DMA transfer for arg2
    *DmaRdAddr  = arg2_addr;
    *DmaWrAddr  = ADD_ARG2_SPM;
    *DmaCopyLen = num_elems * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // Configure the accelerators
    volatile uint8_t  *AddFlags    = (uint8_t *) (ADD_MMR);
    volatile uint32_t *AddNumElems = (uint32_t*) (ADD_MMR + 1);
    volatile uint8_t  *SqrFlags    = (uint8_t *) (SQR_MMR);
    volatile uint32_t *SqrNumElems = (uint32_t*) (SQR_MMR + 1);

    *AddNumElems = num_elems;
    *SqrNumElems = num_elems;

    // Start the ADD accelerator
    printf("Starting ADD accelerator\n");
    acc_finished = 0;
    *AddFlags = DEV_INIT;
    while (!acc_finished);
    printf("ADD accelerator finished\n");

    // DMA transfer from ADD result to SQR input
    *DmaRdAddr  = ADD_RESULT_SPM;
    *DmaWrAddr  = SQR_INPUT_SPM;
    *DmaCopyLen = num_elems * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // Start the SQR accelerator
    printf("Starting SQR accelerator\n");
    acc_finished = 0;
    *SqrFlags = DEV_INIT;
    while (!acc_finished);
    printf("SQR accelerator finished\n");

    // DMA transfer for result
    *DmaRdAddr  = SQR_RESULT_SPM;
    *DmaWrAddr  = result_addr;
    *DmaCopyLen = num_elems * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    return;
}
