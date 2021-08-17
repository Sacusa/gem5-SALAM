#ifndef __DEFINES_H__
#define __DEFINES_H__

// Function declarations
void edge_tracking_driver(uint32_t, uint32_t, uint32_t, uint32_t, float,
        float);

// Function specific definitions
#define ROW 128
#define COL 128
#define DIM(x,y) (((x)*COL) + (y))

#define WEAK       75
#define STRONG     255

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// MMR addresses
#define EDGE_TRACKING_BASE_ADDR 0x23000000
#define EDGE_TRACKING_DMA       EDGE_TRACKING_BASE_ADDR // 21 B
#define INPUT_SPM               0x23000020              // 64 KB
#define OUTPUT_SPM              0x23010020              // 16 KB
#define LOCAL_MAXIMA_SPM        0x23014020              // 128 B
#define EDGE_TRACKING_MMR       0x230140a0              // 9 B

#endif
