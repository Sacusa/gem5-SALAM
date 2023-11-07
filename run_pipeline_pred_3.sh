#!/bin/bash
source run_base.sh

#KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_comb_pred_3/${BENCH}.elf
#OUTDIR=BM_ARM_OUT/comb_pred_3_opt_flush_opt_fwd/${BENCH}
KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_comb_pred_3_repeat_10_min_3/${BENCH}.elf
OUTDIR=BM_ARM_OUT/comb_pred_3_opt_repeat_10_min_3/${BENCH}
run_gem5 $KERNEL $OUTDIR
