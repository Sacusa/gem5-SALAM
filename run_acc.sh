#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/$BENCH/sw/main.elf
OUTDIR=BM_ARM_OUT/$BENCH
run_gem5 $KERNEL $OUTDIR
