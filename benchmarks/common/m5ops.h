#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef __M5_OPS__
#define __M5_OPS__

#define ENABLED 1
#if defined(__arm__)
static void m5_checkpoint(void)
{
    __asm__ ("push {r0-r3}");
    __asm__ ("mov r0, #0; mov r1, #0; mov r2, #0; mov r3, #0;"
             ".inst 0xEE000110 | (0x43 << 16);");
    __asm__ ("pop {r0-r3}");
};
static void m5_dump_stats(void)
{
    __asm__ ("push {r0-r3}");
    __asm__ ("mov r0, #0; mov r1, #0; mov r2, #0; mov r3, #0;"
             ".inst 0xEE000110 | (0x41 << 16);");
    __asm__ ("pop {r0-r3}");
};
static void m5_exit()
{
    __asm__ ("mov r0, #0; mov r1, #0; .inst 0xEE000110 | (0x21 << 16);");
};
static void m5_fail_1(void)
{
    __asm__ ("mov r0, #0; mov r1, #0; mov r2, #1; mov r3, #0;"
             ".inst 0xEE000110 | (0x22 << 16);");
};
static void m5_reset_stats(void)
{
    __asm__ ("push {r0-r3}");
    __asm__ ("mov r0, #0; mov r1, #0; mov r2, #0; mov r3, #0;"
             ".inst 0xEE000110 | (0x40 << 16);");
    __asm__ ("pop {r0-r3}");
};
static void m5_timer_start(uint8_t timer_id)
{
    switch (timer_id) {
        case 0:  __asm__ (".inst 0xEE000110 | (0x56 << 16)"); break;
        case 1:  __asm__ (".inst 0xEE001110 | (0x56 << 16)"); break;
        case 2:  __asm__ (".inst 0xEE002110 | (0x56 << 16)"); break;
        case 3:  __asm__ (".inst 0xEE003110 | (0x56 << 16)"); break;
        case 4:  __asm__ (".inst 0xEE004110 | (0x56 << 16)"); break;
        case 5:  __asm__ (".inst 0xEE005110 | (0x56 << 16)"); break;
        case 6:  __asm__ (".inst 0xEE006110 | (0x56 << 16)"); break;
        case 7:  __asm__ (".inst 0xEE007110 | (0x56 << 16)"); break;
        case 8:  __asm__ (".inst 0xEE008110 | (0x56 << 16)"); break;
        case 9:  __asm__ (".inst 0xEE009110 | (0x56 << 16)"); break;
        case 10: __asm__ (".inst 0xEE00A110 | (0x56 << 16)"); break;
        case 11: __asm__ (".inst 0xEE00B110 | (0x56 << 16)"); break;
        case 12: __asm__ (".inst 0xEE00C110 | (0x56 << 16)"); break;
        case 13: __asm__ (".inst 0xEE00D110 | (0x56 << 16)"); break;
        case 14: __asm__ (".inst 0xEE00E110 | (0x56 << 16)"); break;
        case 15: __asm__ (".inst 0xEE00F110 | (0x56 << 16)"); break;
    }
}
static void m5_timer_stop(uint8_t timer_id)
{
    switch (timer_id) {
        case 0:  __asm__ (".inst 0xEE000110 | (0x57 << 16)"); break;
        case 1:  __asm__ (".inst 0xEE001110 | (0x57 << 16)"); break;
        case 2:  __asm__ (".inst 0xEE002110 | (0x57 << 16)"); break;
        case 3:  __asm__ (".inst 0xEE003110 | (0x57 << 16)"); break;
        case 4:  __asm__ (".inst 0xEE004110 | (0x57 << 16)"); break;
        case 5:  __asm__ (".inst 0xEE005110 | (0x57 << 16)"); break;
        case 6:  __asm__ (".inst 0xEE006110 | (0x57 << 16)"); break;
        case 7:  __asm__ (".inst 0xEE007110 | (0x57 << 16)"); break;
        case 8:  __asm__ (".inst 0xEE008110 | (0x57 << 16)"); break;
        case 9:  __asm__ (".inst 0xEE009110 | (0x57 << 16)"); break;
        case 10: __asm__ (".inst 0xEE00A110 | (0x57 << 16)"); break;
        case 11: __asm__ (".inst 0xEE00B110 | (0x57 << 16)"); break;
        case 12: __asm__ (".inst 0xEE00C110 | (0x57 << 16)"); break;
        case 13: __asm__ (".inst 0xEE00D110 | (0x57 << 16)"); break;
        case 14: __asm__ (".inst 0xEE00E110 | (0x57 << 16)"); break;
        case 15: __asm__ (".inst 0xEE00F110 | (0x57 << 16)"); break;
    }
}
#elif defined(__aarch64__)
static void m5_checkpoint(void)
{
	__asm__ ("mov x0, #0; mov x1, #0; .inst 0xFF000110 | (0x43 << 16);");
};
static void m5_dump_stats(void)
{
	__asm__ ("mov x0, #0; mov x1, #0; .inst 0xFF000110 | (0x41 << 16);");
};
static void m5_exit(void)
{
	__asm__ ("mov x0, #0; .inst 0XFF000110 | (0x21 << 16);");
};
static void m5_fail_1(void)
{
	__asm__ ("mov x0, #0; mov x1, #1; .inst 0xFF000110 | (0x22 << 16);");
};
static void m5_reset_stats(void)
{
	__asm__ ("mov x0, #0; mov x1, #0; .inst 0XFF000110 | (0x40 << 16);");
};
#else
#undef ENABLED
#define ENABLED 0
#endif

#endif
