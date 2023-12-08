#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\',
        'HetSched': '||', 'ELF': '++'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'HetSched': colormap[11], 'ELF':  colormap[7]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'HetSched': colormap[10],
        'ELF':  colormap[6]}

label = {'GEDF_D': 'GEDF-D', 'GEDF_N': 'GEDF-N', 'ELF': 'RELIEF'}

def geo_mean(iterable):
    #a = np.array([i if i > 0 else 1 for i in iterable])
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def harmonic_mean(iterable):
    return len(iterable) / sum(1/i for i in iterable)

def add_dram_plot(offset, policy, label):
    plt.bar([i+offset for i in x], dram_dm[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], dram_dm[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

def add_spad_plot(offset, policy, label):
    plt.bar([i+offset for i in x], spad_dm[policy], edgecolor='k',
            width=width, label=label, fc=colors[policy],
            bottom=dram_dm[policy])

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

baseline_dm = {'canny': 1639088, 'deblur': 3458540, 'gru': 22544384,
        'harris': 2556796, 'lstm': 25690112}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

dram_dm = {p:[] for p in policies}
spad_dm = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        iterations = []
        dram_dm[policy].append(0)
        spad_dm[policy].append(0)

        dir_name = '../../comb_3_repeat_time_50000/' + \
                app_mix_str + policy + '/debug-trace.txt'

        for line in open(dir_name):
            if 'Finished DAG iterations' in line:
                iterations.append(int(line.split()[6]))
            elif 'DRAM data movement' in line:
                dram_dm[policy][-1] += int(line.split()[6])
            elif 'SPAD data movement' in line:
                spad_dm[policy][-1] += int(line.split()[6])

        norm_value = 0
        for i, app in enumerate(app_mix):
            norm_value += baseline_dm[app] * iterations[i]

        dram_dm[policy][-1] /= (norm_value / 100)
        spad_dm[policy][-1] /= (norm_value / 100)

# calculate geomean
for policy in policies:
    dram_dm[policy].append(geo_mean(dram_dm[policy]))
    spad_dm[policy].append(geo_mean(spad_dm[policy]))

max_gain = 0
for i in range(len(app_mixes)):
    for policy in policies:
        max_gain = max(max_gain, (dram_dm[policy][i] - dram_dm['ELF'][i]) / \
                dram_dm[policy][i])
print(max_gain)
print((dram_dm['HetSched'][-1] - dram_dm['ELF'][-1]) / dram_dm['HetSched'][-1])

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
for policy in policies:
    plabel = 'SPAD: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_spad_plot(offset, policy, plabel)

    plabel = 'DRAM: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_dram_plot(offset, policy, plabel)

    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Data movement (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 140])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/data_movement_breakdown.pdf',
        bbox_inches='tight')
