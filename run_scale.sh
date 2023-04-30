#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_scale/${BENCH}.elf
OUTDIR=BM_ARM_OUT/scale/${BENCH}
run_gem5 $KERNEL $OUTDIR
