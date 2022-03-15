#include <stdint.h>
#include <stdio.h>

#include "../defines.h"

static uint32_t curr_address = 0x82000000;

void *get_memory_aligned(uint32_t num_bytes, uint32_t align)
{
    // align the address
    if ((curr_address % align) != 0) {
        curr_address += align - (curr_address % align);
    }

    // align the number of bytes
    // this is necessary to ensure that, for instance, future allocations
    // don't share the cacheline with CACHELINE_SIZE aligned allocations prior
    if ((num_bytes % align) != 0) {
        num_bytes += align - (num_bytes % align);
    }

    void *retval = (void*) curr_address;
    curr_address += num_bytes;

    return retval;
}

void *get_memory(uint32_t num_bytes)
{
    return get_memory_aligned(num_bytes, 8);
}
