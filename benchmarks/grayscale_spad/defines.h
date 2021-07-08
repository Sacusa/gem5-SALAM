#ifndef __DEFINES_H__
#define __DEFINES_H__

#define CHECK

#define ROW 64
#define COL 64

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

#define STR_DMA_INIT_RD     0x01
#define STR_DMA_INIT_WR     0x02
#define STR_DMA_RD_RUNNING  0x04
#define STR_DMA_WR_RUNNING  0x06

// Specify row/column sizes
#define row_size    ROW
#define col_size    COL
#define mat_size    row_size*col_size*sizeof(TYPE)

// CommInterface addresses
#define GRAYSCALE_BASE_ADDR 0x20100000
#define TOP_MMR             GRAYSCALE_BASE_ADDR // 25 bytes
#define DMA                 0x20100020          // 32 bytes

// Accelerator addresses
#define GRAYSCALE_MMR   0x20101000  // 9 bytes
#define INPUT_SPAD      0x20101010  // 4096 bytes
#define OUTPUT_SPAD     0x20102010  // 16384 bytes

#endif
