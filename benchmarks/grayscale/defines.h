#ifndef __DEFINES_H__
#define __DEFINES_H__

#define CHECK

#define ROW 128
#define COL 128

void grayscale_driver(uint32_t, uint32_t, uint32_t);

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// CommInterface addresses
#define GRAYSCALE_BASE_ADDR 0x25000000
#define GRAYSCALE_DMA       GRAYSCALE_BASE_ADDR // 21 bytes

// Accelerator addresses
#define INPUT_SPM       0x25000020  // 48 KB
#define OUTPUT_SPM      0x2500c020  // 64 KB
#define GRAYSCALE_MMR   0x2501c020  // 9 bytes

#endif
