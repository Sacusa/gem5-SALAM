#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\',
        'HetSched': '||', 'ELF': '++', 'ELFD': 'xx', 'LL': '--'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'HetSched': colormap[11], 'ELF':  colormap[7],
        'ELFD': colormap[13], 'LL':  colormap[19]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'HetSched': colormap[10],
        'ELF':  colormap[6], 'ELFD': colormap[12], 'LL': colormap[18]}

label = {'GEDF_D': 'GEDF-D', 'GEDF_N': 'GEDF-N', 'ELF': 'RELIEF',
        'ELFD': 'RELIEF-dep'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], occupancy[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], occupancy[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'LL', 'HetSched', 'ELFD', 'ELF']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

occupancy = {p:[] for p in policies}

for policy in policies:
    for app_mix in app_mixes:
        occupancy[policy].append(0)

        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '1_'
            else:              app_mix_str += '0_'

        if 'ELF' in policy:
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    policy + '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    policy + '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_3/' + app_mix_str + policy

        for line in open(dir_name + '/debug-trace.txt'):
            if 'Runtime' in line and 'us' in line:
                occupancy[policy][-1] += float(line.split()[1])

        for line in open(dir_name + '/stats.txt'):
            if 'sim_ticks' in line:
                occupancy[policy][-1] /= float(line.split()[1]) / 1000_000
                break

    occupancy[policy].append(geo_mean(occupancy[policy]))

max_gain = 0
for i in range(len(app_mixes)):
    max_gain = max(max_gain, (occupancy['ELF'][i] - occupancy['LAX'][i]) / \
            occupancy['LAX'][i])
print('ELF over LAX:', max_gain, (occupancy['ELF'][-1]-occupancy['LAX'][-1]) /\
            occupancy['LAX'][-1])

max_gain = 0
for i in range(len(app_mixes)):
    max_gain = max(max_gain, (occupancy['HetSched'][i]-occupancy['ELF'][i]) / \
            occupancy['ELF'][i])
print('HetSched over ELF:', max_gain, (occupancy['HetSched'][-1] - \
        occupancy['ELF'][-1]) / occupancy['ELF'][-1])

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.8 / len(policies)
if len(policies) % 2 == 0:
    offset = -width * (0.5 + ((len(policies) / 2) - 1))
else:
    offset = -width * ((len(policies) - 1) / 2)

policy_offset = {}
for policy in policies:
    policy_offset[policy] = offset
    offset += width
for policy in policies:
    plabel = label[policy] if policy in label else policy
    add_plot(policy_offset[policy], policy, plabel)

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Accelerator occupancy', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 1.7])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=6, fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
#plt.axhline(y=1, color='r', linestyle='-', linewidth=2)
plt.savefig('../plots/comb_3/accelerator_occupancy.pdf', bbox_inches='tight')
