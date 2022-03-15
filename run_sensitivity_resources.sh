declare -a policies=("FCFS" "LEDF" "GEDF" "GLAX" "APRX3")
declare -a applications=("canny" "deblur_5" "gru_8" "harris" "lstm_8")

for app in "${applications[@]}"; do
    for policy in "${policies[@]}"; do
        for (( i=1; i<=10; i++ )); do
            dags=""
            for (( j=0; j<50; j++ )); do
                dags+="dags/${app}.cfg "
            done

            ./run_scheduler.sh -p ${policy}_${app}_r_${i} -b "${policy} resource_configs/resources_${i}.cfg ${dags}" &
        done
    done

    wait
done
