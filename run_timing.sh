#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_timing/${BENCH}_time.elf
OUTDIR=BM_ARM_OUT/${BENCH}_time
run_gem5 $KERNEL $OUTDIR
