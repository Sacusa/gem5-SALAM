#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'LAX': '\\', 'ELF': '++', 'ELF-xbar': 'x'}
marker = {'LAX': 'P', 'ELF': 's', 'ELF-xbar': 'd'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'LAX': colormap[9], 'ELF':  colormap[7], 'ELF-xbar': colormap[11]}
edgecolors = {'LAX': colormap[8], 'ELF':  colormap[6],
        'ELF-xbar': colormap[10]}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_bar_plot(offset, policy, label):
    ax1.bar([i+offset for i in x], occupancy[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=3)
    ax1.bar([i+offset for i in x], occupancy[policy], fc='none',
            edgecolor='k', width=width, zorder=4)

def add_line_plot(policy, label):
    ax2.plot(x, execution_time[policy], linestyle='--', linewidth=2,
            marker=marker[policy], markerfacecolor=edgecolors[policy],
            markersize=25, markeredgecolor='k', label=label, zorder=3)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['LAX', 'ELF', 'ELF-xbar']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

occupancy = {p:[] for p in policies}
execution_time = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        if policy == 'LAX':
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    policy + '_MEM_PRED_EWMA_0.25_dm_false'
        elif policy == 'ELF':
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    policy + '_MEM_PRED_NO_PRED_dm_false'
        else:
            dir_name = '../../comb_pred_3_xbar/' + \
                    app_mix_str + 'ELF_MEM_PRED_NO_PRED_dm_false'
        dir_name += '/stats.txt'

        for line in open(dir_name):
            if 'sim_ticks' in line:
                execution_time[policy].append(float(line.split()[1]))
            elif 'system.acctest.local_bus.utilization' in line:
                occupancy[policy].append(float(line.split()[1]))
                break

    occupancy_norm_value = occupancy['LAX'][-1]
    execution_time_norm_value = execution_time['LAX'][-1]

    for policy in policies:
        execution_time[policy][-1] /= execution_time_norm_value

for policy in policies:
    occupancy[policy].append(geo_mean(occupancy[policy]))
    execution_time[policy].append(geo_mean(execution_time[policy]))

for i in range(len(app_mixes) + 1):
    print((occupancy['LAX'][i] - occupancy['ELF'][i]) / occupancy['LAX'][i])

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

fig, ax1 = plt.subplots(figsize=(24, 12), dpi=600)
ax2 = ax1.twinx()
plt.rc('axes', axisbelow=False)

width = 0.2
add_bar_plot(-width, 'LAX',      'Occupancy: LAX')
add_bar_plot(0,      'ELF',      'RELIEF-Bus')
add_bar_plot(width,  'ELF-xbar', 'RELIEF-XBar')

add_line_plot('LAX',      'Exec. time: LAX')
add_line_plot('ELF',      'RELIEF-Bus')
add_line_plot('ELF-xbar', 'RELIEF-XBar')

ax1.set_xticks(x)
ax1.set_xticklabels(x_labels, size=30)
ax1.set_ylabel('Interconnect occupancy (%)', size=30)
ax1.set_ylim([0, 70])
ax1.yaxis.set_major_locator(plt.MultipleLocator(10))
ax1.yaxis.set_tick_params(labelsize=30)

ax2.set_ylabel('Execution time (norm. to LAX)', size=30)
ax2.set_ylim([0, 1.4])
ax2.yaxis.set_major_locator(plt.MultipleLocator(0.2))
ax2.yaxis.set_tick_params(labelsize=30)

ax1.grid(zorder=0, color='silver', linestyle='-', linewidth=1)

h1, l1 = ax1.get_legend_handles_labels()
h2, l2 = ax2.get_legend_handles_labels()
h = [x for z in zip(h1, h2) for x in z]
l = [x for z in zip(l1, l2) for x in z]

for i in range(len(h2), len(h1)):
    h.append(h1[i])
    l.append(l1[i])
for i in range(len(h1), len(h2)):
    h.append(h2[i])
    l.append(l2[i])

ax1.legend(h, l, loc="upper left", ncol=3, fontsize=30)
plt.savefig('../plots/comb_3/interconnect_occupancy_performance.pdf',
        bbox_inches='tight')
