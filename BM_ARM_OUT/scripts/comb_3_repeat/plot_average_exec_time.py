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

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], avg_exec_time[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], avg_exec_time[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

base_runtime = {a:0 for a in applications}
avg_exec_time = {p:[] for p in policies}

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

        exec_time = [[], [], []]
        num_dags = 0
        dag_id = -1

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG execution time' in line:
                num_dags += 1
                finish_time = int(line.split()[6])
                if len(exec_time[dag_id]) == 0:
                    exec_time[dag_id].append(finish_time)
                else:
                    exec_time[dag_id].append(finish_time - \
                            exec_time[dag_id][-1])

        for i in range(3):
            exec_time[i] = sum(exec_time[i])
        avg_exec_time[policy].append(sum(exec_time))

    # normalize the values
    norm_value = avg_exec_time['LAX'][-1]
    for policy in policies:
        avg_exec_time[policy][-1] /= norm_value

# calculate geomean
for policy in policies:
    avg_exec_time[policy].append(geo_mean(avg_exec_time[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

plt_policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'HetSched', 'ELF']
width = 0.8 / len(plt_policies)
if len(plt_policies) % 2 == 0:
    offset = -width * (0.5 + ((len(plt_policies) / 2) - 1))
else:
    offset = -width * ((len(plt_policies) - 1) / 2)
for policy in plt_policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, policy, plabel)
    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Avg. exec time (norm. to LAX)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 4])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.5))

plt.legend(loc="upper left", ncol=6, fontsize=25)
plt.axhline(y=1, color='r', linestyle='-', linewidth=2)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/avg_exec_time.pdf', bbox_inches='tight')
