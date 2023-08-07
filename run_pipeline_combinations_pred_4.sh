#!/bin/bash

#declare -a policies=("LAX" "ELF")
declare -a policies=("ELF")
#declare -a predictors=("NO_PRED" "AVERAGE_15" "EWMA_0.25")
declare -a predictors=("NO_PRED")
max_concurrent_policies=5
num_concurrent_policies=0
dm_pred="false"

for policy in "${policies[@]}"
do
    for predictor in "${predictors[@]}"
    do
        ./run_pipeline_pred_4.sh -p -b canny_1_deblur_1_gru_1_harris_1_lstm_0_${policy}_MEM_PRED_${predictor}_dm_${dm_pred}  &
        ./run_pipeline_pred_4.sh -p -b canny_1_deblur_1_gru_1_harris_0_lstm_1_${policy}_MEM_PRED_${predictor}_dm_${dm_pred}  &
        ./run_pipeline_pred_4.sh -p -b canny_1_deblur_1_gru_0_harris_1_lstm_1_${policy}_MEM_PRED_${predictor}_dm_${dm_pred}  &
        ./run_pipeline_pred_4.sh -p -b canny_1_deblur_0_gru_1_harris_1_lstm_1_${policy}_MEM_PRED_${predictor}_dm_${dm_pred}  &
        ./run_pipeline_pred_4.sh -p -b canny_0_deblur_1_gru_1_harris_1_lstm_1_${policy}_MEM_PRED_${predictor}_dm_${dm_pred}  &

        ((num_concurrent_policies++))

        if (( num_concurrent_policies == max_concurrent_policies ))
        then
            echo "Waiting..."
            wait
        fi
    done
done

wait
