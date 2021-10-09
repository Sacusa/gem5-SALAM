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

# create a copy of the file
cp main.template main.c

# modify DAG counts in the code
sed -i '/int num_canny/c\    int num_canny = '"${num_canny};" main.c
sed -i '/int num_deblur/c\    int num_deblur = '"${num_deblur};" main.c
sed -i '/int num_gru/c\    int num_gru = '"${num_gru};" main.c
sed -i '/int num_harris/c\    int num_harris = '"${num_harris};" main.c
sed -i '/int num_lstm/c\    int num_lstm = '"${num_lstm};" main.c

# generate scheduler command and store the schedule
scheduler_command="./main.py ${policy} resource_configs/resources.cfg 1"
for (( i=0; i<${num_canny}; i++)); do
    scheduler_command+=" dags/canny.cfg"
done
for (( i=0; i<${num_deblur}; i++)); do
    scheduler_command+=" dags/deblur_5.cfg"
done
for (( i=0; i<${num_gru}; i++)); do
    scheduler_command+=" dags/gru_8.cfg"
done
for (( i=0; i<${num_harris}; i++)); do
    scheduler_command+=" dags/harris.cfg"
done
for (( i=0; i<${num_lstm}; i++)); do
    scheduler_command+=" dags/lstm_8.cfg"
done

cd ~/scheduler
schedule=`${scheduler_command}`
cd -

# generate and inject schedule code
code="void schedule(task_struct_t ***nodes)\n"
code+="{\n"
code+="    task_struct_t ****run_queue = (task_struct_t****)\n"
code+="        get_memory(NUM_ACCS * sizeof(task_struct_t***));\n"
code+="    int **run_queue_size = (int**) get_memory(NUM_ACCS * sizeof(int*));\n\n"
code+="    for (int i = 0; i < NUM_ACCS; i++) {\n"
code+="        run_queue[i] = (task_struct_t***)\n"
code+="            get_memory(MAX_ACC_INSTANCES * sizeof(task_struct_t**));\n"
code+="        run_queue_size[i] = (int*)\n"
code+="            get_memory(MAX_ACC_INSTANCES * sizeof(int));\n\n"
code+="        for (int j = 0; j < MAX_ACC_INSTANCES; j++) {\n"
code+="            run_queue[i][j] = (task_struct_t**)\n"
code+="                get_memory(MAX_NODES * sizeof(task_struct_t*));\n"
code+="        }\n"
code+="    }\n\n"
code+=${schedule#*$'\n'}  # clip the first line with the performance results
code+="\n\n     runtime(run_queue, run_queue_size);\n}\n"
sed -i "s/<<schedule>>/${code}/g" main.c

# compile and rename binary
make main.elf
mv main.elf canny_${num_canny}_deblur_${num_deblur}_gru_${num_gru}_harris_${num_harris}_lstm_${num_lstm}_${policy}.elf
