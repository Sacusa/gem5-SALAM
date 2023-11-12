#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

linestyle = {'20': 'bo--', '15': 'rP--', '10': 'g*--', '5': 'ks--'}

def geo_mean(iterable):
    a = np.array([abs(i) for i in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(alpha):
    plt.plot(x, accuracy[alpha], linestyle[alpha], linewidth=2,
            markersize=18, markeredgecolor='k', label=alpha, zorder=3)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
alphas = ['20', '15', '10', '5']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

accuracy = {a:[] for a in alphas}
accuracy['NO_PRED'] = []  # baseline

for alpha in alphas:
    for app_mix in app_mixes:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '1_'
            else:              app_mix_str += '0_'

        if alpha == 'NO_PRED':
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    'ELF_MEM_PRED_NO_PRED/debug-trace.txt'
        else:
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    'ELF_MEM_PRED_AVERAGE_' + alpha + '/debug-trace.txt'

        predicted_bw_insertion = 0
        predicted_bw_launch = 0
        actual_bw_load = 0
        actual_bw_store = 0

        error = [0, 0]

        count = 0

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
                            actual_bw_total = (actual_bw_load + actual_bw_store) / 2
                        elif actual_bw_load > 0:
                            actual_bw_total = actual_bw_load
                        elif actual_bw_store > 0:
                            actual_bw_total = actual_bw_store

                        if actual_bw_total > 0:
                            error[0] += predicted_bw_insertion
                            error[1] += actual_bw_total

                    count = 0

        accuracy[alpha].append(((error[0] - error[1]) / error[1]) * 100)

    print(str(alpha) + ': ' + str(geo_mean(accuracy[alpha])))

x = [i for i in range(len(app_mixes))]
x_labels = ["".join([a[0].upper() for a in app_mix]) for app_mix in app_mixes]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

add_plot('20')
add_plot('15')
add_plot('10')
add_plot('5')

plt.xticks(x, x_labels, fontsize=35)

plt.ylabel('Error (%)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([-20, 15])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/predictor_accuracy_average.pdf',
        bbox_inches='tight')
