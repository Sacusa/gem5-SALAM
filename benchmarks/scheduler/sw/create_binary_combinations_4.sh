declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")

for policy in "${policies[@]}"
do
    echo "$policy"
    ./create_binary.sh ${policy} ${predictor} canny  1 deblur 1 gru    1 harris 1
    ./create_binary.sh ${policy} ${predictor} canny  1 deblur 1 gru    1 lstm   1
    ./create_binary.sh ${policy} ${predictor} canny  1 deblur 1 harris 1 lstm   1
    ./create_binary.sh ${policy} ${predictor} canny  1 gru    1 harris 1 lstm   1
    ./create_binary.sh ${policy} ${predictor} deblur 1 gru    1 harris 1 lstm   1
done

OUTDIR=bin_comb_4
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
