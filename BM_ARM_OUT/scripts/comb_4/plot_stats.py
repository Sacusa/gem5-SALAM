#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import re
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'ELF': '/'}

def geo_mean(iterable):
    a = np.array([v if v > 0 else 1 for v in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], stat_values[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], stat_values[policy], edgecolor='k',
                width=width, label=label, fc='k')

policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

def get_stat(app_mix, stat):
    values = []

    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        value = 0

        # Get the stat for all policies
        #if policy in ['LAX', 'ELF']:
        #    dir_name = '../../comb_pred_4/' + app_mix_str + 'ELF_MEM_PRED_AVERAGE_15'
        #else:
        #    dir_name = '../../comb_4/' + app_mix_str + policy
        dir_name = '../../comb_4/' + app_mix_str + policy

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

app_mixes = sorted(list(itertools.combinations(applications, 4)))
stat_values = {p:[] for p in policies}

# read the statistics
for app_mix in app_mixes:
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
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 'FCFS',   'FCFS')
add_plot(-(width/2),     'GEDF_D', 'GEDF-D')
add_plot((width/2),      'GEDF_N', 'GEDF-N')
add_plot((3*width)/2,    'ELF',    'ELF')

x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']
plt.xticks(x, x_labels, fontsize=35)

plt.ylabel(y_label + '\n(norm. to LAX)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.8])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
filename = '_'.join([re.sub('[^A-Za-z0-9]+', '', t.lower())
    for t in y_label.split()])
plt.savefig('../plots/comb_4/' + filename + '.pdf', bbox_inches='tight')
