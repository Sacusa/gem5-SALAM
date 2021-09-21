#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../defines.h"

volatile int acc_finished;

void driver(uint32_t num_elems, uint32_t arg1_addr, uint32_t arg2_addr,
        uint32_t add_result_addr, uint32_t sqr_result_addr) {
    // Configure the accelerators
    volatile uint8_t  *AddFlags      = (uint8_t *) (ADD_MMR);
    volatile uint32_t *AddNumElems   = (uint32_t*) (ADD_MMR + 1);
    volatile uint32_t *AddArg1Addr   = (uint32_t*) (ADD_MMR + 9);
    volatile uint32_t *AddArg2Addr   = (uint32_t*) (ADD_MMR + 17);
    volatile uint32_t *AddResultAddr = (uint32_t*) (ADD_MMR + 25);

    volatile uint8_t  *SqrFlags      = (uint8_t *) (SQR_MMR);
    volatile uint32_t *SqrNumElems   = (uint32_t*) (SQR_MMR + 1);
    volatile uint32_t *SqrInputAddr  = (uint32_t*) (SQR_MMR + 9);
    volatile uint32_t *SqrResultAddr = (uint32_t*) (SQR_MMR + 17);

    *AddNumElems = num_elems;
    *AddArg1Addr = arg1_addr;
    *AddArg2Addr = arg2_addr;
    *AddResultAddr = add_result_addr;

    *SqrNumElems = num_elems;
    *SqrInputAddr = add_result_addr;
    *SqrResultAddr = sqr_result_addr;

    // Start the ADD accelerator
    printf("Starting ADD accelerator\n");
    acc_finished = 0;
    *AddFlags = DEV_INIT;
    while (!acc_finished);
    printf("ADD accelerator finished\n");

    // Start the SQR accelerator
    printf("Starting SQR accelerator\n");
    acc_finished = 0;
    *SqrFlags = DEV_INIT;
    while (!acc_finished);
    printf("SQR accelerator finished\n");

    return;
}
