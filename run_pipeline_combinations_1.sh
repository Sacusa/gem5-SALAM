#!/bin/bash

declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")

for policy in "${policies[@]}"
do
    ./run_pipeline_1.sh -p -b canny_1_deblur_0_gru_0_harris_0_lstm_0_${policy} &
    ./run_pipeline_1.sh -p -b canny_0_deblur_1_gru_0_harris_0_lstm_0_${policy} &
    ./run_pipeline_1.sh -p -b canny_0_deblur_0_gru_1_harris_0_lstm_0_${policy} &
    ./run_pipeline_1.sh -p -b canny_0_deblur_0_gru_0_harris_1_lstm_0_${policy} &
    ./run_pipeline_1.sh -p -b canny_0_deblur_0_gru_0_harris_0_lstm_1_${policy} &
done

wait
