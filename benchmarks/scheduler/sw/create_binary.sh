#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <policy> [<application> <num instances>]+"
    exit -1
fi

# parse commandline arguments
policy="$1"
shift

num_canny=0
num_deblur=0
num_gru=0
num_harris=0
num_lstm=0

for (( i=1; i<${#}; )); do
    application=$1
    shift

    if [[ ${application} == "canny" ]]; then
        num_canny=$1
    elif [[ ${application} == "deblur" ]]; then
        num_deblur=$1
    elif [[ ${application} == "gru" ]]; then
        num_gru=$1
    elif [[ ${application} == "harris" ]]; then
        num_harris=$1
    elif [[ ${application} == "lstm" ]]; then
        num_lstm=$1
    else
        echo "Unknown application: ${application}"
        exit -1
    fi

    shift
done

# copy the template
cp main.template main.c

# modify DAG counts in the code
sed -i '/int num_canny/c\    int num_canny = '"${num_canny};" main.c
sed -i '/int num_deblur/c\    int num_deblur = '"${num_deblur};" main.c
sed -i '/int num_gru/c\    int num_gru = '"${num_gru};" main.c
sed -i '/int num_harris/c\    int num_harris = '"${num_harris};" main.c
sed -i '/int num_lstm/c\    int num_lstm = '"${num_lstm};" main.c

# create the runtime call
num_dags=$(($num_canny + $num_deblur + $num_gru + $num_harris + $num_lstm))
if [ "$policy" = "LAX" ]; then
    sed -i '/runtime_call/c\    runtime(nodes, '"${num_dags}"', num_nodes, '"${policy}"', MEM_PRED_EWMA, false);' main.c
else
    sed -i '/runtime_call/c\    runtime(nodes, '"${num_dags}"', num_nodes, '"${policy}"', MEM_PRED_NO_PRED, false);' main.c
fi

# compile and rename binary
make main.elf &> /dev/null
mv main.elf canny_${num_canny}_deblur_${num_deblur}_gru_${num_gru}_harris_${num_harris}_lstm_${num_lstm}_${policy}.elf
rm main.c
