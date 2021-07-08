#include <stdio.h>

#include "../defines.h"

extern volatile int acc_finished;

void isr(void) {
        printf("Interrupt\n");
        acc_finished = 1;
    *((uint8_t*) ELEM_MATRIX_MMR) = 0;
}
