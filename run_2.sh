#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_comb_2/${BENCH}.elf
OUTDIR=BM_ARM_OUT/comb_2/${BENCH}
run_gem5 $KERNEL $OUTDIR
