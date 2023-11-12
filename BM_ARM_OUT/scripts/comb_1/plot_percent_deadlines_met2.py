#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\', 'ELF': '++'}
marker = {'FCFS': 'o', 'GEDF_D': '*', 'GEDF_N': 'X', 'LAX': 'P', 'ELF': 's'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'ELF':  colormap[7]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'ELF':  colormap[6]}

avg = lambda l : sum(l) / len(l)

def geo_mean(iterable):
    a = np.array([i if i > 0 else 1 for i in iterable])
    return a.prod()**(1.0/len(a))

def add_node_plot(offset, policy, label):
    ax1.bar([i+offset for i in x], node_deadlines_met[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=3)
    ax1.bar([i+offset for i in x], node_deadlines_met[policy], fc='none',
            edgecolor='k', width=width, zorder=4)

def add_dag_plot(policy, label):
    ax2.plot(x, dag_deadlines_met[policy], linestyle='--', linewidth=2,
            marker=marker[policy], markerfacecolor=edgecolors[policy],
            markersize=25, markeredgecolor='k', label=label, zorder=3)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

tot_num_nodes = {'canny': 12, 'deblur': 22, 'gru': 120, 'harris': 18,
        'lstm': 144}

dag_deadlines_met = {p:[] for p in policies}
node_deadlines_met = {p:[] for p in policies}

for app_mix in applications:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app == app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        if policy == 'ELF':
            dir_name = '../../comb_pred_1_opt_flush_opt_fwd/' + app_mix_str + \
                    policy + '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_1_opt_flush_opt_fwd/' + app_mix_str + \
                    policy + '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_1_opt_flush_opt_fwd/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        value_found = False

        for line in open(dir_name):
            if 'Number of DAG deadlines met' in line:
                dag_deadlines_met[policy].append(int(line.split()[8]))
            elif 'Number of node deadlines met' in line:
                node_deadlines_met[policy].append(int(line.split()[8]))
                value_found = True

        if not value_found:
            dag_deadlines_met[policy].append(0)
            node_deadlines_met[policy].append(0)

    norm_value_dag = 1
    norm_value_node = tot_num_nodes[app_mix]

    for policy in policies:
        dag_deadlines_met[policy][-1] = \
                (dag_deadlines_met[policy][-1] * 100) / norm_value_dag
        node_deadlines_met[policy][-1] = \
                (node_deadlines_met[policy][-1] * 100) / norm_value_node

for policy in policies:
    dag_deadlines_met[policy].append(geo_mean(dag_deadlines_met[policy]))
    node_deadlines_met[policy].append(geo_mean(node_deadlines_met[policy]))

print(abs(node_deadlines_met['ELF'][-1] - node_deadlines_met['LAX'][-1]) / \
        node_deadlines_met['LAX'][-1])

x = [i for i in range(len(applications) + 1)]
x_labels = [a[0].upper() for a in applications] + ['Gmean']

fig, ax1 = plt.subplots(figsize=(24, 12), dpi=600)
ax2 = ax1.twinx()
plt.rc('axes', axisbelow=False)

width = 0.16
add_node_plot(-(width*2), 'FCFS',   'Node: FCFS')
add_node_plot(-width,     'GEDF_D', 'GEDF-D')
add_node_plot(0,          'GEDF_N', 'GEDF-N')
add_node_plot(width,      'LAX',    'LAX')
add_node_plot((width*2),  'ELF',    'RELIEF')

add_dag_plot('FCFS',   'DAG: FCFS')
add_dag_plot('GEDF_D', 'GEDF-D')
add_dag_plot('GEDF_N', 'GEDF-N')
add_dag_plot('LAX',    'LAX')
add_dag_plot('ELF',    'RELIEF')

ax1.set_xticks(x)
ax1.set_xticklabels(x_labels, size=30)
ax1.set_ylabel('Node deadlines met (%)', size=30)
ax1.set_ylim([0, 280])
ax1.yaxis.set_major_locator(plt.MultipleLocator(20))
ax1.yaxis.set_tick_params(labelsize=30)

ax2.set_ylabel('DAG deadlines met (%)', size=30)
ax2.set_ylim([-120, 160])
ax2.yaxis.set_major_locator(plt.MultipleLocator(20))
ax2.yaxis.set_tick_params(labelsize=30)

ax1.grid(zorder=0, color='silver', linestyle='-', linewidth=1)
h1, l1 = ax1.get_legend_handles_labels()
h2, l2 = ax2.get_legend_handles_labels()
h = [x for z in zip(h2, h1) for x in z]
l = [x for z in zip(l2, l1) for x in z]
ax1.legend(h, l, loc="upper left", ncol=5, fontsize=30)
plt.savefig('../plots/comb_1/percent_deadlines.pdf', bbox_inches='tight')
