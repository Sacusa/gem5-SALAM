#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_comb_pred_3/${BENCH}.elf
#OUTDIR=BM_ARM_OUT/comb_pred_3/${BENCH}
OUTDIR=BM_ARM_OUT/comb_pred_3_xbar/${BENCH}
run_gem5 $KERNEL $OUTDIR
