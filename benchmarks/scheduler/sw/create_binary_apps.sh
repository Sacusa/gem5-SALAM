declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")
declare -a applications=("canny" "deblur" "gru" "harris" "lstm")

for policy in "${policies[@]}"
do
    for application in "${applications[@]}"
    do
        echo "${policy} ${application}"
        ./create_binary.sh ${policy} ${application} 1
    done
done

OUTDIR=bin_solo_app
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
