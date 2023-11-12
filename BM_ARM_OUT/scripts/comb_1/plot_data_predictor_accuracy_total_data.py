#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array([1 if i == 0 else abs(i) for i in iterable])
    return a.prod()**(1.0/len(a))

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

load_accuracy = []
store_accuracy = []
total_accuracy = []

for app_mix in applications:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app == app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    dir_name = '../../comb_1_enhanced/' + app_mix_str + 'ELF/debug-trace.txt'

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
print(load_accuracy)
print(store_accuracy)
print(total_accuracy)

x = [i for i in range(len(applications))]
x_labels = [a[0].upper() for a in applications]

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
plt.savefig('../plots/comb_1/data_predictor_accuracy_total_data_insert.pdf',
        bbox_inches='tight')
