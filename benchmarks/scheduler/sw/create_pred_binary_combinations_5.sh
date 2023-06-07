declare -a policies=("LAX" "ELF")
#declare -a predictors=("MEM_PRED_AVERAGE" "MEM_PRED_EWMA" "MEM_PRED_NO_PRED")
declare -a predictors=("MEM_PRED_AVERAGE")

for policy in "${policies[@]}"
do
    echo "$policy"

    for predictor in "${predictors[@]}"
    do
        echo "$predictor"

        ./create_pred_binary.sh ${policy} ${predictor} canny 1 deblur 1 gru 1 harris 1 lstm 1
    done
done

rename AVERAGE AVERAGE_15 *

OUTDIR=bin_comb_pred_5
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
