#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
predictors = ['NO_PRED', 'AVERAGE_15', 'EWMA_0.25']

app_mixes = [('canny', 'gru', 'lstm'), ('deblur', 'gru', 'lstm'),
        ('gru', 'harris', 'lstm')]
#app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

for predictor in predictors:
    print(predictor)
    print('##########################################')
    for app_mix in app_mixes:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '1_'
            else:              app_mix_str += '0_'

        print(app_mix_str)
        dir_name = '../../comb_pred_3/' + app_mix_str + 'ELF_MEM_PRED_' + \
                predictor + '_dm_false/debug-trace.txt'

        dag_id = 0
        prev_dag_id = 0
        num_chains = -1

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
                if dag_id != prev_dag_id:
                    num_chains += 1
                    prev_dag_id = dag_id

        print(num_chains)
