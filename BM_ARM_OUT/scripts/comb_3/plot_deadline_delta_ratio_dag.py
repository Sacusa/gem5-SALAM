#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\', 'ELF': '++',
         'ELF-dep': 'x'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'ELF':  colormap[7], 'ELF-dep': colormap[11]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'ELF':  colormap[6],
        'ELF-dep': colormap[10]}

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
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF', 'ELF-dep']
deadline = {'canny': 16667, 'deblur': 16667, 'gru': 8000, 'harris': 16667,
        'lstm': 8000}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

delta = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    #print(app_mix_str)

    for policy in policies:
        if policy == 'ELF':
            dir_name = '../../comb_pred_3/' + app_mix_str + policy + \
                    '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'ELF-dep':
            dir_name = '../../comb_pred_3_deprioritize/' + app_mix_str + \
                    'ELF_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_3/' + app_mix_str + policy + \
                    '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_3/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        delta[policy].append([])
        dag_id = ''

        #print('  ' + policy)

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG deadline difference' in line:
                dag_deadline = deadline[app_mix[dag_id]]
                delta[policy][-1].append(
                        (dag_deadline + float(line.split()[6])) / \
                         dag_deadline)

                #print('    ' + app_mix[dag_id] + ': ' + \
                #        str(delta[policy][-1][-1]))

        delta[policy][-1] = np.quantile(delta[policy][-1],
                [0, 0.25, 0.5, 0.75, 1])[4]

    # normalize the values
    #norm_value = delta['LAX'][-1]
    #for policy in policies:
    #    delta[policy][-1] /= norm_value

for policy in policies:
    delta[policy].append(max(delta[policy]))

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

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Max']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.13
add_plot(-((5*width)/2), 'FCFS',   'FCFS')
add_plot((width/2),      'LAX',    'LAX')
add_plot(-((3*width)/2), 'GEDF_D', 'GEDF-D')
add_plot((3*width)/2,    'ELF',    'RELIEF')
add_plot(-(width/2),     'GEDF_N', 'GEDF-N')
add_plot((5*width)/2,    'ELF-dep','RELIEF-dep')

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Maximum slowdown', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 4])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.5))

plt.legend(loc="upper left", ncol=3, fontsize=30)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/deadline_delta_ratio_dag.pdf',
        bbox_inches='tight')
