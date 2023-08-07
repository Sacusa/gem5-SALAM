#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import re
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\', 'ELF': '++'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'ELF':  colormap[7]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'ELF':  colormap[6]}

def geo_mean(iterable):
    a = np.array([v if v > 0 else 1 for v in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], stat_values[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], stat_values[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

def get_stat(app_mix, stat):
    values = []

    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app == app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        value = 0

        # Get the stat for all policies
        if policy == 'ELF':
            dir_name = '../../comb_pred_1/' + app_mix_str + policy + \
                    '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_1/' + app_mix_str + policy + \
                    '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_1/' + app_mix_str + policy

        for line in open(dir_name + '/stats.txt'):
            if stat in line:
                for t in line.split():
                    try:
                        value = float(t.strip())
                        break
                    except ValueError:
                        continue

        values.append(value)

    return values

if len(sys.argv) != 3:
    print('Usage: ' + sys.argv[0] + ' <stat> <graph label>')
    print('  Suggested stats: sim_ticks, mem_ctrls.bw_total::total')
    exit(-1)

stat = sys.argv[1]
y_label = sys.argv[2]

stat_values = {p:[] for p in policies}

# read the statistics
for app_mix in applications:
    output = get_stat(app_mix, stat)

    for i, policy in enumerate(policies):
        stat_values[policy].append(output[i])

    # normalize the values
    norm_value = stat_values['LAX'][-1]
    for policy in policies:
        if norm_value == 0:
            stat_values[policy][-1] = 0
        else:
            stat_values[policy][-1] /= norm_value

# calculate geo-mean for each policy
for policy in policies:
    stat_values[policy].append(geo_mean(stat_values[policy]))

# plot parameters
x = np.arange(len(applications) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 'FCFS',   'FCFS')
add_plot(-(width/2),     'GEDF_D', 'GEDF-D')
add_plot((width/2),      'GEDF_N', 'GEDF-N')
add_plot((3*width)/2,    'ELF',    'RELIEF')

x_labels = [app[0].upper() for app in applications] + ['Gmean']
plt.xticks(x, x_labels, fontsize=30)

plt.ylabel(y_label + '\n(norm. to LAX)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 1.8])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=2, fontsize=30)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
filename = '_'.join([re.sub('[^A-Za-z0-9]+', '', t.lower())
    for t in y_label.split()])
plt.savefig('../plots/comb_1/' + filename + '.pdf', bbox_inches='tight')
