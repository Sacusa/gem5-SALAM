#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

linestyle = {'LAST_VAL': 'bo--', 'NO_PRED': 'g*--', 'AVERAGE_15': 'rP--',
             'EWMA_0.25': 'ys--'}

def geo_mean(iterable):
    a = np.array([abs(i) for i in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(policy, label):
    plt.plot(x, total_accuracy[policy], linestyle[policy], linewidth=2,
            markersize=25, markeredgecolor='k', label=label, zorder=3)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['LAST_VAL', 'NO_PRED', 'AVERAGE_15', 'EWMA_0.25']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

load_accuracy = {p:[] for p in policies}
store_accuracy = {p:[] for p in policies}
total_accuracy = {p:[] for p in policies}

for policy in policies:
    #print(policy)

    for app_mix in app_mixes:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '1_'
            else:              app_mix_str += '0_'

        #print('  ' + app_mix_str)

        if policy == 'LAST_VAL':
            dir_name = '../../comb_3/' + app_mix_str + \
                    'ELF/debug-trace.txt'
        else:
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    'ELF_MEM_PRED_' + policy + '_dm_false/debug-trace.txt'

        load_error = [0, 0]
        store_error = [0, 0]
        total_error = [0, 0]

        count = 0

        for line in open(dir_name):
            if 'Predicted memory time = ' in line:
                if count == 0:
                    load_error[0] += float(line.split()[6])
                    count += 1
                elif count == 1:
                    store_error[0] += float(line.split()[6])
                    count += 1
                elif count == 2:
                    load_error[1] += float(line.split()[6])
                    count += 1
                else:
                    store_error[1] += float(line.split()[6])
                    count = 0

        total_error[0] = load_error[0] + store_error[0]
        total_error[1] = load_error[1] + store_error[1]

        load_accuracy[policy].append(((load_error[0] - load_error[1]) / \
                load_error[1]) * 100)
        store_accuracy[policy].append(((store_error[0] - store_error[1]) / \
                store_error[1]) * 100)
        total_accuracy[policy].append(((total_error[0] - total_error[1]) / \
                total_error[1]) * 100)

    print(policy + ': ' + str(geo_mean(load_accuracy[policy])) + '/' + \
            str(geo_mean(store_accuracy[policy])) + '/' + \
            str(geo_mean(total_accuracy[policy])))

x = [i for i in range(len(app_mixes))]
x_labels = ["".join([a[0].upper() for a in app_mix]) for app_mix in app_mixes]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

add_plot('NO_PRED',    'No')
add_plot('LAST_VAL',   'Last')
add_plot('EWMA_0.25',  'EWMA')
add_plot('AVERAGE_15', 'Avg')

plt.xticks(x, x_labels, fontsize=35)

plt.ylabel('Error (%)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([-70, 20])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(10))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/bw_predictor_accuracy_total_time_insert.pdf',
        bbox_inches='tight')
