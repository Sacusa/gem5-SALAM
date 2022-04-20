#!/bin/bash

declare -a policies=("FCFS" "LEDF" "GEDF" "GLAX" "APRX3")
max_concurrent_policies=3
num_concurrent_policies=0

for policy in "${policies[@]}"
do
    ./run_pipeline.sh -p -b canny_4_deblur_4_gru_4_harris_0_lstm_0_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_4_gru_0_harris_4_lstm_0_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_4_gru_0_harris_0_lstm_4_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_0_gru_4_harris_4_lstm_0_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_0_gru_4_harris_0_lstm_4_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_0_gru_0_harris_4_lstm_4_${policy} &
    ./run_pipeline.sh -p -b canny_0_deblur_4_gru_4_harris_4_lstm_0_${policy} &
    ./run_pipeline.sh -p -b canny_0_deblur_4_gru_4_harris_0_lstm_4_${policy} &
    ./run_pipeline.sh -p -b canny_0_deblur_4_gru_0_harris_4_lstm_4_${policy} &
    ./run_pipeline.sh -p -b canny_0_deblur_0_gru_4_harris_4_lstm_4_${policy} &

    ((num_concurrent_policies++))

    if (( num_concurrent_policies == max_concurrent_policies ))
    then
        echo "Waiting..."
        wait
    fi
done

wait
