#ifndef __DEFINES_H__
#define __DEFINES_H__

//#define VERBOSE

#define ROW 64
#define COL 64

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

#define STR_DMA_INIT_RD     0x01
#define STR_DMA_INIT_WR     0x02
#define STR_DMA_RD_RUNNING  0x04
#define STR_DMA_WR_RUNNING  0x06

// CommInterface addresses
#define EM_BASE_ADDR        0x20300000
#define ARG1_RESULT_STR_MMR EM_BASE_ADDR    // 32 bytes
#define ARG1_STR            0x20300020      // 32 bytes
#define ARG2_STR_MMR        0x20300040      // 32 bytes
#define ARG2_STR            0x20300060      // 32 bytes
#define RESULT_STR          ARG1_STR

// Accelerator addresses
#define ELEM_MATRIX_MMR     0x20300080  // 33 bytes

#endif
