#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'LAX': 'xx', 'ELF': '/'}
linestyle = {'FCFS': 'bo--', 'GEDF_D': 'g*--', 'GEDF_N': 'yX--',
        'LAX': 'rP--', 'ELF': 'ks--'}

avg = lambda l : sum(l) / len(l)

def add_avg_plot(offset, policy, label):
    if policy in hatch:
        ax1.bar([i+offset for i in x], avg_latency[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy],
                zorder=3)
    else:
        ax1.bar([i+offset for i in x], avg_latency[policy], edgecolor='k',
                width=width, label=label, fc='k', zorder=3)

def add_tail_plot(policy, label):
    ax2.plot(x, tail_latency[policy], linestyle[policy], linewidth=2,
            markersize=25, markeredgecolor='k', label=label, zorder=3)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

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
        if policy in ['LAX', 'ELF']:
            dir_name = '../../comb_pred_3/' + app_mix_str + policy + \
                    '_MEM_PRED_AVERAGE_15'
        else:
            dir_name = '../../comb_3/' + app_mix_str + policy
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

fig, ax1 = plt.subplots(figsize=(24, 15), dpi=600)
ax2 = ax1.twinx()
plt.rc('axes', axisbelow=False)

width = 0.16
add_avg_plot(-(width*2), 'FCFS',  'FCFS')
add_avg_plot(-width,     'GEDF_D',  'GEDF-D')
add_avg_plot(0,          'GEDF_N', 'GEDF-N')
add_avg_plot(width,      'LAX',    'LAX')
add_avg_plot((width*2),  'ELF',    'ELF')

add_tail_plot('FCFS',   'FCFS')
add_tail_plot('GEDF_D', 'GEDF-D')
add_tail_plot('GEDF_N', 'GEDF-N')
add_tail_plot('LAX',    'LAX')
add_tail_plot('ELF',    'ELF')

ax1.set_xticks(x)
ax1.set_xticklabels(x_labels, size=35)
ax1.set_ylabel('Average latency (us)', size=35)
ax1.set_ylim([0, 1.05])
ax1.yaxis.set_major_locator(plt.MultipleLocator(0.15))
ax1.yaxis.set_tick_params(labelsize=35)

ax2.set_ylabel('Tail latency (us)', size=35)
ax2.set_ylim([-1.5, 2])
ax2.yaxis.set_major_locator(plt.MultipleLocator(0.5))
ax2.yaxis.set_tick_params(labelsize=35)

ax1.grid(zorder=0, color='silver', linestyle='-', linewidth=1)
h1, l1 = ax1.get_legend_handles_labels()
h2, l2 = ax2.get_legend_handles_labels()
h = [x for z in zip(h1, h2) for x in z]
l = [x for z in zip(l1, l2) for x in z]
ax1.legend(h, l, loc="upper left", ncol=5, fontsize=35)
plt.savefig('../plots/comb_3/scheduler_latency.pdf', bbox_inches='tight')
