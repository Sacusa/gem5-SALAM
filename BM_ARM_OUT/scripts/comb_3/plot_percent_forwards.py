#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'LAX': 'xx', 'ELF': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], num_forwards[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], num_forwards[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

num_edges = {'canny': 14, 'deblur': 30, 'gru': 149, 'harris': 22,
        'lstm': 174}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

num_forwards = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        if policy in ['LAX', 'ELF']:
            dir_name = '../../comb_pred_3/' + app_mix_str + policy + \
                    '_MEM_PRED_AVERAGE_15'
        else:
            dir_name = '../../comb_3/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        num_forwards[policy].append(0)

        for line in open(dir_name):
            if 'Number of forwards' in line:
                num_forwards[policy][-1] = int(line.split()[6])

    # normalize the values
    norm_value = sum([num_edges[app] for app in app_mix])
    for policy in policies:
        num_forwards[policy][-1] = (num_forwards[policy][-1] / norm_value) * 100

# calculate geomean
for policy in policies:
    num_forwards[policy].append(geo_mean(num_forwards[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',   'FCFS')
add_plot(-width,     'GEDF_D', 'GEDF-D')
add_plot(0,          'GEDF_N', 'GEDF-N')
add_plot(width,      'LAX',    'LAX')
add_plot((width*2),  'ELF',    'ELF')

plt.xticks(x, x_labels, fontsize=35)

plt.ylabel('Forwards / edges (%)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 100])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/percent_forwards.pdf', bbox_inches='tight')
