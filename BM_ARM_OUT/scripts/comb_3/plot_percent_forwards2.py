#! /u/sgupta45/conda/bin/python3
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

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def harmonic_mean(iterable):
    return len(iterable) / sum(1/i for i in iterable)

def add_fwd_plot(offset, policy, label):
    plt.bar([i+offset for i in x], forwards_only[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], forwards_only[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

def add_col_plot(offset, policy, label):
    plt.bar([i+offset for i in x], num_colocations[policy], edgecolor='k',
            width=width, label=label, fc=colors[policy],
            bottom=forwards_only[policy])

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

num_edges = {'canny': 14, 'deblur': 30, 'gru': 149, 'harris': 22,
        'lstm': 174}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

num_forwards = {p:[] for p in policies}
forwards_only = {p:[] for p in policies}
num_colocations = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        if policy == 'ELF':
            dir_name = '../../comb_pred_3_opt_flush_opt_fwd/' + app_mix_str + \
                    policy + '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_3_opt_flush_opt_fwd/' + app_mix_str + \
                    policy + '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_3_opt_flush_opt_fwd/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        num_forwards[policy].append(0)
        num_colocations[policy].append(0)

        for line in open(dir_name):
            if 'Number of forwards' in line:
                num_forwards[policy][-1] += int(line.split()[6])
            elif 'Number of colocations' in line:
                num_colocations[policy][-1] += int(line.split()[6])

    # normalize the values
    norm_value = sum([num_edges[app] for app in app_mix])
    for policy in policies:
        forwards_only[policy].append(((num_forwards[policy][-1] - \
                num_colocations[policy][-1]) / norm_value) * 100)
        num_forwards[policy][-1] = (num_forwards[policy][-1] / norm_value) * \
                100
        num_colocations[policy][-1] = (num_colocations[policy][-1] / \
                norm_value) * 100

# calculate geomean
for policy in policies:
    avg_percent_colocations = geomean([num_colocations[policy][i] / \
            num_forwards[policy][i] for i in range(len(num_forwards[policy]))])
    avg_forwards = geo_mean(num_forwards[policy])

    forwards_only[policy].append(avg_forwards * (1 - avg_percent_colocations))
    num_colocations[policy].append(avg_forwards * avg_percent_colocations)

max_fwd = 0
for i in range(len(app_mixes)):
    for policy in policies:
        max_fwd = max(max_fwd, num_forwards['ELF'][i] / num_forwards[policy][i])
print(max_fwd)
print(geo_mean(num_forwards['ELF']) / geo_mean(num_forwards['LAX']))

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
    plabel = 'COL: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_col_plot(offset, policy, plabel)

    plabel = 'FWD: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_fwd_plot(offset, policy, plabel)

    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Forwards / edges (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 140])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/percent_forwards2.pdf', bbox_inches='tight')
