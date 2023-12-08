#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
import matplotlib.pyplot as plt
import numpy as np

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

def add_plot(offset, policy, label):
    plt.bar([i+offset for i in x], stat_values[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], stat_values[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

def get_stat(app_mix):
    values = []

    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        exec_time = 0
        num_dags = 0

        # Get the stat for all policies
        if policy == 'LAX':
            dir_name = '../../comb_pred_3_repeat_10_min_3/' + \
                    app_mix_str + policy + '_MEM_PRED_EWMA_0.25_dm_false'
        else:
            dir_name = '../../comb_3_repeat_10_min_3/' + \
                    app_mix_str + policy

        for line in open(dir_name + '/stats.txt'):
            if 'sim_ticks' in line:
                exec_time = int(line.split()[1])
                break

        value = 0
        for line in open(dir_name + '/debug-trace.txt'):
            if 'Finished DAG iterations' in line:
                value = int(line.split()[6])
            elif 'Number of DAG deadlines met' in line:
                value = max(value, int(line.split()[8]))
                num_dags += value

        values.append(num_dags / exec_time)

    return values

app_mixes = sorted(list(itertools.combinations(applications, 3)))
stat_values = {p:[] for p in policies}

# read the statistics
for app_mix in app_mixes:
    output = get_stat(app_mix)

    for i, policy in enumerate(policies):
        stat_values[policy].append(output[i])

    # normalize the values
    norm_value = stat_values['LAX'][-1]
    for policy in policies:
        if norm_value == 0:
            stat_values[policy][-1] = 0
        else:
            stat_values[policy][-1] /= norm_value

# calculate geo-mean for each policy
for policy in policies:
    stat_values[policy].append(geo_mean(stat_values[policy]))

for i in range(len(app_mixes) + 1):
    print((stat_values['ELF'][i] - stat_values['LAX'][i]) / stat_values['LAX'][i])

# plot parameters
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

#width = 0.20
#add_plot(-((3*width)/2), 'FCFS',   'FCFS')
#add_plot(-(width/2),     'GEDF_D', 'GEDF-D')
#add_plot((width/2),      'GEDF_N', 'GEDF-N')
#add_plot((3*width)/2,    'ELF',    'RELIEF')

#plot_policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'HetSched', 'ELF']
plot_policies = policies
width = 0.8 / len(plot_policies)
if len(plot_policies) % 2 == 0:
    offset = -width * (0.5 + ((len(plot_policies) / 2) - 1))
else:
    offset = -width * ((len(plot_policies) - 1) / 2)
for policy in plot_policies:
    plabel = label[policy] if policy in label else policy
    add_plot(offset, policy, plabel)
    offset += width

x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']
plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Throughput (norm. to LAX)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 2.0])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=len(plot_policies), fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('../plots/comb_3_repeat/application_throughput.pdf',
        bbox_inches='tight')
