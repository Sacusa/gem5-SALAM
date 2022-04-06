#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'LEDF': '.', 'GEDF': 'xx', 'GLAX': '/'}
NUM_DAG_INSTANCES = 4

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], num_transfers[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], num_transfers[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

max_transfers = []
num_transfers = {p:[] for p in policies}

for app_mix in app_mixes:
    # record maximum number of transfers
    base_dir_name = '/u/sgupta45/scheduler/dags/'
    max_transfers.append(0)

    for app in app_mix:
        contains_transfers = False

        for line in open(base_dir_name + app + '.cfg'):
            if '=' in line: line = line.split('=')[1]
            tokens = line.split()

            if len(tokens) == 2:
                contains_transfers = True
            elif contains_transfers:
                max_transfers[-1] += int(tokens[0])
                contains_transfers = False

        max_transfers[-1] *= NUM_DAG_INSTANCES

    # record number of transfers
    base_dir_name = '../image_' + str(NUM_DAG_INSTANCES) + '_parallel_dma_bus/'
    for app in applications:
        base_dir_name += app + '_'
        if app in app_mix: base_dir_name += str(NUM_DAG_INSTANCES) + '_'
        else:              base_dir_name += '0_'

    for policy in policies:
        num_transfers[policy].append(0)

        for line in open(base_dir_name + policy + '_pipeline/debug-trace.txt'):
            if 'SRC:' in line:
                num_transfers[policy][-1] += 1

for policy in policies:
    # normalize the values
    for i in range(len(max_transfers)):
        num_transfers[policy][i] = (num_transfers[policy][i] / \
                max_transfers[i]) * 100

    # calculate geomean
    num_transfers[policy].append(geo_mean(num_transfers[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Geomean']

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

plt.ylabel('% DMA transfers performed', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 90])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/num_dma_transfers.pdf', bbox_inches='tight')
