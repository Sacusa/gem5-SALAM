declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")

for policy in "${policies[@]}"
do
    echo "$policy"
    ./create_binary.sh ${policy} canny  4 deblur 4 gru    4
    ./create_binary.sh ${policy} canny  4 deblur 4 harris 4
    ./create_binary.sh ${policy} canny  4 deblur 4 lstm   4
    ./create_binary.sh ${policy} canny  4 gru    4 harris 4
    ./create_binary.sh ${policy} canny  4 gru    4 lstm   4
    ./create_binary.sh ${policy} canny  4 harris 4 lstm   4
    ./create_binary.sh ${policy} deblur 4 gru    4 harris 4
    ./create_binary.sh ${policy} deblur 4 gru    4 lstm   4
    ./create_binary.sh ${policy} deblur 4 harris 4 lstm   4
    ./create_binary.sh ${policy} gru    4 harris 4 lstm   4
done

OUTDIR=bin_comb_4
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
