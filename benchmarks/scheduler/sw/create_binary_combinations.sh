declare -a policies=("APRX" "FCFS" "GEDF" "GLAX" "LEDF" "LLAX")

for policy in "${policies[@]}"
do
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

mkdir -p bin
mv *.elf bin/
