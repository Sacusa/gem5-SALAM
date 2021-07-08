#include <stdio.h>

#include "../defines.h"

extern volatile int acc_finished;

void isr(void) {
        printf("Interrupt\n");
        acc_finished = 1;
    *((uint8_t*) CANNY_NON_MAX_MMR) = 0;
}
