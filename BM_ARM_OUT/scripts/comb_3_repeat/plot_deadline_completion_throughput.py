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
    a = np.array([v if v > 0 else 1 for v in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(offset, throughput, policy, label):
    plt.bar([i+offset for i in x], throughput[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], throughput[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']
policies = ['FCFS', 'LAX', 'ELF']

#app_mixes = sorted([c for c in itertools.combinations(applications, 3)])
app_mixes = [('canny', 'deblur', 'gru'), ('canny', 'deblur', 'harris'),
        ('canny', 'gru', 'harris'), ('canny', 'gru', 'lstm'),
        ('deblur', 'gru', 'harris')]

node_throughput = {p:[] for p in policies}
dag_throughput = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        #if policy == 'ELF':
        #    dir_name = '../../comb_pred_3/' + app_mix_str + policy + \
        #            '_MEM_PRED_NO_PRED_dm_false'
        #elif policy == 'LAX':
        #    dir_name = '../../comb_pred_3/' + app_mix_str + policy + \
        #            '_MEM_PRED_EWMA_0.25_dm_false'
        #else:
        #    dir_name = '../../comb_3/' + app_mix_str + policy
        dir_name = '../../comb_3_opt_repeat_10_min_3/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        finished_nodes = 0
        finished_dags = 0
        total_time = 0

        for line in open(dir_name):
            if 'DAG execution time' in line:
                new_total_time = int(line.split()[6])
                total_time = max(total_time, new_total_time)
            elif 'DAG deadline difference' in line:
                deadline_violation = int(line.split()[6])
                if deadline_violation <= 0:
                    finished_dags += 1
            elif 'Node deadline difference' in line:
                deadline_violation = int(line.split()[6])
                if deadline_violation <= 0:
                    finished_nodes += 1

        node_throughput[policy].append(finished_nodes / \
                (total_time / 1000_000))
        dag_throughput[policy].append(finished_dags / (total_time / 1000_000))

    # normalize the values
    #norm_value = max(dag_throughput['LAX'][-1], 1)
    #for policy in policies:
    #    dag_throughput[policy][-1] /= norm_value

# calculate geomean
#for policy in policies:
#    dag_throughput[policy].append(geo_mean(dag_throughput[policy]))

x = [i for i in range(len(app_mixes))]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

################
# DAG throughput
################

width = 0.8 / len(policies)
if len(policies) % 2 == 0:
    offset = -width * (0.5 + ((len(policies) / 2) - 1))
else:
    offset = -width * ((len(policies) - 1) / 2)
for policy in policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, dag_throughput, policy, plabel)
    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Throughput (DAGs / sec)', fontsize=30)
plt.yticks(fontsize=30)
#plt.ylim([0, 2])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=30)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/deadline_completion_throughput_dag.pdf',
        bbox_inches='tight')

#################
# Node throughput
#################

plt.clf()

width = 0.8 / len(policies)
if len(policies) % 2 == 0:
    offset = -width * (0.5 + ((len(policies) / 2) - 1))
else:
    offset = -width * ((len(policies) - 1) / 2)
for policy in policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, node_throughput, policy, plabel)
    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Throughput (Nodes / sec)', fontsize=30)
plt.yticks(fontsize=30)
#plt.ylim([0, 2])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=30)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/deadline_completion_throughput_node.pdf',
        bbox_inches='tight')
