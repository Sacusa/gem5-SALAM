declare -a apps=("canny_1_deblur_0_gru_0_harris_0_lstm_0_scale_0"
                 "canny_0_deblur_1_gru_0_harris_0_lstm_0_scale_0"
                 "canny_0_deblur_0_gru_1_harris_0_lstm_0_scale_0"
                 "canny_0_deblur_0_gru_0_harris_1_lstm_0_scale_0"
                 "canny_0_deblur_0_gru_0_harris_0_lstm_1_scale_0")

declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")

for app in "${apps[@]}"
do
    for policy in "${policies[@]}"
    do
        ./run_solo_app.sh -p -b ${app}_${policy} &
    done
done

wait
