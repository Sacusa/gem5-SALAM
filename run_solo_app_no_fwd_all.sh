declare -a apps=("canny_1_deblur_0_gru_0_harris_0_lstm_0"
                 "canny_0_deblur_1_gru_0_harris_0_lstm_0"
                 "canny_0_deblur_0_gru_1_harris_0_lstm_0"
                 "canny_0_deblur_0_gru_0_harris_1_lstm_0"
                 "canny_0_deblur_0_gru_0_harris_0_lstm_1")

for app in "${apps[@]}"
do
    ./run_solo_app_no_fwd.sh -p -b ${app}_ELF_MEM_PRED_NO_PRED_dm_false &
done

wait
