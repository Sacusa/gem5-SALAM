#ifndef __DEFINES_H__
#define __DEFINES_H__

#define ROW 64
#define COL 64

// Driver function
void driver(uint32_t, uint32_t, uint32_t, uint32_t);

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

#define STR_DMA_INIT_RD     0x01
#define STR_DMA_INIT_WR     0x02
#define STR_DMA_RD_RUNNING  0x04
#define STR_DMA_WR_RUNNING  0x06

// Device addresses
#define ADD_BASE_ADDR   0x21000000
#define DMA_MMR         ADD_BASE_ADDR   // 21 B
#define ADD_RESULT_STR  0x21000020      // 32 B
#define ADD_ARG1_SPM    0x21000040      // 64 KB
#define ADD_ARG2_SPM    0x21010040      // 64 KB
#define ADD_MMR         0x21020040

#define SQR_BASE_ADDR   0x22000000
#define SQR_INPUT_STR   ADD_RESULT_STR  // 0 B
#define SQR_RESULT_SPM  SQR_BASE_ADDR   // 64 KB
#define SQR_MMR         0x22010000

#endif
