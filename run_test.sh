#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin_tests/${BENCH}.elf
OUTDIR=BM_ARM_OUT/${BENCH}_test
run_gem5 $KERNEL $OUTDIR
