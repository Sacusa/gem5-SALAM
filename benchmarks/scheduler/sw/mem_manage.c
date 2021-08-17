#include <stdint.h>
#include <stdio.h>

#include "../defines.h"

uint32_t curr_address = 0x81000000;

void *get_memory(uint32_t num_bytes)
{
    void *retval = (void*)curr_address;
    const uint32_t align = 64;
    uint32_t req_num_bytes = num_bytes;

    // allocations are made in multiples of 8-bytes for maximum compatibility
    num_bytes += ((num_bytes % align) == 0) ? 0 :
        (align - (num_bytes % align));
    curr_address += num_bytes;

    //printf("mem_manage: size=[%d], allocated=[%d], new_address=[%x]\n",
    //        req_num_bytes, num_bytes, curr_address);

    return retval;
}
