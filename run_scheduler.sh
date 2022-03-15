#!/bin/bash
BENCH=""
DEBUG="false"
PRINT_TO_FILE="false"

while getopts ":b:dp:" opt
	do
		case $opt in
			b )
				BENCH=${OPTARG}
				;;
			d )
				DEBUG="true"
				;;
			p )
				PRINT_TO_FILE="true"
                OUTDIR=BM_ARM_OUT/scheduler_${OPTARG}
				;;
			* )
				echo "Invalid argument: ${OPTARG}"
				echo "Usage: $0 -b BENCHMARK -p OUT_NAME (-d)"
				exit 1
				;;
		esac
done

if [ "${BENCH}" == "" ]; then
	echo "No benchmark specified."
	echo "Usage: $0 -b BENCHMARK (-f DEBUGFLAG) (-p) (-d)"
	exit 2
fi

if [ "${DEBUG}" == "true" ]; then
	BINARY="gdb --args ${M5_PATH}/build/ARM/gem5.debug"
else
	BINARY="${M5_PATH}/build/ARM/gem5.opt"
fi

# Possible CPU types
# - HPI
# - ex5_LITTLE
# - O3_ARM_v7a_3

KERNEL="$M5_PATH/benchmarks/scheduler_cpp/main ${BENCH}"
SYS_OPTS="--mem-size=4GB \
		  --mem-type=LPDDR3_1600_1x32 \
          --cpu-type=HPI \
          --cpu-clock=2.2GHz"
CACHE_OPTS="--caches"

RUN_SCRIPT="$BINARY --outdir=$OUTDIR \
			configs/SALAM/se.py $SYS_OPTS \
            $CACHE_OPTS \
            $KERNEL"

if [ "${PRINT_TO_FILE}" == "true" ]; then
	mkdir -p $OUTDIR
	$RUN_SCRIPT > ${OUTDIR}/debug-trace.txt
else
	$RUN_SCRIPT
fi
