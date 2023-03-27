#ifndef __M5_OPS__
#define __M5_OPS__

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#if defined(__arm__)
void m5_checkpoint(void);
void m5_dump_stats(void);
void m5_exit();
void m5_fail_1(void);
void m5_reset_stats(void);
void m5_quiesce(void);
void m5_timer_start(uint8_t);
void m5_timer_stop(uint8_t);
uint32_t __attribute__((optimize("-O0"))) m5_get_time();
void __attribute__((optimize("-O0"))) m5_print_stat(uint32_t, uint32_t);
#elif defined(__aarch64__)
void m5_checkpoint(void);
void m5_dump_stats(void);
void m5_exit(void);
void m5_fail_1(void);
void m5_reset_stats(void);
#else
#endif

#endif
