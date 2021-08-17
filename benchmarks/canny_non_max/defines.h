#ifndef __DEFINES_H__
#define __DEFINES_H__

#define PI  3.141592653589793238462643
#define ROW 128
#define COL 128
#define DIM(x,y) (((x) * COL) + (y))
#define LOOP_UNROLL 32

void canny_non_max_driver(uint32_t, uint32_t, uint32_t, uint32_t, uint32_t);

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// CommInterface addresses
#define CNM_BASE_ADDR   0x21000000
#define DMA             CNM_BASE_ADDR   // 21 bytes

// Accelerator addresses
#define CANNY_NON_MAX_MMR   0x21000020              // 17 bytes
#define HYPO_SPAD           0x21000040              // 64 KB
#define THETA_SPAD          (HYPO_SPAD  + 65536)    // 64 KB
#define RESULT_SPAD         (THETA_SPAD + 65536)    // 64 KB

#endif
