#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'LAX': 'xx', 'ELF': '/'}

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], avg_parallelism[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], avg_parallelism[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

avg_parallelism = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        total_parallelism = 0

        first_tick = 0
        last_tick = 0
        last_parallelism = 0

        if policy in ['FCFS', 'GEDF_D']:
            dir_name = '../comb_4_scheds/'
        else:
            dir_name = '../comb_4/'
        dir_name += app_mix_str + policy + '/debug-trace.txt'

        for line in open(dir_name):
            if 'Number of accelerators running' in line:
                tokens = line.strip().split()

                tick = int(tokens[0][:-1])

                if first_tick == 0:
                    first_tick = tick
                else:
                    total_parallelism += last_parallelism * (tick - last_tick)

                last_tick = tick
                last_parallelism = int(tokens[7])

                if last_parallelism == 0:
                    avg_parallelism[policy].append(total_parallelism / \
                            (tick - first_tick))
                    break

        if last_parallelism != 0:
            avg_parallelism[policy].append(0)

x = [i for i in range(len(app_mixes))]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',   'FCFS')
add_plot(-width,     'GEDF_D', 'GEDF-D')
add_plot(0,          'GEDF_N', 'GEDF-N')
add_plot(width,      'LAX',    'LAX')
add_plot((width*2),  'ELF',    'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Average degree of\nparallelism', fontsize=35)
plt.yticks(fontsize=35)
#plt.ylim([0, 9])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/avg_degree_of_parallelism.pdf', bbox_inches='tight')
