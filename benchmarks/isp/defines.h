#ifndef __DEFINES_H__
#define __DEFINES_H__

// Function declarations
void isp_driver(uint32_t, uint32_t, uint32_t, uint32_t);

// Function specific definitions
#define ROW 128
#define COL 128
#define ISP_IN_DIM(x,y)    (img_width + 3 + ((x)*(2+img_width)) + (y))
#define ISP_OUT_DIM(x,y,c) (3*((x)*COL + (y)) + (c))

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// MMR addresses
#define ISP_BASE_ADDR   0x27000000
#define ISP_DMA         ISP_BASE_ADDR   // 21 B
#define INPUT_SPM       0x27000020      // 16900 B
#define OUTPUT_SPM      0x27004224      // 48 KB
#define ISP_MMR         0x27010230      // 17 B

#endif
