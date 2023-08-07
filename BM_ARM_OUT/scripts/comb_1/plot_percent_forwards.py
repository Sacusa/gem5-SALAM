#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\', 'ELF': '++'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'ELF':  colormap[7]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'ELF':  colormap[6]}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], num_forwards[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], num_forwards[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

num_edges = {'canny': 14, 'deblur': 30, 'gru': 149, 'harris': 22,
        'lstm': 174}

num_forwards = {p:[] for p in policies}

for app_mix in applications:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app == app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        if policy == 'ELF':
            dir_name = '../../comb_pred_1/' + app_mix_str + policy + \
                    '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_1/' + app_mix_str + policy + \
                    '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_1/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        num_forwards[policy].append(0)

        for line in open(dir_name):
            if 'Number of forwards' in line:
                num_forwards[policy][-1] = int(line.split()[6])

    # normalize the values
    norm_value = num_edges[app_mix]
    for policy in policies:
        num_forwards[policy][-1] = \
                (num_forwards[policy][-1] / norm_value) * 100

# calculate geomean
for policy in policies:
    num_forwards[policy].append(geo_mean(num_forwards[policy]))

x = [i for i in range(len(applications) + 1)]
x_labels = [app[0].upper() for app in applications] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',   'FCFS')
add_plot(-width,     'GEDF_D', 'GEDF-D')
add_plot(0,          'GEDF_N', 'GEDF-N')
add_plot(width,      'LAX',    'LAX')
add_plot((width*2),  'ELF',    'RELIEF')

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Forwards / edges (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 100])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(10))

plt.legend(loc="upper left", ncol=5, fontsize=30)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_1/percent_forwards.pdf', bbox_inches='tight')
