#!/bin/bash

declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "HetSched" "ELF")
max_concurrent_policies=5
num_concurrent_policies=0

for policy in "${policies[@]}"
do
    ./run_pipeline_5.sh -p -b canny_1_deblur_1_gru_1_harris_1_lstm_1_${policy} &

    ((num_concurrent_policies++))

    if (( num_concurrent_policies == max_concurrent_policies ))
    then
        echo "Waiting..."
        wait
        num_concurrent_policies=0
    fi
done

wait
