#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\',
        'HetSched': '||', 'ELF': '++'}
marker = {'FCFS': 'o', 'GEDF_D': '*', 'GEDF_N': 'X', 'LAX': 'P',
        'HetSched': 'D', 'ELF': 's'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'HetSched': colormap[11], 'ELF':  colormap[7]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'HetSched': colormap[10],
        'ELF':  colormap[6]}

label = {'GEDF_D': 'GEDF-D', 'GEDF_N': 'GEDF-N', 'ELF': 'RELIEF'}

avg = lambda l : sum(l) / len(l)

def add_avg_plot(offset, policy, label):
    ax1.bar([i+offset for i in x], avg_latency[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=3)
    ax1.bar([i+offset for i in x], avg_latency[policy], fc='none',
            edgecolor='k', width=width, zorder=4)

def add_tail_plot(policy, label):
    ax2.plot(x, tail_latency[policy], linestyle='--', linewidth=2,
            marker=marker[policy], markerfacecolor=edgecolors[policy],
            markersize=25, markeredgecolor='k', label=label, zorder=3)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

avg_latency = {p:[] for p in policies}
tail_latency = {p:[] for p in policies}

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

        warmup_finished = False

        if policy == 'ELF':
            latency = []
            index = 0

            for line in open(dir_name):
                if 'compute' in line: warmup_finished = True
                if not warmup_finished: continue

                if 'Timer #3 stopped' in line:
                    latency.append(float(line.split()[9]) / 1000_000)
                if 'Timer #2 stopped' in line:
                    latency[index] += float(line.split()[9]) / 1000_000
                    index += 1

            avg_latency[policy].append(avg(latency))
            tail_latency[policy].append(max(latency))
            #tail_latency[policy].append(np.percentile(latency, 99))
        else:
            latency = []

            for line in open(dir_name):
                if 'compute' in line: warmup_finished = True
                if not warmup_finished: continue

                if 'Timer #2 stopped' in line:
                    latency.append(float(line.split()[9]) / 1000_000)

            avg_latency[policy].append(avg(latency))
            tail_latency[policy].append(max(latency))
            #tail_latency[policy].append(np.percentile(latency, 99))

x = [i for i in range(len(app_mixes))]
x_labels = ["".join([a[0].upper() for a in app_mix]) for app_mix in app_mixes]

fig, ax1 = plt.subplots(figsize=(24, 12), dpi=600)
ax2 = ax1.twinx()
plt.rc('axes', axisbelow=False)

width = 0.8 / len(policies)
if len(policies) % 2 == 0:
    offset = -width * (0.5 + ((len(policies) / 2) - 1))
else:
    offset = -width * ((len(policies) - 1) / 2)
for policy in policies:
    #plabel = 'ACCL: ' if policy == 'FCFS' else ''
    #plabel += label[policy] if policy in label else policy
    #add_accl_plot(offset, policy, plabel)
    
    plabel = 'Avg: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_avg_plot(offset, policy, plabel)

    plabel = 'Tail: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_tail_plot(policy, plabel)

    offset += width

ax1.set_xticks(x)
ax1.set_xticklabels(x_labels, size=30)
ax1.set_ylabel('Average latency (us)', size=30)
ax1.set_ylim([0, 1.20])
ax1.yaxis.set_major_locator(plt.MultipleLocator(0.15))
ax1.yaxis.set_tick_params(labelsize=30)

ax2.set_ylabel('Tail latency (us)', size=30)
ax2.set_ylim([-4, 4])
ax2.yaxis.set_major_locator(plt.MultipleLocator(1))
ax2.yaxis.set_tick_params(labelsize=30)

ax1.grid(zorder=0, color='silver', linestyle='-', linewidth=1)
h1, l1 = ax1.get_legend_handles_labels()
h2, l2 = ax2.get_legend_handles_labels()
h = [x for z in zip(h2, h1) for x in z]
l = [x for z in zip(l2, l1) for x in z]
ax1.legend(h, l, loc="upper left", ncol=len(policies), fontsize=25)
plt.savefig('../plots/comb_3/scheduler_latency.pdf', bbox_inches='tight')
