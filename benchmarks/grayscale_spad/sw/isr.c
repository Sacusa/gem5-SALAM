#include <stdio.h>

extern volatile int acc_finished;
extern volatile uint8_t * top;

void isr(void) {
        printf("Interrupt\n");
        acc_finished = 1;
        *top = 0x00;
}
