#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
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
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    boxes = plt.boxplot(delta[policy], positions=[i+offset for i in x],
            widths=width, whis=0, showfliers=False, patch_artist=True,
            zorder=1)

    for patch in boxes['boxes']:
        patch.set_facecolor(colors[policy])
        patch.set_edgecolor(edgecolors[policy])
        patch.set_hatch(hatch[policy])

    for median in boxes['medians']:
        median.set_color('black')

    boxes = plt.boxplot(delta[policy], positions=[i+offset for i in x],
            widths=width, whis=0, showfliers=False, patch_artist=True,
            zorder=2)

    for patch in boxes['boxes']:
        patch.set_facecolor('none')
        patch.set_edgecolor('black')

    for median in boxes['medians']:
        median.set_color('black')

    plt.bar([0], [0], edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy])
    plt.bar([0], [0], fc='none', edgecolor='k', width=width)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELFD', 'LL', 'HetSched', 'ELF']
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

    for policy in policies:
        if 'ELF' in policy:
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    policy + '_MEM_PRED_NO_PRED_dm_false'
        elif policy == 'LAX':
            dir_name = '../../comb_pred_3/' + app_mix_str + \
                    policy + '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_3/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        delta[policy].append([])
        dag_id = ''

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG deadline difference' in line:
                dag_deadline = deadline[app_mix[dag_id]]
                delta[policy][-1].append(
                        (dag_deadline + float(line.split()[6])) / \
                         dag_deadline)

        delta[policy][-1] = sorted(delta[policy][-1])
        iqr = delta[policy][-1][2] - delta[policy][-1][0]
        delta[policy][-1] = [delta[policy][-1][0] - (1.5 * iqr)] + \
                delta[policy][-1] + [delta[policy][-1][2] + (1.5 * iqr)]

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
    add_plot(offset, policy, plabel)
    offset += width

max_violation = 0
max_spread = 0
for i in range(len(app_mixes)):
    max_violation = max(max_violation, (delta['HetSched'][i][3] - \
            delta['ELF'][i][3]) / delta['HetSched'][i][3])
    spread_hetsched = delta['HetSched'][i][3] - delta['HetSched'][i][1]
    spread_elf = delta['ELF'][i][3] - delta['ELF'][i][1]
    max_spread = max(max_spread, (spread_hetsched - spread_elf) / spread_hetsched)
print(max_violation)
print(max_spread)

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Slowdown', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 3])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.5))

plt.legend(loc="upper left", ncol=4, fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
plt.axhline(y=1, color='r', linestyle='-', linewidth=2)
plt.savefig('../plots/comb_3/slowdown_box.pdf', bbox_inches='tight')
