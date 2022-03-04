#include <stdint.h>
#include <stdio.h>

#include "../defines.h"

static uint32_t curr_address = 0x85000000;

void *get_memory_aligned(uint32_t num_bytes, uint32_t align)
{
    // align the address
    if ((curr_address % align) != 0) {
        curr_address += align - (curr_address % align);
    }

    void *retval = (void*)curr_address;
    curr_address += num_bytes;

    return retval;
}

void *get_memory(uint32_t num_bytes)
{
    return get_memory_aligned(num_bytes, 8);
}
