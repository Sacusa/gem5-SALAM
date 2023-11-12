#! /u/sgupta45/conda/bin/python3
import csv
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array([abs(i) for i in iterable])
    return a.prod()**(1.0/len(a))

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['NO_PRED', 'LAST_VAL', 'AVERAGE_15', 'EWMA_0.25']
policies = ['NO_PRED', 'AVERAGE_15', 'EWMA_0.25']

num_edges = {'canny': 14, 'deblur': 30, 'gru': 149, 'harris': 22,
        'lstm': 174}
num_nodes = {'canny': 12, 'deblur': 22, 'gru': 120, 'harris': 18,
        'lstm': 144}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

accuracy = {p:[] for p in policies}
forwards = {p:[] for p in policies}
deadlines_met = {p:[] for p in policies}

for policy in policies:
    for app_mix in app_mixes:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '1_'
            else:              app_mix_str += '0_'

        if policy == 'NO_PRED':
            dir_name = '../../comb_3_opt_repeat_10_min_3/' + app_mix_str + \
                    'ELF/debug-trace.txt'
        else:
            dir_name = '../../comb_pred_3_opt_repeat_10_min_3/' + app_mix_str+\
                    'ELF_MEM_PRED_' + policy + '_dm_false/debug-trace.txt'

        predicted_bw_insertion = 0
        predicted_bw_launch = 0
        actual_bw_load = 0
        actual_bw_store = 0

        error = [0, 0]

        forwards[policy].append(0)
        deadlines_met[policy].append(0)

        count = 0

        num_iterations = []
        max_forwards = [num_edges[app] for app in app_mix]
        max_deadlines_met = [num_nodes[app] for app in app_mix]

        for line in open(dir_name):
            if 'Predicted memory time / byte' in line:
                if count == 0:
                    predicted_bw_insertion = float(line.split()[8])
                    count += 1
                elif count == 1:
                    predicted_bw_launch = float(line.split()[8])
                    count += 1
                elif count == 2:
                    actual_bw_load = float(line.split()[8])
                    count += 1
                else:
                    actual_bw_store = float(line.split()[8])

                    actual_bw_total = 0

                    if predicted_bw_insertion > 0:
                        if actual_bw_load > 0 and actual_bw_store > 0:
                            actual_bw_total = (actual_bw_load + \
                                    actual_bw_store) / 2
                        elif actual_bw_load > 0:
                            actual_bw_total = actual_bw_load
                        elif actual_bw_store > 0:
                            actual_bw_total = actual_bw_store

                        if actual_bw_total > 0:
                            error[0] += predicted_bw_insertion
                            error[1] += actual_bw_total

                    count = 0

            elif 'Number of forwards' in line:
                forwards[policy][-1] += int(line.split()[6])

            elif 'Number of node deadlines' in line:
                deadlines_met[policy][-1] += int(line.split()[8])

            elif 'Finished DAG iterations' in line:
                num_iterations.append(int(line.split()[6]))

        accuracy[policy].append(((error[0] - error[1]) / error[1]) * 100)
        max_forwards = sum([max_forwards[i] * num_iterations[i]
            for i in range(len(max_forwards))])
        max_deadlines_met = sum([max_deadlines_met[i] * num_iterations[i]
            for i in range(len(max_deadlines_met))])

        forwards[policy][-1] /= (max_forwards / 100)
        deadlines_met[policy][-1] /= (max_deadlines_met / 100)

with open('../plots/comb_3_repeat/bw_predictor_accuracy_performance.csv',
        mode='w') as csv_file:
    csv_writer = csv.writer(csv_file, delimiter=',', quotechar='"',
            quoting=csv.QUOTE_MINIMAL)

    csv_writer.writerow(
            ['Mix', 'Accuracy'] + ['' for i in range(len(policies) - 1)] + \
            ['Forwards (%)'] + ['' for i in range(len(policies) - 1)] + \
            ['Deadlines met (%)'] + ['' for i in range(len(policies) - 1)])

    csv_writer.writerow([''] + policies + policies + policies)

    for i in range(len(app_mixes)):
        app_mix_str = ''
        for app in applications:
            if app in app_mixes[i]: app_mix_str += app[0].upper()

        row = [app_mix_str] + \
                ["{:.2f}".format(accuracy[p][i]) for p in policies] + \
                ["{:.2f}".format(forwards[p][i]) for p in policies] + \
                ["{:.2f}".format(deadlines_met[p][i]) for p in policies]

        csv_writer.writerow(row)
