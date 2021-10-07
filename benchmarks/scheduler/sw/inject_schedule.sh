#!/bin/bash

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 <application> <policy>"
    exit -1
fi

SCHEDULER_DIR=~/scheduler

code="void schedule(task_struct_t ***nodes) \/\/ Policy: ${2}\n"
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

cd ${SCHEDULER_DIR}
schedule=`./main.py ${2} resource_configs/resources.cfg 1 dags/${1}.cfg`
code+=${schedule#*$'\n'}  # clip the first line with the performance results
cd -

code+="\n\n     runtime(run_queue, run_queue_size);\n}\n"

cp ${1}.template ${1}.c
sed -i "s/<<schedule>>/${code}/g" ${1}.c
