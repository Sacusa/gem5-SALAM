#!/bin/bash
source run_base.sh

#KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_parallel_dma/${BENCH}.elf
KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin/${BENCH}.elf
OUTDIR=BM_ARM_OUT/image_4_parallel_dma/${BENCH}_pipeline
run_gem5 $KERNEL $OUTDIR
