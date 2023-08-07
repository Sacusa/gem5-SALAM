#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_solo_app_no_fwd/${BENCH}.elf
OUTDIR=BM_ARM_OUT/solo_app_no_fwd/${BENCH}
run_gem5 $KERNEL $OUTDIR
