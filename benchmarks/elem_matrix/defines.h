#ifndef __DEFINES_H__
#define __DEFINES_H__

#define ROW 128
#define COL 128
#define PI  3.141592653589793238462643

enum operation {
    ADD = 0, SUB,
    MUL, DIV,
    SQR, SQRT,
    ATAN2, TANH,
    SIGMOID,
    NUM_OPS
};

// Driver function
void elem_matrix_driver(uint32_t, uint32_t, uint32_t, uint32_t, uint8_t,
        uint8_t, uint8_t);

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// Memory mapped I/O
#define EM_BASE_ADDR        0x24000000
#define ELEM_MATRIX_DMA     EM_BASE_ADDR    // 21 B
#define ARG1_SPM            0x24000020      // 64 KB
#define ARG2_SPM            0x24010020      // 64 KB
#define RESULT_SPM          0x24020020      // 64 KB
#define ELEM_MATRIX_MMR     0x24030020

#endif
