#ifndef __DEFINES_H__
#define __DEFINES_H__

#define ROW 64
#define COL 64

// Driver function
void driver(uint32_t, uint32_t, uint32_t, uint32_t, uint32_t);

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

// Device addresses
#define ADD_MMR 0x21000000
#define SQR_MMR 0x22000000

#endif
