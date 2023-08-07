#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_comb_pred_4/${BENCH}.elf
OUTDIR=BM_ARM_OUT/comb_pred_4/${BENCH}
run_gem5 $KERNEL $OUTDIR
