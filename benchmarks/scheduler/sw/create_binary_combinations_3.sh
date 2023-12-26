declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LL" "LAX" "HetSched"
    "ELF" "ELFD")

for policy in "${policies[@]}"
do
    echo "$policy"
    ./create_binary.sh ${policy} canny  1 deblur 1 gru    1
    ./create_binary.sh ${policy} canny  1 deblur 1 harris 1
    ./create_binary.sh ${policy} canny  1 deblur 1 lstm   1
    ./create_binary.sh ${policy} canny  1 gru    1 harris 1
    ./create_binary.sh ${policy} canny  1 gru    1 lstm   1
    ./create_binary.sh ${policy} canny  1 harris 1 lstm   1
    ./create_binary.sh ${policy} deblur 1 gru    1 harris 1
    ./create_binary.sh ${policy} deblur 1 gru    1 lstm   1
    ./create_binary.sh ${policy} deblur 1 harris 1 lstm   1
    ./create_binary.sh ${policy} gru    1 harris 1 lstm   1
done

OUTDIR=bin_comb_3
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
