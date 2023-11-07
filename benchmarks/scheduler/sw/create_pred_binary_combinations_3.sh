declare -a policies=("LL" "LAX" "ELF" "ELFD")
declare -a predictors=("MEM_PRED_AVERAGE" "MEM_PRED_EWMA" "MEM_PRED_NO_PRED")
dm_pred="false"

for policy in "${policies[@]}"
do
    echo "$policy"

    for predictor in "${predictors[@]}"
    do
        echo "$predictor"

        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} canny  1 deblur 1 gru    1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} canny  1 deblur 1 harris 1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} canny  1 deblur 1 lstm   1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} canny  1 gru    1 harris 1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} canny  1 gru    1 lstm   1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} canny  1 harris 1 lstm   1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} deblur 1 gru    1 harris 1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} deblur 1 gru    1 lstm   1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} deblur 1 harris 1 lstm   1
        ./create_pred_binary.sh ${policy} ${predictor} ${dm_pred} gru    1 harris 1 lstm   1
    done
done

rename AVERAGE AVERAGE_15 *
rename EWMA EWMA_0.25 *

OUTDIR=bin_comb_pred_3
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
