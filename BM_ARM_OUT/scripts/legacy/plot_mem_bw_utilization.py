#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'LEDF': '.', 'GEDF': 'xx', 'GLAX': '/'}

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
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

stat_value = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    base_dir_name = '../image_4_parallel_dma_bus/' + app_mix_str

    for policy in policies:
        bw = 0
        peak_bw = 0

        for line in open(base_dir_name + policy + '_pipeline/stats.txt'):
            if 'mem_ctrls.bw_total::total' in line:
                bw = float(line.split()[1]) / (1024 * 1024)
            if 'system.mem_ctrls.peakBW' in line:
                peak_bw = float(line.split()[1])
                break

        stat_value[policy].append(bw / peak_bw)

# calculate geo-mean for each policy
for policy in policies:
    stat_value[policy].append(geo_mean(stat_value[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',  'FCFS')
add_plot(-width,     'LEDF',  'GEDF-D')
add_plot(0,          'GEDF',  'GEDF-N')
add_plot(width,      'GLAX',  'LAX')
add_plot((width*2),  'APRX3', 'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Average DRAM B/W\nutilization', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.3])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/mem_bw_utilization.pdf', bbox_inches='tight')
