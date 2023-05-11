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
        plt.bar([i+offset for i in x], stat_value[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], stat_value[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF', 'xbar']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

stat_value = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        latencies = []

        if policy == 'xbar':
            dir_name = '../comb_4_xbar/' + app_mix_str + 'ELF'
        else:
            dir_name = '../comb_4/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        for line in open(dir_name):
            if 'Transfer completed' in line:
                latencies.append(float(line.split()[5]))

        stat_value[policy].append(sum(latencies) / 1000)

    # normalize the values
    norm_value = stat_value['LAX'][-1]
    for policy in policies:
        stat_value[policy][-1] /= norm_value

# calculate geomean
for policy in policies:
    stat_value[policy].append(geo_mean(stat_value[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

#width = 0.16
#add_plot(-(width*2), 'FCFS',  'FCFS')
#add_plot(-width,     'GEDF_D',  'GEDF-D')
#add_plot(0,          'LAX',  'LAX')
#add_plot(width,      'ELF', 'ELF')
#add_plot((width*2),  'xbar',  'ELF-xbar')
width = 0.20
add_plot(-((3*width)/2), 'FCFS',   'FCFS')
add_plot(-(width/2),     'GEDF_D', 'GEDF-D')
add_plot((width/2),      'GEDF_N', 'GEDF-N')
add_plot((3*width)/2,    'ELF',    'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Total DMA latency\n(norm. to LAX)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.8])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/dma_latency.pdf', bbox_inches='tight')
