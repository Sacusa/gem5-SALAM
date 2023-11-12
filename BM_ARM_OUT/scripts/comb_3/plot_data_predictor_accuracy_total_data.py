#! /u/sgupta45/conda/bin/python3
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
app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

load_accuracy = []
store_accuracy = []
total_accuracy = []

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    dir_name = '../../comb_pred_3_opt_flush_opt_fwd/' + app_mix_str + \
            'ELF_MEM_PRED_NO_PRED_dm_true/debug-trace.txt'

    load_error = [0, 0]
    store_error = [0, 0]
    total_error = [0, 0]

    count = 0

    for line in open(dir_name):
        if 'Predicted memory access size' in line:
            value = int(line.split()[7])
            if count == 0:
                load_error[0] += value
                count += 1
            elif count == 1:
                load_error[1] += value
                count += 1
            elif count == 2:
                store_error[0] += value
                count += 1
            elif count == 3:
                store_error[1] += value
                count = 0

    total_error[0] = load_error[0] + store_error[0]
    total_error[1] = load_error[1] + store_error[1]

    load_accuracy.append(((load_error[0] - load_error[1]) / \
            load_error[1]) * 100)
    store_accuracy.append(((store_error[0] - store_error[1]) / \
            store_error[1]) * 100)
    total_accuracy.append(((total_error[0] - total_error[1]) / \
            total_error[1]) * 100)

print(str(geo_mean(load_accuracy)) + '/' + \
        str(geo_mean(store_accuracy)) + '/' + \
        str(geo_mean(total_accuracy)))

for i, accuracy in enumerate(total_accuracy):
    print(app_mixes[i], accuracy)

x = [i for i in range(len(app_mixes))]
x_labels = ["".join([a[0].upper() for a in app_mix]) for app_mix in app_mixes]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

plt.plot(x, load_accuracy, 'rP--', linewidth=2, markersize=25,
        markeredgecolor='k', label='Load', zorder=3)
plt.plot(x, store_accuracy, 'bo--', linewidth=2, markersize=25,
        markeredgecolor='k', label='Store', zorder=3)
plt.plot(x, total_accuracy, 'ks--', linewidth=2, markersize=25,
        markeredgecolor='k', label='Total', zorder=3)

plt.xticks(x, x_labels, fontsize=35)

plt.ylabel('Error (%)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([-40, 15])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/data_predictor_accuracy_total_data_insert.pdf',
        bbox_inches='tight')
