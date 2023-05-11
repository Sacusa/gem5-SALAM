#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'ELF': 'xx', 'xbar': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], avg_parallelism[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], avg_parallelism[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

avg_parallelism = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        total_parallelism = 0

        first_tick = 0
        last_tick = 0
        last_parallelism = 0

        dir_name = '../comb_4/' + app_mix_str + policy + '/debug-trace.txt'

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

                if last_parallelism == 0:
                    avg_parallelism[policy].append(total_parallelism / \
                            (tick - first_tick))
                    break

    # Normalize values
    norm_value = avg_parallelism['LAX'][-1]
    for policy in policies:
        avg_parallelism[policy][-1] /= norm_value

for policy in policies:
    avg_parallelism[policy].append(geo_mean(avg_parallelism[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

#width = 0.16
#add_plot(-(width*2), 'FCFS',   'FCFS')
#add_plot(-width,     'GEDF_D', 'GEDF-D')
#add_plot(0,          'GEDF_N', 'GEDF-N')
#add_plot(width,      'LAX',    'LAX')
#add_plot((width*2),  'ELF',    'ELF')
width = 0.20
add_plot(-((3*width)/2), 'FCFS',   'FCFS')
add_plot(-(width/2),     'GEDF_D', 'GEDF-D')
add_plot((width/2),      'GEDF_N', 'GEDF-N')
add_plot((3*width)/2,    'ELF',    'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Degree of parallelism\n(norm. to LAX)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.8])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/avg_degree_of_parallelism.pdf', bbox_inches='tight')
