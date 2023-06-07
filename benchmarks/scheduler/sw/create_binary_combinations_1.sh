declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")

for policy in "${policies[@]}"
do
    echo "$policy"
    ./create_binary.sh ${policy} canny  1
    ./create_binary.sh ${policy} deblur 1
    ./create_binary.sh ${policy} gru    1
    ./create_binary.sh ${policy} harris 1
    ./create_binary.sh ${policy} lstm   1
done

OUTDIR=bin_comb_1
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
