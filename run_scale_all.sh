#!/bin/bash

declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")
num_children=1024

for policy in "${policies[@]}"
do
    ./run_scale.sh -p -b canny_0_deblur_0_gru_0_harris_0_lstm_0_scale_${num_children}_${policy} &
done

wait
