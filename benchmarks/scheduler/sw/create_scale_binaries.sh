#declare -a policies=("FCFS" "GEDF_D" "GEDF_N" "LAX" "ELF")
declare -a policies=("ELF")
max_children=1024

for policy in "${policies[@]}"
do
    echo "$policy"
    ./create_binary.sh ${policy} scale ${max_children}
done

OUTDIR=bin_scale
mkdir -p ${OUTDIR}
mv *.elf ${OUTDIR}
