#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'LEDF': '.', 'GLAX': 'xx', 'APRX3': '/'}

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
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3', 'xbar']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

num_transfers = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        num_transfers[policy].append(0)

        if policy == 'xbar':
            dir_name = '../image_4_parallel_dma_xbar/' + app_mix_str + 'APRX3'
        else:
            dir_name = '../image_4_parallel_dma_bus/' + app_mix_str + policy
        dir_name += '_pipeline/debug-trace.txt'

        for line in open(dir_name):
            if 'SRC:' in line:
                num_transfers[policy][-1] += 1

for policy in policies:
    if policy == 'GEDF': continue

    # normalize the values
    for i in range(len(num_transfers[policy])):
        num_transfers[policy][i] /= num_transfers['GEDF'][i]

    # calculate geomean
    num_transfers[policy].append(geo_mean(num_transfers[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',  'FCFS')
add_plot(-width,     'LEDF',  'GEDF-D')
add_plot(0,          'GLAX',  'LAX')
add_plot(width,      'APRX3', 'ELF')
add_plot((width*2),  'xbar',  'ELF-xbar')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Number of DMA transfers\n(norm. to GEDF-N)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.7])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/num_dma_transfers.pdf', bbox_inches='tight')
