#ifdef __BENCH_H__
#define __BENCH_H__
#include "../defines.h"

// MMRs for CommInterface
volatile uint8_t  * top            = (uint8_t  *)0x2f000000;
volatile uint32_t * num_elems      = (uint32_t *)0x2f000001;
volatile uint64_t * arg1_addr      = (uint64_t *)0x2f000005;
volatile uint64_t * arg2_addr      = (uint64_t *)0x2f00000d;
volatile uint64_t * result_addr    = (uint64_t *)0x2f000015;
volatile uint8_t  * op             = (uint8_t  *)0x2f00001d;
volatile uint8_t  * is_arg2_scalar = (uint8_t  *)0x2f00001e;
volatile uint8_t  * do_one_minus   = (uint8_t  *)0x2f00001f;

volatile int acc_finished;

#define
