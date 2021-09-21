#!/bin/bash

declare -a lane=("1" "2" "4" "8" "16" "32")
declare -a spm_ports=("1" "2" "4" "8" "16")
#declare -a benchmarks=("canny_non_max" "convolution" "edge_tracking"
#                       "elem_matrix" "grayscale" "harris_non_max" "isp")
declare -a benchmarks=("canny_non_max" "edge_tracking"
                       "elem_matrix" "grayscale" "harris_non_max" "isp")

run_sweep () {
    benchmark=${1}

    cd ~/gem5-SALAM/benchmarks/${benchmark}

    for l in "${lane[@]}"; do
        for sp in "${spm_ports[@]}"; do
            ./set_config.sh ${l} ${sp}
            cd hw
            make

            cd ~/gem5-SALAM
            ./run_acc.sh -b ${benchmark} -p

            cd BM_ARM_OUT
            mv ${benchmark} ${benchmark}_${l}_${sp}

            cd ~/gem5-SALAM/benchmarks/${benchmark}
        done
    done

    cd ~/gem5-SALAM/BM_ARM_OUT/
    mkdir -p ${benchmark}
    mv ${benchmark}_* ${benchmark}/
    mv ${benchmark} ${benchmark}_sweep
}

if [ "$#" -eq 1 ]; then
    run_sweep ${1}
else
    for benchmark in "${benchmarks[@]}"; do
        run_sweep ${benchmark} &
    done

    wait
fi
