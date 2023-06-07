#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import re
import sys

hatch = {'LAST_VAL': '*', 'EWMA_0.25': '/'}

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

policies = ['LAST_VAL', 'NO_PRED', 'AVERAGE_15', 'EWMA_0.25']
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

        # Get the stat for all policies
        if policy == 'LAST_VAL':
            dir_name = '../../comb_3/' + app_mix_str + 'ELF'
        else:
            dir_name = '../../comb_pred_3/' + app_mix_str + 'ELF_MEM_PRED_' + \
                       policy

        for line in open(dir_name + '/stats.txt'):
            if 'sim_ticks' in line:
                value = int(line.split()[1])
                break
        #for line in open(dir_name + '/debug-trace.txt'):
        #    if 'Number of node deadlines' in line:
        #        value = int(line.split()[8])
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
    norm_value = stat_values['NO_PRED'][-1]
    for policy in policies:
        stat_values[policy][-1] /= norm_value

# calculate geo-mean for each policy
for policy in policies:
    stat_values[policy].append(geo_mean(stat_values[policy]))

print(stat_values['AVERAGE_15'])

# plot parameters
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.27
add_plot(-width, 'LAST_VAL',   'Last')
add_plot(0,      'EWMA_0.25',  'EWMA')
add_plot(width,  'AVERAGE_15', 'Avg')

x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']
plt.xticks(x, x_labels, fontsize=35)

plt.ylabel('Execution time\n(norm. to no predictor)', fontsize=35)
#plt.ylabel('Node deadlines met\n(norm. to no predictor)', fontsize=35)
plt.yticks(fontsize=35)
#plt.ylim([0, 1.8])
plt.ylim([0, 1.4])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('../plots/comb_3/predictor_performance.pdf', bbox_inches='tight')
