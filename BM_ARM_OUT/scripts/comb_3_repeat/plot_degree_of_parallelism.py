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

avg = lambda l : sum(l) / len(l)

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], avg_parallelism[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], avg_parallelism[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

avg_parallelism = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        total_parallelism = 0

        first_tick = 0
        last_tick = 0
        last_parallelism = 0

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

        for line in open(dir_name):
            if 'Number of accelerators running' in line:
                tokens = line.strip().split()

                tick = int(tokens[0][:-1])

                if first_tick == 0:
                    first_tick = tick
                else:
                    total_parallelism += last_parallelism * (tick - last_tick)

                last_tick = tick
                last_parallelism = int(tokens[7])

        avg_parallelism[policy].append(total_parallelism / \
                (last_tick - first_tick))

    # Normalize values
    #norm_value = avg_parallelism['LAX'][-1]
    #for policy in policies:
    #    avg_parallelism[policy][-1] /= norm_value

for policy in policies:
    #avg_parallelism[policy].append(geo_mean(avg_parallelism[policy]))
    avg_parallelism[policy].append(avg(avg_parallelism[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Amean']

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

plt.xticks(x, x_labels, fontsize=30)

#plt.ylabel('Degree of parallelism\n(norm. to LAX)', fontsize=30)
plt.ylabel('Degree of parallelism', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 2.5])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/avg_degree_of_parallelism.pdf',
        bbox_inches='tight')
