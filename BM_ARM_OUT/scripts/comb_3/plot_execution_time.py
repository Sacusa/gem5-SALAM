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
    plt.bar([i+offset for i in x], stat_values[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], stat_values[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

exec_time = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        for line in open('../../comb_3/' + app_mix_str + policy + \
                '/stats.txt'):
            if 'sim_ticks' in line:
                exec_time[policy].append(int(line.split()[1]))

    # normalize the values
    norm_value = exec_time['LAX'][-1]
    for policy in policies:
        exec_time[policy][-1] /= norm_value

# calculate geomean
for policy in policies:
    exec_time[policy].append(geo_mean(exec_time[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

plot_policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'HetSched', 'ELF']
width = 0.8 / len(plot_policies)
if len(plot_policies) % 2 == 0:
    offset = -width * (0.5 + ((len(plot_policies) / 2) - 1))
else:
    offset = -width * ((len(plot_policies) - 1) / 2)
for policy in plot_policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, policy, plabel)
    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Execution time (norm. to LAX)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 1.8])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/execution_time.pdf',
        bbox_inches='tight')
