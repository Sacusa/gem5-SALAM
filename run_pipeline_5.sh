#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_comb_5/${BENCH}.elf
OUTDIR=BM_ARM_OUT/comb_5/${BENCH}
run_gem5 $KERNEL $OUTDIR
