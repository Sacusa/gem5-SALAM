#ifndef __DEFINES_H__
#define __DEFINES_H__

//#define DEBUG

// Function declarations
void driver(uint32_t, uint32_t, uint32_t, uint32_t, uint32_t, uint32_t,
        uint32_t, uint8_t);

// Function specific definitions
#define ROW 64
#define COL 64
#define KERN_ROW 5
#define KERN_COL 5
#define DIM(x,y) (((x)*COL) + (y))
#define KERN_DIM(x,y) (((x)*kern_width) + (y))

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

#define STR_DMA_INIT_RD     0x01
#define STR_DMA_INIT_WR     0x02
#define STR_DMA_RD_RUNNING  0x04
#define STR_DMA_WR_RUNNING  0x06

// MMR addresses
#define CONVOLUTION_BASE_ADDR   0x20100000
#define CONVOLUTION_DMA         CONVOLUTION_BASE_ADDR   // 21 B
#define INPUT_SPM               0x20100020              // 64 KB
#define OUTPUT_SPM              0x20110020              // 64 KB
#define KERNEL_SPM              0x20120020              // 100 B
#define CONVOLUTION_MMR         0x201200a0              // 41 B

#endif
