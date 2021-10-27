declare -a policies=("APRX2" "FCFS" "GEDF" "GLAX" "LEDF" "LLAX")

for policy in "${policies[@]}"
do
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

mkdir -p bin
mv *.elf bin/
