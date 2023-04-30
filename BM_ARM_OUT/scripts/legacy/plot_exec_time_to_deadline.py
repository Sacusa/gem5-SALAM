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
        plt.bar([i+offset for i in x], ratio[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], ratio[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur_5', 'gru_8', 'harris', 'lstm_8']
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

ratio = {p:[] for p in policies}

for app_mix in app_mixes:
    # read the minimum feasible deadline
    base_dir_name = '/u/sgupta45/scheduler/results/EXP_FR/'
    for policy in policies:
        ratio[policy].append(0)
        for line in open(base_dir_name + '_'.join(app_mix)):
            if 'Forwarding' in line: break
            if policy in line:
                ratio[policy][-1] = float(line.split()[0][1:-1])

    # read the real execution time
    base_dir_name = '../image_4/'
    for app in applications:
        base_dir_name += app.split('_')[0] + '_'
        if app in app_mix: base_dir_name += '4_'
        else:              base_dir_name += '0_'

    for policy in policies:
        exec_time = 0

        for line in open(base_dir_name + policy + '_pipeline/stats.txt'):
            if 'sim_ticks' in line:
                exec_time = float(line.split()[1]) / 1000000
                break

        ratio[policy][-1] = exec_time / ratio[policy][-1]

x = [i for i in range(len(app_mixes))]
x_labels = [','.join([a.split('_')[0] for a in app_mix])
        for app_mix in app_mixes]# + ['Geomean']

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

plt.ylabel('Exec. time / Min. deadline', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 8])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/exec_time_to_deadline.pdf', bbox_inches='tight')
