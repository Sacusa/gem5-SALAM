#ifndef __DEFINES_H__
#define __DEFINES_H__

// Function declarations
void edge_tracking_driver(uint32_t, uint32_t, uint32_t, uint32_t, float,
        float);

// Function specific definitions
#define ROW 64
#define COL 64
#define DIM(x,y) (((x)*COL) + (y))

#define WEAK       75
#define STRONG     255
#define MAX_LOOP_UNFOLD 16

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// MMR addresses
#define EDGE_TRACKING_BASE_ADDR 0x20200000
#define EDGE_TRACKING_DMA       EDGE_TRACKING_BASE_ADDR // 21 B
#define INPUT_SPM               0x20200020              // 64 KB
#define OUTPUT_SPM              0x20210020              // 16 KB
#define EDGE_TRACKING_MMR       0x20214020              // 9 B

#endif
