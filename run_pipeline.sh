#!/bin/bash
source run_base.sh

KERNEL=$M5_PATH/benchmarks/scheduler/sw/bin/${BENCH}.elf
OUTDIR=BM_ARM_OUT/${BENCH}_pipeline
run_gem5 $KERNEL $OUTDIR
