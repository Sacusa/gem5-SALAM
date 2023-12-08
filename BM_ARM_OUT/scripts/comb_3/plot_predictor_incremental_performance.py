#! /u/sgupta45/conda/bin/python3
from matplotlib.cm import get_cmap
import itertools
import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
import matplotlib.pyplot as plt
import numpy as np
import re
import sys

hatch = {'real_bw/max_dm': '*', 'max_bw/real_dm': '/', 'real_bw/real_dm': '.'}

colormap = get_cmap("tab20").colors
colors = {'real_bw/max_dm': colormap[1], 'max_bw/real_dm': colormap[3],
        'real_bw/real_dm': colormap[5]}
edgecolors = {'real_bw/max_dm': colormap[0], 'max_bw/real_dm': colormap[2],
        'real_bw/real_dm': colormap[4]}

def geo_mean(iterable):
    a = np.array([v if v > 0 else 1 for v in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], stat_values[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], stat_values[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

policies = ['max_bw/max_dm', 'real_bw/max_dm', 'max_bw/real_dm',
        'real_bw/real_dm']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

def get_stat(app_mix):
    values = []

    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        value = 0

        dir_name = '../../comb_pred_3/' + app_mix_str + \
                'ELF_MEM_PRED_'
        if 'max_bw' in policy:
            dir_name += 'NO_PRED'
        else:
            dir_name += 'AVERAGE_15'
        dir_name += '_dm_'
        if 'max_dm' in policy:
            dir_name += 'false'
        else:
            dir_name += 'true'


        #for line in open(dir_name + '/stats.txt'):
        #    if 'sim_ticks' in line:
        #        value = int(line.split()[1])
        #        break
        for line in open(dir_name + '/debug-trace.txt'):
            if 'Number of node deadlines' in line:
                value = int(line.split()[8])
                break
        #for line in open(dir_name + '/debug-trace.txt'):
        #    if 'Number of forwards' in line:
        #        value = int(line.split()[6])
        #        break

        values.append(value)

    return values

app_mixes = sorted(list(itertools.combinations(applications, 3)))
stat_values = {p:[] for p in policies}

# read the statistics
for app_mix in app_mixes:
    output = get_stat(app_mix)

    for i, policy in enumerate(policies):
        stat_values[policy].append(output[i])

    # normalize the values
    norm_value = stat_values['max_bw/max_dm'][-1]
    for policy in policies:
        stat_values[policy][-1] /= norm_value

# calculate geo-mean for each policy
for policy in policies:
    stat_values[policy].append(geo_mean(stat_values[policy]))
    print(policy + ': ' + str(stat_values[policy]))

# plot parameters
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.27
add_plot(-width, 'real_bw/max_dm',  'Pred. BW')
add_plot(0,      'max_bw/real_dm',  'Pred. DM')
add_plot(width,  'real_bw/real_dm', 'Pred. BW + Pred. DM')

x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']
plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Node deadlines met\n(norm. to max predictors)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 1.3])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('../plots/comb_3/predictor_incremental_performance.pdf',
        bbox_inches='tight')
