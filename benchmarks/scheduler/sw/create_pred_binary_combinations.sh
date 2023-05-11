declare -a policies=("LAX" "ELF")
declare -a predictors=("MEM_PRED_AVERAGE" "MEM_PRED_EWMA" "MEM_PRED_NO_PRED")

for policy in "${policies[@]}"
do
    echo "$policy"

    for predictor in "${predictors[@]}"
    do
        echo "$predictor"

        ./create_pred_binary.sh ${policy} ${predictor} canny  4 deblur 4 gru    4
        ./create_pred_binary.sh ${policy} ${predictor} canny  4 deblur 4 harris 4
        ./create_pred_binary.sh ${policy} ${predictor} canny  4 deblur 4 lstm   4
        ./create_pred_binary.sh ${policy} ${predictor} canny  4 gru    4 harris 4
        ./create_pred_binary.sh ${policy} ${predictor} canny  4 gru    4 lstm   4
        ./create_pred_binary.sh ${policy} ${predictor} canny  4 harris 4 lstm   4
        ./create_pred_binary.sh ${policy} ${predictor} deblur 4 gru    4 harris 4
        ./create_pred_binary.sh ${policy} ${predictor} deblur 4 gru    4 lstm   4
        ./create_pred_binary.sh ${policy} ${predictor} deblur 4 harris 4 lstm   4
        ./create_pred_binary.sh ${policy} ${predictor} gru    4 harris 4 lstm   4
    done
done

OUTDIR=bin_comb_pred_4
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
