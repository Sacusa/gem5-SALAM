#ifndef __DEFINES_H__
#define __DEFINES_H__

#define ROW 64
#define COL 64

void grayscale_driver(uint32_t, uint64_t, uint64_t);

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

#define STR_DMA_INIT_RD     0x01
#define STR_DMA_INIT_WR     0x02
#define STR_DMA_RD_RUNNING  0x04
#define STR_DMA_WR_RUNNING  0x06

// CommInterface addresses
#define GRAYSCALE_BASE_ADDR 0x20400000
#define STREAM_MMR          GRAYSCALE_BASE_ADDR // 32 bytes
#define INPUT_STR           0x20400020          // 32 bytes
#define OUTPUT_STR          INPUT_STR

// Accelerator addresses
#define GRAYSCALE_MMR       0x20400040  // 9 bytes

#endif
