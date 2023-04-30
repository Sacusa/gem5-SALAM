#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

linestyle = {'last_val': 'bo--', 'average': 'g*--', 'ewma': 'ys--'}

def geo_mean(iterable):
    a = np.array([abs(i) for i in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(policy, label):
    if policy == 'last_val':
        plt.plot(x, compute_accuracy, 'kX-', linewidth=2,
                markersize=18, markeredgecolor='k', label='Compute', zorder=3)

    plt.plot(x, memory_accuracy[policy], linestyle[policy], linewidth=2,
            markersize=18, markeredgecolor='k', label=label, zorder=3)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['last_val', 'average', 'ewma']
policies = ['last_val']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

compute_accuracy = []
memory_accuracy = {p:[] for p in policies}

##########################################
############ COMPUTE ACCURACY ############
##########################################
for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    actual_compute_time = 0
    predicted_compute_time = 0

    dir_name = '../comb_4/' + app_mix_str + 'ELF/debug-trace.txt'

    for line in open(dir_name):
        if 'Runtime' in line and 'us' in line:
            actual_compute_time += float(line.split()[1])
        elif 'Total predicted compute time' in line:
            predicted_compute_time = float(line.split()[7])

    compute_accuracy.append(((predicted_compute_time - \
            actual_compute_time) / actual_compute_time) * 100)

compute_accuracy.append(geo_mean(compute_accuracy))

#########################################
############ MEMORY ACCURACY ############
#########################################
for policy in policies:
    for app_mix in app_mixes:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '4_'
            else:              app_mix_str += '0_'

        if policy == 'last_val':
            dir_name = '../comb_4/' + app_mix_str + 'ELF/debug-trace.txt'
        else:
            dir_name = '../comb_pred_4/' + app_mix_str + 'ELF_' + policy + '/debug-trace.txt'

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

        memory_accuracy[policy].append(((error[0] - error[1]) / error[1]) * 100)

    memory_accuracy[policy].append(geo_mean(memory_accuracy[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

add_plot('last_val', 'Last value')
#add_plot('average', 'Average')
#add_plot('ewma', 'EWMA')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Error (%)', fontsize=35)
plt.yticks(fontsize=35)
#plt.ylim([-25, 700])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(100))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/predictor_accuracy_insert.pdf', bbox_inches='tight')
