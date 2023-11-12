#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\',
        'HetSched': '||', 'ELF': '++', 'ELFD': 'x'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'HetSched': colormap[11], 'ELF':  colormap[7],
        'ELFD': colormap[13]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'HetSched': colormap[10],
        'ELF':  colormap[6], 'ELFD': colormap[12]}

label = {'GEDF_D': 'GEDF-D', 'GEDF_N': 'GEDF-N', 'ELF': 'RELIEF'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], delta[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], delta[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LL', 'LAX', 'ELF', 'ELFD', 'HetSched']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']
init_deadline = {'canny': 16667, 'deblur': 16667, 'gru': 8000, 'harris': 16667,
        'lstm': 8000}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

delta = {p:[] for p in policies}

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
        if policy == 'LAX':
            dir_name = '../../comb_pred_3_opt_repeat_10_min_3/' + \
                    app_mix_str + policy + '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_3_opt_repeat_10_min_3/' + \
                    app_mix_str + policy
        dir_name += '/debug-trace.txt'

        deadline = init_deadline.copy()
        delta[policy].append([])
        dag_id = ''

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG deadline difference' in line:
                dag_name = app_mix[dag_id]
                dag_deadline = deadline[dag_name]
                delta[policy][-1].append(
                        (dag_deadline + float(line.split()[6])) / \
                         dag_deadline)
                deadline[dag_name] += init_deadline[dag_name]

        delta[policy][-1] = np.quantile(delta[policy][-1],
                [0, 0.25, 0.5, 0.75, 1])[4]

max_elf = 0
max_others = 0
for i in range(len(app_mixes)):
    max_elf = max(max_elf, delta['ELF'][i])
    for policy in policies:
        if policy == 'ELF': continue
        max_others = max(max_others, delta[policy][i])
max_elf -= 1
max_others -= 1
print((max_others - max_elf) / max_others)

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

policy_offset = {}
for policy in policies:
    policy_offset[policy] = offset
    offset += width
#for policy in ['FCFS', 'ELF', 'GEDF_D', 'ELFD', 'GEDF_N', 'LL', 'LAX']:
for policy in policies:
    plabel = label[policy] if policy in label else policy
    add_plot(policy_offset[policy], policy, plabel)

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Maximum slowdown', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 9])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(1))

plt.legend(loc="upper left", ncol=6, fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
plt.axhline(y=1, color='r', linestyle='-', linewidth=2)
plt.savefig('../plots/comb_3_repeat/slowdown_max.pdf', bbox_inches='tight')
