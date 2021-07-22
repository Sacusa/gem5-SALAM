#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../defines.h"

volatile int acc_finished;

void elem_matrix_driver(uint32_t num_elems, uint32_t arg1_addr,
        uint32_t arg2_addr, uint32_t result_addr, uint8_t op,
        uint8_t is_arg2_scalar, uint8_t do_one_minus) {
    // DMA flags
    volatile uint8_t  * DmaFlags   = (uint8_t  *)(ELEM_MATRIX_DMA);
    volatile uint64_t * DmaRdAddr  = (uint64_t *)(ELEM_MATRIX_DMA + 1);
    volatile uint64_t * DmaWrAddr  = (uint64_t *)(ELEM_MATRIX_DMA + 9);
    volatile uint32_t * DmaCopyLen = (uint32_t *)(ELEM_MATRIX_DMA + 17);

    // DMA transfer for arg1
    *DmaRdAddr  = arg1_addr;
    *DmaWrAddr  = ARG1_SPM;
    *DmaCopyLen = num_elems * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    // DMA transfer for arg2
    switch (op) {
        case ADD:
        case SUB:
        case MUL:
        case DIV:
        case ATAN2: {
            *DmaRdAddr  = arg2_addr;
            *DmaWrAddr  = ARG2_SPM;
            *DmaCopyLen = num_elems * 4;
            *DmaFlags   = DEV_INIT;
            while ((*DmaFlags & DEV_INTR) != DEV_INTR);
        }
    }

    // Configure the accelerator
    volatile uint8_t  *EMFlags      = (uint8_t *)  (ELEM_MATRIX_MMR);
    volatile uint64_t *EMNumElems   = (uint64_t *) (ELEM_MATRIX_MMR + 1);
    volatile uint64_t *EMOp         = (uint64_t *) (ELEM_MATRIX_MMR + 9);
    volatile uint64_t *EMArg2Scalar = (uint64_t *) (ELEM_MATRIX_MMR + 17);
    volatile uint64_t *EMOneMinus   = (uint64_t *) (ELEM_MATRIX_MMR + 25);

    *EMNumElems = num_elems;
    *EMOp = op;
    *EMArg2Scalar = is_arg2_scalar;
    *EMOneMinus = do_one_minus;

    // Start the accelerator
    printf("Starting accelerator\n");
    acc_finished = 0;
    *EMFlags = DEV_INIT;
    while (!acc_finished);
    printf("Accelerator finished\n");

    // DMA transfer for result
    *DmaRdAddr  = RESULT_SPM;
    *DmaWrAddr  = result_addr;
    *DmaCopyLen = num_elems * 4;
    *DmaFlags   = DEV_INIT;
    while ((*DmaFlags & DEV_INTR) != DEV_INTR);

    return;
}
