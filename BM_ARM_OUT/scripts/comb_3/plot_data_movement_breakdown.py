#! /u/sgupta45/conda/bin/python3
from matplotlib.cm import get_cmap
import itertools
import matplotlib
matplotlib.use('Agg')
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

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

def geo_mean(iterable):
    #a = np.array([i if i != 0 else 1 for i in iterable])
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_dram_dm_plot(offset, policy, label):
    plt.bar([i+offset for i in x], dram_dm[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], dram_dm[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

def add_fwd_dm_plot(offset, policy, label):
    plt.bar([i+offset for i in x], fwd_dm[policy], edgecolor='k', width=width,
            label=label, fc=colors[policy], bottom=dram_dm[policy])
    #plt.bar([i+offset for i in x], fwd_dm[policy],
    #        edgecolor=edgecolors[policy], width=width, label=label,
    #        fc=colors[policy], hatch=hatch[policy]*2, bottom=dram_dm[policy],
    #        zorder=1)
    #plt.bar([i+offset for i in x], fwd_dm[policy], fc='none',
    #        edgecolor='k', width=width, bottom=dram_dm[policy], zorder=2)

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

baseline_dm = {'canny': 1639088, 'deblur': 3458540, 'gru': 22544384,
        'harris': 2556796, 'lstm': 25690112}

dram_dm = {p:[] for p in policies}
fwd_dm = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    total_dm = 0

    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix:
            app_mix_str += '1_'
            total_dm += baseline_dm[app]
        else:
            app_mix_str += '0_'

    for policy in policies:
        dram_dm[policy].append(0)
        fwd_dm[policy].append(0)

        if policy == 'ELF':
            dir_name = '../../comb_pred_3_opt_flush_opt_fwd/' + app_mix_str + \
                    policy + '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_3_opt_flush_opt_fwd/' + app_mix_str + \
                    policy + '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_3_opt_flush_opt_fwd/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        for line in open(dir_name):
            if '0x000000008' in line:
                dram_dm[policy][-1] += int(line.split()[4][4:])
            elif ('SRC:0x000000002' in line) and ('DST:0x000000002' in line):
                fwd_dm[policy][-1] += int(line.split()[4][4:])

        # normalize the values
        dram_dm[policy][-1] = (dram_dm[policy][-1] / total_dm) * 100
        fwd_dm[policy][-1]  = (fwd_dm[policy][-1]  / total_dm) * 100

# calculate geomean
for policy in policies:
    dram_dm[policy].append(geo_mean(dram_dm[policy]))
    fwd_dm[policy].append(geo_mean(fwd_dm[policy]))

print((dram_dm['LAX'][-1] - dram_dm['ELF'][-1]) / dram_dm['LAX'][-1])
print((dram_dm['HetSched'][-1] - dram_dm['ELF'][-1]) / dram_dm['HetSched'][-1])
max_gain = 0
for i in range(len(app_mixes)):
    for policy in policies:
        max_gain = max(max_gain, (dram_dm[policy][i] - dram_dm['ELF'][i]) / \
                dram_dm[policy][i])
print(max_gain)

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
    add_fwd_dm_plot(offset, policy, plabel)

    plabel = 'DRAM: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_dram_dm_plot(offset, policy, plabel)

    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Data movement (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 140])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/data_movement_breakdown.pdf', bbox_inches='tight')
