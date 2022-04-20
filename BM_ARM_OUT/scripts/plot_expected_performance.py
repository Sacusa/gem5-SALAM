#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'LEDF': '.', 'GEDF': 'xx', 'GLAX': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], stat_value[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], stat_value[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

stat_value = {p:[] for p in policies}

input_file = '/u/sgupta45/gem5-SALAM/benchmarks/scheduler/sw/' + \
        'bin_parallel_dma/expected_performance'

for line in open(input_file):
    tokens = line.strip().split()
    policy = tokens[0][1:-1]

    stat_value[policy].append(float(tokens[21][:-1]))

# Normalize the results and calculate geomean
#for policy in policies:
#    if policy == 'GEDF': continue
#    for i in range(len(stat_value[policy])):
#        stat_value[policy][i] /= stat_value['GEDF'][i]
#    stat_value[policy].append(geo_mean(stat_value[policy]))

x = [i for i in range(len(app_mixes))]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',  'FCFS')
add_plot(-width,     'LEDF',  'GEDF-D')
add_plot(0,          'GEDF',  'GEDF-N')
add_plot(width,      'GLAX',  'LAX')
add_plot((width*2),  'APRX3', 'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Avg. degree of parallelism', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 7.5])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/expected_performance.pdf', bbox_inches='tight')
