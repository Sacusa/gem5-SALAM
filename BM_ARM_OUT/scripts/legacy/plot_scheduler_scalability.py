#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

def add_plot(x_values, linestyle, label):
    plt.plot(x, x_values, linestyle, linewidth=2, markersize=16,
            markeredgecolor='k', label=label)

applications = ['canny', 'deblur_5', 'gru_8', 'harris', 'lstm_8']
policies = ['GEDF', 'APRX3']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])
max_num_copies = 9

linestyle = {'GEDF': 'k*--', 'APRX3': 'ro--'}

for app_mix in app_mixes:
    latency = {p:[] for p in policies}

    app_mix_str = ''
    for app in applications:
        if app in app_mix: app_mix_str += app + '_'

    for policy in policies:
        for num_copies in range(1, max_num_copies+1):
            for line in open('../scheduler_scalability/scheduler_' + policy + \
                    '_' + app_mix_str + str(num_copies) + '/stats.txt'):
                if 'sim_ticks' in line:
                    latency[policy].append(int(line.split()[1]))
                    break

        norm_value = latency[policy][0]
        for i in range(len(latency[policy])):
            latency[policy][i] /= norm_value

    print(app_mix_str)
    print('  ' + str(latency['GEDF']))
    print('  ' + str(latency['APRX3']))

    x = [i for i in range(num_copies)]
    x_labels = [str(i+1) for i in range(num_copies)]

    plt.clf()
    plt.figure(figsize=(24, 8), dpi=600)
    plt.rc('axes', axisbelow=True)

    for policy in policies:
        add_plot(latency[policy], linestyle[policy], policy)

    plt.xlabel('Number of copies', fontsize=35)
    plt.xticks(x, x_labels, fontsize=35)

    plt.ylabel('Latency (norm. to single copy)', fontsize=35)
    plt.yticks(fontsize=35)
    #plt.ylim([0, 1.7])
    #plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

    plt.title(app_mix_str)
    plt.legend(loc="upper left", ncol=5, fontsize=35)
    plt.grid(color='silver', linestyle='-', linewidth=1)
    plt.savefig('plots/scheduler_scalability/' + app_mix_str[:-1] + '.png',
            bbox_inches='tight')
