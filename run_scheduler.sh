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
# - ex5_LITTLE      @ 1.6 GHz
# - HPI             @ 2.2 GHz
# - O3_ARM_v7a_3    @ 2.8 GHz

KERNEL="$M5_PATH/benchmarks/scheduler_cpp/main ${BENCH}"
SYS_OPTS="--mem-size=4GB \
          --mem-type=LPDDR5_6400_1x16_BG_BL32 \
          --cpu-type=ex5_LITTLE \
          --cpu-clock=1.6GHz"
CACHE_OPTS="--caches \
            --cacheline_size=64 \
            --l1d_size=32kB \
            --l1d_assoc=4 \
            --l1i_size=32kB \
            --l1i_assoc=2"

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
