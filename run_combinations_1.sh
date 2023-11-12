#!/bin/bash

if [ "$#" -ne 1  ]; then
    echo "Usage: $0 <nthreads>"
    exit -1
fi

declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "HetSched" "ELF")
let max_concurrent_policies=$1/5
max_concurrent_policies=$(( max_concurrent_policies > 0 ? max_concurrent_policies : 1 ))
num_concurrent_policies=0

for policy in "${policies[@]}"
do
    ./run_1.sh -p -b canny_1_deblur_0_gru_0_harris_0_lstm_0_${policy} &
    ./run_1.sh -p -b canny_0_deblur_1_gru_0_harris_0_lstm_0_${policy} &
    ./run_1.sh -p -b canny_0_deblur_0_gru_1_harris_0_lstm_0_${policy} &
    ./run_1.sh -p -b canny_0_deblur_0_gru_0_harris_1_lstm_0_${policy} &
    ./run_1.sh -p -b canny_0_deblur_0_gru_0_harris_0_lstm_1_${policy} &

    ((num_concurrent_policies++))

    if (( num_concurrent_policies == max_concurrent_policies ))
    then
        echo "Waiting..."
        wait
        num_concurrent_policies=0
    fi
done

wait
