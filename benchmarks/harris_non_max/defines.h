#ifndef __DEFINES_H__
#define __DEFINES_H__

// Function declarations
void harris_non_max_driver(uint32_t, uint32_t, uint32_t, uint32_t);

// Function specific definitions
#define ROW 64
#define COL 64
#define DIM(x,y) (((x)*COL) + (y))

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// MMR addresses
#define HNM_BASE_ADDR   0x26000000
#define HNM_DMA         HNM_BASE_ADDR   // 21 B
#define INPUT_SPM       0x26000020      // 128 KB
#define OUTPUT_SPM      0x26020020      // 128 KB
#define HNM_MMR         0x26040020      // 41 B

#endif
