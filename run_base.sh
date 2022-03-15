#!/bin/bash
FLAGS="HWACC,CommInterface,LLVMInterface,StreamDma,NoncoherentDma,TickTimer"
BENCH=""
DEBUG="false"
PRINT_TO_FILE="false"

while getopts ":b:f:dp" opt
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
                ;;
            f )
                FLAGS+=",${OPTARG}"
                ;;
            * )
                echo "Invalid argument: ${OPTARG}"
                echo "Usage: $0 -b BENCHMARK (-f DEBUGFLAG) (-p) (-d)"
                exit 1
                ;;
        esac
done

if [ "${BENCH}" == "" ]; then
    echo "No benchmark specified."
    echo "Usage: $0 -b BENCHMARK (-f DEBUGFLAG) (-p) (-d)"
    exit 2
fi

run_gem5() {
    KERNEL=$1
    OUTDIR=$2

    if [ "${DEBUG}" == "true" ]; then
        BINARY="gdb --args ${M5_PATH}/build/ARM/gem5.debug"
    else
        BINARY="${M5_PATH}/build/ARM/gem5.opt"
    fi

    SYS_OPTS="--mem-size=4GB \
              --mem-type=LPDDR5_6400_1x16_BG_BL32 \
              --kernel=$KERNEL \
              --vans-config-path=/u/sgupta45/VANS/config \
              --disk-image=$M5_PATH/baremetal/common/fake.iso \
              --machine-type=VExpress_GEM5_V1 \
              --dtb-file=none --bare-metal \
              --cpu-type=ex5_LITTLE \
              --cpu-clock=1.6GHz"
    CACHE_OPTS="--caches \
                --cacheline_size=64 \
                --l1d_size=32kB \
                --l1d_assoc=4 \
                --l1i_size=32kB \
                --l1i_assoc=2"

    RUN_SCRIPT="$BINARY --debug-flags=$FLAGS --outdir=$OUTDIR \
                configs/SALAM/scheduler.py $SYS_OPTS \
                --accpath=$M5_PATH/benchmarks \
                $CACHE_OPTS"

    if [ "${PRINT_TO_FILE}" == "true" ]; then
        mkdir -p $OUTDIR
        $RUN_SCRIPT > ${OUTDIR}/debug-trace.txt
    else
        $RUN_SCRIPT
    fi
}
