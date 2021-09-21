#ifndef __DEFINES_H__
#define __DEFINES_H__

#define ROW 64
#define COL 64

// Driver function
void driver(uint32_t, uint32_t, uint32_t, uint32_t);

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// Device addresses
#define ADD_BASE_ADDR   0x21000000
#define DMA             ADD_BASE_ADDR   // 21 B
#define ADD_ARG1_SPM    0x21000020      // 64 KB
#define ADD_ARG2_SPM    0x21010020      // 64 KB
#define ADD_RESULT_SPM  0x21020020      // 64 KB
#define ADD_MMR         0x21030020

#define SQR_BASE_ADDR   0x22000000
#define SQR_INPUT_SPM   SQR_BASE_ADDR   // 64 KB
#define SQR_RESULT_SPM  0x22010000      // 64 KB
#define SQR_MMR         0x22020000

#endif
