declare -a policies=("APRX2" "GEDF" "LLAX")

for policy in "${policies[@]}"
do
    ./run_pipeline.sh -p -b canny_4_deblur_4_gru_4_harris_0_lstm_0_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_4_gru_0_harris_4_lstm_0_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_4_gru_0_harris_0_lstm_4_${policy} &
    wait

    ./run_pipeline.sh -p -b canny_4_deblur_0_gru_4_harris_4_lstm_0_${policy} &
    ./run_pipeline.sh -p -b canny_4_deblur_0_gru_0_harris_4_lstm_4_${policy} &
    ./run_pipeline.sh -p -b canny_0_deblur_4_gru_4_harris_4_lstm_0_${policy} &
    wait

    ./run_pipeline.sh -p -b canny_0_deblur_4_gru_0_harris_4_lstm_4_${policy} &
    ./run_pipeline.sh -p -b canny_0_deblur_4_gru_4_harris_0_lstm_4_${policy} &
    wait

    ./run_pipeline.sh -p -b canny_4_deblur_0_gru_4_harris_0_lstm_4_${policy} &
    wait

    ./run_pipeline.sh -p -b canny_0_deblur_0_gru_4_harris_4_lstm_4_${policy} &
    wait
done
