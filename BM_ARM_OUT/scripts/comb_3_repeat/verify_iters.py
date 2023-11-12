#! /u/sgupta45/conda/bin/python3
import itertools
import sys

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

if len(sys.argv) != 2:
    print("Usage: " + sys.argv[0] + ' <min iters>')
    exit(-1)

min_iters = int(sys.argv[1])

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        dir_name = '../../comb_3_repeat_10_min_3/' + app_mix_str + policy + \
                '/debug-trace.txt'

        iters = [0, 0, 0]
        dag_id = ''

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG deadline difference' in line:
                iters[dag_id] += 1

        for i in range(3):
            if iters[i] < min_iters:
                print(app_mix, policy, i, iters[i])
