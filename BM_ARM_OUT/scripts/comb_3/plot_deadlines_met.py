import itertools
import matplotlib
matplotlib.use('Agg')
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
        'ELFD': 'RELIEF-LAX'}

def geo_mean(iterable):
    a = np.array([i if i > 0 else 1 for i in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(offset, stat_value, policy, label):
    plt.bar([i+offset for i in x], stat_value,
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], stat_value, fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELFD', 'LL', 'HetSched', 'ELF']

tot_num_nodes = {'canny': 12, 'deblur': 22, 'gru': 120, 'harris': 18,
        'lstm': 144}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

dag_deadlines_met = {p:[] for p in policies}
node_deadlines_met = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        dag_deadlines_met[policy].append(0)
        node_deadlines_met[policy].append(0)

        for line in open('../../comb_3/' + app_mix_str + policy + \
                '/debug-trace.txt'):
            if 'Number of DAG deadlines met' in line:
                dag_deadlines_met[policy][-1] += int(line.split()[8])
            elif 'Number of node deadlines met' in line:
                node_deadlines_met[policy][-1] += int(line.split()[8])

    norm_value_dag = 3
    norm_value_node = sum([tot_num_nodes[app] for app in app_mix])

    for policy in policies:
        dag_deadlines_met[policy][-1] = \
                (dag_deadlines_met[policy][-1] * 100) / norm_value_dag
        node_deadlines_met[policy][-1] = \
                (node_deadlines_met[policy][-1] * 100) / norm_value_node

for policy in policies:
    node_deadlines_met[policy].append(geo_mean(node_deadlines_met[policy]))

'''
DAG deadlines met
'''
x = [i for i in range(len(app_mixes))]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.8 / len(policies)
if len(policies) % 2 == 0:
    offset = -width * (0.5 + ((len(policies) / 2) - 1))
else:
    offset = -width * ((len(policies) - 1) / 2)
for policy in policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, dag_deadlines_met[policy], policy, plabel)
    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('DAG deadlines met (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 130])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=4, fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/dag_deadlines_met.pdf', bbox_inches='tight')

'''
Node deadlines met
'''
x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.clf()
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

print_policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']
width = 0.8 / len(print_policies)
if len(print_policies) % 2 == 0:
    offset = -width * (0.5 + ((len(print_policies) / 2) - 1))
else:
    offset = -width * ((len(print_policies) - 1) / 2)
for policy in print_policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, node_deadlines_met[policy], policy, plabel)
    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Node deadlines met (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 130])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/node_deadlines_met.pdf', bbox_inches='tight')
