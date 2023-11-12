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
    a = np.array([i if i > 0 else 1 for i in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(offset, stat_value, policy, label):
    plt.bar([i+offset for i in x], stat_value,
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], stat_value, fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']
policies = ['FCFS', 'LAX', 'ELF']

tot_num_nodes = {'canny': 12, 'deblur': 22, 'gru': 120, 'harris': 18,
        'lstm': 144}

#app_mixes = sorted([c for c in itertools.combinations(applications, 3)])
app_mixes = [('canny', 'deblur', 'gru'), ('canny', 'deblur', 'harris'),
        ('canny', 'gru', 'harris'), ('canny', 'gru', 'lstm'),
        ('deblur', 'gru', 'harris')]

dag_deadlines_met = {p:[] for p in policies}
node_deadlines_met = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        #if policy == 'ELF':
        #    dir_name = '../../comb_pred_3_opt_flush_opt_fwd/' + app_mix_str + \
        #            policy + '_MEM_PRED_NO_PRED_dm_false'
        #elif policy == 'LAX':
        #    dir_name = '../../comb_pred_3_opt_flush_opt_fwd/' + app_mix_str + \
        #            policy + '_MEM_PRED_EWMA_0.25_dm_false'
        #else:
        #    dir_name = '../../comb_3_opt_flush_opt_fwd/' + app_mix_str + policy
        dir_name = '../../comb_3_opt_repeat_10_min_3/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        iterations = [0, 0, 0]
        num_nodes = [0, 0, 0]
        dag_deadlines_met[policy].append(0)
        node_deadlines_met[policy].append(0)

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG deadline difference' in line:
                iterations[dag_id] += 1
                deadline_violation = int(line.split()[6])
                if deadline_violation <= 0:
                    dag_deadlines_met[policy][-1] += 1
            elif 'Node deadline difference' in line:
                num_nodes[dag_id] += 1
                deadline_violation = int(line.split()[6])
                if deadline_violation <= 0:
                    node_deadlines_met[policy][-1] += 1

        norm_value_dag = sum(iterations)
        #norm_value_node = sum([tot_num_nodes[app] * iterations[i]
        #    for i, app in enumerate(app_mix)])
        norm_value_node = sum(num_nodes)

        dag_deadlines_met[policy][-1] = \
                (dag_deadlines_met[policy][-1] * 100) / norm_value_dag
        node_deadlines_met[policy][-1] = \
                (node_deadlines_met[policy][-1] * 100) / norm_value_node

for policy in policies:
    dag_deadlines_met[policy].append(geo_mean(dag_deadlines_met[policy]))
    node_deadlines_met[policy].append(geo_mean(node_deadlines_met[policy]))

#print((node_deadlines_met['ELF'][-1] - node_deadlines_met['HetSched'][-1]) / \
#        node_deadlines_met['HetSched'][-1])

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

'''
DAG deadlines met
'''
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

#plt.xlabel('Application mix', fontsize=30)
#plt.xticks(x, x_labels, fontsize=30, rotation='vertical')
plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('DAG deadlines met (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 130])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/percent_dag_deadlines_met.pdf',
        bbox_inches='tight')

'''
Node deadlines met
'''
plt.clf()
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.8 / len(policies)
if len(policies) % 2 == 0:
    offset = -width * (0.5 + ((len(policies) / 2) - 1))
else:
    offset = -width * ((len(policies) - 1) / 2)
for policy in policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, node_deadlines_met[policy], policy, plabel)
    offset += width

#plt.xlabel('Application mix', fontsize=30)
#plt.xticks(x, x_labels, fontsize=30, rotation='vertical')
plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Node deadlines met (%)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 130])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/percent_node_deadlines_met.pdf',
        bbox_inches='tight')
