declare -a policies=("APRX" "FCFS" "GEDF" "GLAX" "LEDF" "LLAX")

for policy in "${policies[@]}"
do
    ./create_binary.sh ${policy} canny  5 deblur 5 gru    5
    ./create_binary.sh ${policy} canny  5 deblur 5 harris 5
    ./create_binary.sh ${policy} canny  5 deblur 5 lstm   5
    ./create_binary.sh ${policy} canny  5 gru    5 harris 5
    ./create_binary.sh ${policy} canny  5 gru    5 lstm   5
    ./create_binary.sh ${policy} canny  5 harris 5 lstm   5
    ./create_binary.sh ${policy} deblur 5 gru    5 harris 5
    ./create_binary.sh ${policy} deblur 5 gru    5 lstm   5
    ./create_binary.sh ${policy} deblur 5 harris 5 lstm   5
    ./create_binary.sh ${policy} gru    5 harris 5 lstm   5
done

mkdir -p bin
mv *.elf bin/
