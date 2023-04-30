#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

for policy in policies:
    print(policy)
    print('##########################################')
    for app_mix in app_mixes:
        schedule = [[],
                    [],
                    [],
                    [],
                    [],
                    [],
                    []]

        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '4_'
            else:              app_mix_str += '0_'

        print(app_mix_str)
        dir_name = '../comb_4/' + app_mix_str + policy + '/debug-trace.txt'

        dag_id = 0
        node_id = 0
        acc_id = 0
        acc_instance = 0

        for line in open(dir_name):
            if 'Total predicted compute time' in line:
                dag_id = int(line.split()[7])
            elif 'Total predicted memory time' in line:
                node_id = int(line.split()[7])
            elif 'Number of forwards' in line:
                acc_id = int(line.split()[6])

                if acc_id < 8:
                    schedule[acc_id].append((dag_id, node_id))

        for i in range(len(schedule)):
            print('Accelerator ' + str(i))

            for dag_id, node_id in schedule[i]:
                print('  Node[' + str(dag_id) + '][' + str(node_id) + ']')
