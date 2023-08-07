declare -a accs=("canny_non_max" "convolution" "edge_tracking" "elem_matrix"
    "grayscale" "harris_non_max" "isp")

for acc in "${accs[@]}"
do
    ./run_solo_acc.sh -p -b ${acc}_ELF_MEM_PRED_NO_PRED_dm_false &
done

wait
