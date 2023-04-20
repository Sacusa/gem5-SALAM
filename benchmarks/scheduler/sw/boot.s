/*
 * Copyright (c) 2015, University of Kaiserslautern
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Authors: Matthias Jung
 *          Frederik Lauer
 */

.section INTERRUPT_VECTOR, "x"
.global _Reset
_Reset:
    B Reset_Handler         /* Reset */
    B .                     /* Undefined */
    B .                     /* SWI */
    B .                     /* Prefetch Abort */
    B Data_Abort_Handler    /* Data Abort */
    B .                     /* reserved */
    B irq_handler           /* IRQ */
    B .                     /* FIQ */


.equ Len_Stack,        0x100000;  // 1MB of stack memory
.equ Len_IRQ_Stack,    0x100000;  // 1MB of stack memory for IRQ Mode

//GIC_Distributor
.equ GIC_Dist_Base,		0x2c001000

//Register offsets
.equ set_enable1,       0x104
.equ set_enable2,       0x108

//Example definitions
.equ timer_irq_id,    131   // 36 <64 => set_enable1 Reg
.equ kmio_irq_id,     44
.equ uart0_irq_id,    37
.equ rtc_irq_id,      36

// interrupt number for accelerators and DMA engines
.equ cnm0_irq_id,           64
.equ convolution0_irq_id,   65
.equ convolution1_irq_id,   66
.equ edge_tracking0_irq_id, 67
.equ elem_matrix0_irq_id,   68
.equ elem_matrix1_irq_id,   69
.equ elem_matrix2_irq_id,   70
.equ elem_matrix3_irq_id,   71
.equ grayscale0_irq_id,     72
.equ hnm0_irq_id,           73
.equ isp0_irq_id,           74

//GIC_CPU_INTERFACE
.equ GIC_CPU_BASE,                  0x2c002000
.equ GIC_CPU_mask_reg_offset,       0x04
.equ GIC_CPU_Int_Ack_reg_offset,    0x0C
.equ GIC_CPU_End_of_int_offset,     0x10

.align 4
irq_jump_table:
    .word cnm0_irq
    .word convolution0_irq
    .word convolution1_irq
    .word edge_tracking0_irq
    .word elem_matrix0_irq
    .word elem_matrix1_irq
    .word elem_matrix2_irq
    .word elem_matrix3_irq
    .word grayscale0_irq
    .word hnm0_irq
    .word isp0_irq

.align 4
irq_jump_table_addr: .word irq_jump_table


.global Reset_Handler
Reset_Handler:
    // Enable instruction and data caches in SCTLR
    mrc p15, 0, r1, c1, c0, 0
    mov r2, #1
    orr r1, r1, r2, LSL #2      // Enable D-Cache
    orr r1, r1, r2, LSL #12     // Enable I-Cache
    orr r1, r1, r2, LSL #28     // Enable TEX remap
    mcr p15, 0, r1, c1, c0, 0

    // Mark memory as cacheable in NMRR
    mrc p15, 0, r1, c10, c2, 1
    mov r2, #1
    orr r1, r1, r2              // IR0 = 1
    orr r1, r1, r2, LSL #16     // OR0 = 1
    mcr p15, 0, r1, c10, c2, 1

    // Mark memory as normal (i.e. not device) in PRRR
    mrc p15, 0, r1, c10, c2, 0
    mov r2, #2
    orr r1, r1, r2              // TR0 = 2
    mcr p15, 0, r1, c10, c2, 0

    // Set up stack pointers for IRQ processor mode
    mov R1, #0b11010010 // interrupts masked, MODE = IRQ   IRQ | FIQ | 0 | Mode[4:0]
    msr CPSR, R1    // change to IRQ mode
    ldr SP, =stack_base + Len_Stack + Len_IRQ_Stack // set IRQ stack

    // Change back to SVC (supervisor) mode with interrupts disabled
    mov R1, #0b11010011 // interrupts masked, MODE = SVC   IRQ | FIQ | 0 | Mode[4:0]
    msr CPSR, R1    // change to SVC mode
    ldr SP, =stack_base + Len_Stack // set stack

    // Enable individual interrupts, set target
    bl config_gic_dist

    // Enable individual interrupts, set target
    bl config_gic_cpu_interface

    // Enable interrupts in GIC Distributor
    ldr r0, =GIC_Dist_Base
    mov r1, #1
    str r1, [r0]

    // Enable IRQ interrupts in the processor:
    mov R1, #0b01010011 // IRQ not masked (=0), MODE = SVC   IRQ | FIQ | 0 | Mode[4:0]
    msr CPSR, R1

    bl main
    B .

.global Data_Abort_Handler
Data_Abort_Handler:
    sub r0, r14, #8
    bl data_abort_handler

.global config_gic_dist
config_gic_dist:
    push {lr}
    /* Enable the Interrupt in the Set-Enable Register of the GIC Distributor
     *  Set-enable1 Reg Offset Address = 0x104
     *      Bits 0 to 31 correspond to interrupt input lines 32 to 63 respectively.
     *      A bit set to 1 indicates an enabled interrupt.
     *  Set-enable2 Reg Offset Address = 0x108
     *      Bits 0 to 31 correspond to interrupt input lines 64 to 95 respectively.
     *      A bit set to 1 indicates an enabled interrupt.
     *  This Example: Interrupt of timer0 => IRQ ID = 36
     */

    ldr r1, =GIC_Dist_Base + set_enable2    // r1 = Set-enable1 Reg Address
    ldr r2, =0xFFFFFFFF
    str r2, [r1]

    /* Configure Interrupt Processor Taget
     * Reg offset  0x820     for ID32 − ID35
     *             0x824     for ID36 − ID39
     *             ...
     * default values are 0x01010101 => CPU0 is target for all.
     */
    pop {pc}


.global config_gic_cpu_interface
config_gic_cpu_interface:
    push {lr}

    // set Interrupt Priority mask (enable all priority levels)
    ldr r1, =GIC_CPU_BASE + GIC_CPU_mask_reg_offset
    ldr r2, =0xFFFF
    str r2, [r1]

    // set the enable bit in the GIC_CPU_INTERFACE
    mov r2, #1
    ldr r1, =GIC_CPU_BASE
    str r2, [r1]
    pop {pc}


// IRQ Handler that calls the ISR function in C
.global irq_handler
irq_handler:
    push {r0-r4,lr}

    // Disable interrupts
    // Need to do this because the interrupt handler is not reentrant
    mrs r1, CPSR
    orr r1, r1, #0x80
    msr CPSR, r1

    // Read the interrupt acknowledge register of the GIC_CPU_INTERFACE
    ldr r1, =GIC_CPU_BASE + GIC_CPU_Int_Ack_reg_offset
    ldr r4, [r1]

    // Jump to end of IRQ handler if unrecognized interrupt
    cmp r4, #cnm0_irq_id
    blt irq_end
    cmp r4, #isp0_irq_id
    bgt irq_end

    // Calculate address from the jump table
    sub r4, r4, #cnm0_irq_id
    ldr r1, irq_jump_table_addr
    ldr r1, [r1, +r4, LSL #2]

    // Branch to correct handler
    mov pc, r1

cnm0_irq:
    mov r0, #0
    mov r1, #0
    bl isr
    b irq_end

convolution0_irq:
    mov r0, #1
    mov r1, #0
    bl isr
    b irq_end

convolution1_irq:
    mov r0, #1
    mov r1, #1
    bl isr
    b irq_end

edge_tracking0_irq:
    mov r0, #2
    mov r1, #0
    bl isr
    b irq_end

elem_matrix0_irq:
    mov r0, #3
    mov r1, #0
    bl isr
    b irq_end

elem_matrix1_irq:
    mov r0, #3
    mov r1, #1
    bl isr
    b irq_end

elem_matrix2_irq:
    mov r0, #3
    mov r1, #2
    bl isr
    b irq_end

elem_matrix3_irq:
    mov r0, #3
    mov r1, #3
    bl isr
    b irq_end

grayscale0_irq:
    mov r0, #4
    mov r1, #0
    bl isr
    b irq_end

hnm0_irq:
    mov r0, #5
    mov r1, #0
    bl isr
    b irq_end

isp0_irq:
    mov r0, #6
    mov r1, #0
    bl isr

irq_end:
    // write the IRQ ID to the END_OF_INTERRUPT Register of GIC_CPU_INTERFACE
    ldr r1, =GIC_CPU_BASE + GIC_CPU_End_of_int_offset
    add r4, r4, #cnm0_irq_id
    str r4, [r1]

    // Don't need to enable interrupts again since restoring CPSR after the
    // interrupt ends will enable them automatically

    pop {r0-r4,lr}
    subs pc, lr, #4
