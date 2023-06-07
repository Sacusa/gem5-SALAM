#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'LAX': 'xx', 'ELF': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], slowdown[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], slowdown[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

base_runtime = {a:0 for a in applications}
slowdown = {p:[] for p in policies}

# Load base execution time
for app in applications:
    app_mix_str = ''
    for a in applications:
        app_mix_str += a + '_'
        if a == app: app_mix_str += '1_'
        else:        app_mix_str += '0_'

    dir_name = '../solo_app/' + app_mix_str + 'FCFS/debug-trace.txt'

    for line in open(dir_name):
        if 'DAG execution time' in line:
            base_runtime[app] = int(line.split()[6])

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        dir_name = '../comb_3/' + app_mix_str + policy + '/debug-trace.txt'

        slowdown[policy].append([])

        dag_id = -1

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG execution time' in line:
                dag_name = app_mix[dag_id // 4]
                slowdown[policy][-1].append(int(line.split()[6]) / \
                        base_runtime[dag_name])

        slowdown[policy][-1] = np.quantile(slowdown[policy][-1],
                [0, 0.25, 0.5, 0.75, 1])[4]

    # normalize the values
    #norm_value = slowdown['LAX'][-1]
    #for policy in policies:
    #    slowdown[policy][-1] /= norm_value

# calculate geomean
for policy in policies:
    slowdown[policy].append(geo_mean(slowdown[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',   'FCFS')
add_plot(-width,     'GEDF_D', 'GEDF-D')
add_plot(0,          'GEDF_N', 'GEDF-N')
add_plot(width,      'LAX',    'LAX')
add_plot((width*2),  'ELF',    'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Max slowdown', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 21])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/slowdown.pdf', bbox_inches='tight')
