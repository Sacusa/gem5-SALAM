#include <stdio.h>

#include "../defines.h"

extern volatile int acc_finished;

void add_isr() {
    printf("ADD interrupt\n");
    *((uint8_t*) ADD_MMR) = 0;
}

void sqr_isr(void) {
    printf("SQR interrupt\n");
    acc_finished = 1;
    *((uint8_t*) SQR_MMR) = 0;
}
