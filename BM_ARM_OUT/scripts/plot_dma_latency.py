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

for app_mix in app_mixes:
    base_dir_name = '../image_4_parallel_dma_bus/'
    for app in applications:
        base_dir_name += app + '_'
        if app in app_mix: base_dir_name += '4_'
        else:              base_dir_name += '0_'

    for policy in policies:
        latencies = []
        valid_dma = False

        for line in open(base_dir_name + policy + '_pipeline/debug-trace.txt'):
            if 'Transfer completed' in line:
                latencies.append(float(line.split()[5]))

        stat_value[policy].append(sum(latencies) / 1000)

print(stat_value['APRX3'][1] - stat_value['GEDF'][1])

# Normalize and calculate geomean
for policy in policies:
    if policy == 'GEDF': continue

    for i in range(len(stat_value[policy])):
        stat_value[policy][i] /= stat_value['GEDF'][i]

    stat_value[policy].append(geo_mean(stat_value[policy]))

print(stat_value['APRX3'][1])

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Geomean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 'FCFS',  'FCFS')
add_plot(-(width/2),     'LEDF',  'GEDF-D')
add_plot((width/2),      'GLAX',  'LAX')
add_plot(((3*width)/2),  'APRX3', 'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Total DMA latency\n(norm. to GEDF-N)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0.4, 1.3])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/dma_latency.pdf', bbox_inches='tight')
