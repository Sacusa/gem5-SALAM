#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'ELF': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        return plt.bar([i+offset for i in x], num_colocations[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        return plt.bar([i+offset for i in x], num_colocations[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

num_colocations = {p:[] for p in policies}

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

        num_colocations[policy].append(0)

        for line in open(dir_name):
            if 'Number of colocations' in line:
                num_colocations[policy][-1] = int(line.split()[6])

    # normalize the values
    norm_value = num_colocations['LAX'][-1]
    for policy in policies:
        num_colocations[policy][-1] /= norm_value

# calculate geomean
for policy in policies:
    num_colocations[policy].append(geo_mean(num_colocations[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.20
plt.bar_label(add_plot(-((3*width)/2), 'FCFS',   'FCFS'), fmt='%0.2f')
plt.bar_label(add_plot(-(width/2),     'GEDF_D', 'GEDF-D'), fmt='%0.2f')
plt.bar_label(add_plot((width/2),      'GEDF_N', 'GEDF-N'), fmt='%0.2f')
plt.bar_label(add_plot((3*width)/2,    'ELF',    'ELF'), fmt='%0.2f')

plt.xticks(x, x_labels, fontsize=35)

plt.ylabel('Number of colocations\n(norm. to LAX)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 9])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(1))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/num_colocations.pdf', bbox_inches='tight')
