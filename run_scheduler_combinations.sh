#!/bin/bash

run_scheduler () {
    policy=$1
    app1=$2
    app2=$3
    app3=$4

    ./run_scheduler.sh -p ${policy}_${app1}_${app2}_${app3} -b "${policy} resource_configs/resources.cfg dags/${app1}.cfg dags/${app1}.cfg dags/${app1}.cfg dags/${app1}.cfg dags/${app2}.cfg dags/${app2}.cfg dags/${app2}.cfg dags/${app2}.cfg dags/${app3}.cfg dags/${app3}.cfg dags/${app3}.cfg dags/${app3}.cfg"
}

declare -a policies=("FCFS" "LEDF" "GEDF" "GLAX" "APRX3")

for policy in "${policies[@]}"
do
    run_scheduler ${policy} canny  deblur gru    &
    run_scheduler ${policy} canny  deblur harris &
    run_scheduler ${policy} canny  deblur lstm   &
    run_scheduler ${policy} canny  gru    harris &
    run_scheduler ${policy} canny  gru    lstm   &
    run_scheduler ${policy} canny  harris lstm   &
    run_scheduler ${policy} deblur gru    harris &
    run_scheduler ${policy} deblur gru    lstm   &
    run_scheduler ${policy} deblur harris lstm   &
    run_scheduler ${policy} gru    harris lstm   &
done

wait
