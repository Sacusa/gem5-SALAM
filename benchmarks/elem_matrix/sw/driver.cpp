#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../defines.h"

volatile int acc_finished;

void elem_matrix_driver(uint32_t num_elems, uint32_t arg1_addr,
        uint32_t arg2_addr, uint32_t result_addr, uint8_t op,
        uint8_t is_arg2_scalar, uint8_t do_one_minus) {
    // DMA stream for arg1 and result
    volatile uint8_t  * Arg1ResultStrFlags            = (uint8_t  *)
        (ARG1_RESULT_STR_MMR);
    volatile uint64_t * Arg1ResultStrRdAddr           = (uint64_t *)
        (ARG1_RESULT_STR_MMR + 4);
    volatile uint64_t * Arg1ResultStrWrAddr           = (uint64_t *)
        (ARG1_RESULT_STR_MMR + 12);
    volatile uint32_t * Arg1ResultStrRdFrameSize      = (uint32_t *)
        (ARG1_RESULT_STR_MMR + 20);
    volatile uint8_t  * Arg1ResultStrNumRdFrames      = (uint8_t  *)
        (ARG1_RESULT_STR_MMR + 24);
    volatile uint8_t  * Arg1ResultStrRdFrameBuffSize  = (uint8_t  *)
        (ARG1_RESULT_STR_MMR + 25);
    volatile uint32_t * Arg1ResultStrWrFrameSize      = (uint32_t *)
        (ARG1_RESULT_STR_MMR + 26);
    volatile uint8_t  * Arg1ResultStrNumWrFrames      = (uint8_t  *)
        (ARG1_RESULT_STR_MMR + 30);
    volatile uint8_t  * Arg1ResultStrWrFrameBuffSize  = (uint8_t  *)
        (ARG1_RESULT_STR_MMR + 31);

    *Arg1ResultStrRdAddr = arg1_addr;
    *Arg1ResultStrRdFrameSize = num_elems * 4;
    *Arg1ResultStrNumRdFrames = 1;
    *Arg1ResultStrRdFrameBuffSize = 1;

    *Arg1ResultStrWrAddr = result_addr;
    *Arg1ResultStrWrFrameSize = num_elems * 4;
    *Arg1ResultStrNumWrFrames = 1;
    *Arg1ResultStrWrFrameBuffSize = 1;

    *Arg1ResultStrFlags = STR_DMA_INIT_RD | STR_DMA_INIT_WR;

    // DMA stream for arg2
    volatile uint8_t  * Arg2StrFlags           = (uint8_t  *)(ARG2_STR_MMR);
    volatile uint64_t * Arg2StrRdAddr          = (uint64_t *)
        (ARG2_STR_MMR + 4);
    volatile uint64_t * Arg2StrWrAddr          = (uint64_t *)
        (ARG2_STR_MMR + 12);
    volatile uint32_t * Arg2StrRdFrameSize     = (uint32_t *)
        (ARG2_STR_MMR + 20);
    volatile uint8_t  * Arg2StrNumRdFrames     = (uint8_t  *)
        (ARG2_STR_MMR + 24);
    volatile uint8_t  * Arg2StrRdFrameBuffSize = (uint8_t  *)
        (ARG2_STR_MMR + 25);
    volatile uint32_t * Arg2StrWrFrameSize     = (uint32_t *)
        (ARG2_STR_MMR + 26);
    volatile uint8_t  * Arg2StrNumWrFrames     = (uint8_t  *)
        (ARG2_STR_MMR + 30);
    volatile uint8_t  * Arg2StrWrFrameBuffSize = (uint8_t  *)
        (ARG2_STR_MMR + 31);

    switch (op) {
        case ADD:
        case SUB:
        case MUL:
        case DIV:
        case ATAN2: {
            *Arg2StrRdAddr = arg2_addr;
            if (is_arg2_scalar) {
                *Arg2StrRdFrameSize = 4;
            } else {
                *Arg2StrRdFrameSize = num_elems * 4;
            }
            *Arg2StrNumRdFrames = 1;
            *Arg2StrRdFrameBuffSize = 1;
            *Arg2StrFlags = STR_DMA_INIT_RD;
        }
    }

    // Configure the accelerator
    volatile uint8_t  * EMFlags      = (uint8_t *) (ELEM_MATRIX_MMR);
    volatile uint64_t * EMNumElems   = (uint64_t *) (ELEM_MATRIX_MMR + 1);
    volatile uint64_t * EMOp         = (uint64_t *) (ELEM_MATRIX_MMR + 9);
    volatile uint64_t * EMArg2Scalar = (uint64_t *) (ELEM_MATRIX_MMR + 17);
    volatile uint64_t * EMOneMinus   = (uint64_t *) (ELEM_MATRIX_MMR + 25);

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

    // Wait for output stream to finish
    while ((*Arg1ResultStrFlags & STR_DMA_WR_RUNNING) == STR_DMA_WR_RUNNING);
    *Arg1ResultStrFlags = 0;
    *Arg2StrFlags = 0;

    return;
}
