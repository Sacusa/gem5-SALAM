declare -a policies=("FCFS" "LEDF" "GEDF" "GLAX" "APRX3")
declare -a applications=("canny" "deblur" "gru" "harris" "lstm")

for policy in "${policies[@]}"
do
    for application in "${applications[@]}"
    do
        for (( i=1; i<=10; i++ ))
        do
            ./create_binary.sh ${policy} ${application} ${i}
        done
    done
done

mkdir -p bin
mv *.elf bin/
