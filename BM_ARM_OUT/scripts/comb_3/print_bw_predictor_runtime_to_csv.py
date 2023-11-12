#! /u/sgupta45/conda/bin/python3
import csv
import itertools
import numpy as np
import sys

avg = lambda l : sum(l) / len(l)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['LAST_VAL', 'AVERAGE_15', 'EWMA_0.25']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

avg_latency = {p:[] for p in policies}
tail_latency = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        if policy == 'LAST_VAL':
            dir_name = '../../comb_3/' + app_mix_str + 'ELF'
        else:
            dir_name = '../../comb_pred_3/' + app_mix_str + 'ELF_MEM_PRED_' + \
                       policy
        dir_name += '/debug-trace.txt'

        latency = []

        for line in open(dir_name):
            if 'Timer #1 stopped' in line:
                latency.append(float(line.split()[9]) / 1000)

        avg_latency[policy].append(avg(latency))
        tail_latency[policy].append(max(latency))
        #tail_latency[policy].append(np.percentile(latency, 99))

with open('../plots/comb_3/predictor_runtime.csv', mode='w') as csv_file:
    csv_writer = csv.writer(csv_file, delimiter=',', quotechar='"',
            quoting=csv.QUOTE_MINIMAL)
    csv_writer.writerow(['Mix', 'Last', 'EWMA', 'Avg', 'Last', 'EWMA', 'Avg'])

    for i in range(len(app_mixes)):
        csv_writer.writerow([i,
            "{:.2f}".format(avg_latency['LAST_VAL'][i]),
            "{:.2f}".format(avg_latency['EWMA_0.25'][i]),
            "{:.2f}".format(avg_latency['AVERAGE_15'][i]),
            "{:.2f}".format(tail_latency['LAST_VAL'][i]),
            "{:.2f}".format(tail_latency['EWMA_0.25'][i]),
            "{:.2f}".format(tail_latency['AVERAGE_15'][i])])
