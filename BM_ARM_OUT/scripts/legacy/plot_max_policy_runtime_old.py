#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

results_dir = '/u/sgupta45/gem5-SALAM/BM_ARM_OUT/'
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
app_mixes = sorted([c for c in itertools.combinations(applications, 3)])
y_values = [[], [], [], []]

hatch = ['*', '.', 'xx']

def get_policy_runtime(policy, cpu):
    out_file = 'scheduler_' + policy + '_' + '_'.join(app_mix) + \
            '/debug-trace.txt'

    for line in open(results_dir + 'scheduler_' + cpu + '/' + out_file):
        if '[Total]' in line:
            tokens = line.split()
            return (sum([float(t) for t in tokens[2].split('/')]) / 1000)

def add_plot(offset, index, label):
    if index < len(hatch):
        plt.bar([i+offset for i in x], y_values[index], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[index])
    else:
        plt.bar([i+offset for i in x], y_values[index], edgecolor='k',
                width=width, label=label, fc='k')

for app_mix in app_mixes:
    out_file = results_dir + 'image_4/'
    for app in applications:
        out_file += app + '_'
        out_file += '4_' if app in app_mix else '0_'

    # load performance difference between GEDF and APRX3 schedules
    for line in open(out_file + 'GEDF_pipeline/stats.txt'):
        if 'sim_ticks' in line:
            y_values[0].append(float(line.split()[1]) / 1000000000)
            break

    for line in open(out_file + 'APRX3_pipeline/stats.txt'):
        if 'sim_ticks' in line:
            y_values[0][-1] -= (float(line.split()[1]) / 1000000000)
            break

    # load GEDF total runtime on ex5_LITTLE and add it to the previous
    y_values[0][-1] += get_policy_runtime('GEDF', 'ex5_LITTLE')

    # load APRX3 total runtime on ex5_LITTLE
    y_values[1].append(get_policy_runtime('APRX3', 'ex5_LITTLE'))

    # load APRX3 total runtime on HPI
    y_values[2].append(get_policy_runtime('APRX3', 'HPI'))

    # load APRX3 total runtime on O3_ARM_v7a
    y_values[3].append(get_policy_runtime('APRX3', 'O3_ARM_v7a'))

x = [i for i in range(len(app_mixes))]
x_labels = [','.join(app_mix) for app_mix in app_mixes]

plt.figure(figsize=(12, 8), dpi=100)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 0, 'Max time')
add_plot(-(width/2),     1, 'Cortex-A7')
add_plot((width/2),      2, 'HPI')
add_plot(((3*width)/2),  3, 'O3')

plt.xlabel('Application mix', fontsize=25)
plt.xticks(x, x_labels, fontsize=25, rotation='vertical')

plt.ylabel('Time (ms)', fontsize=25)
plt.yticks(fontsize=25)
plt.ylim([0, 45])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=4, fontsize=20)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/max_policy_runtime.pdf', bbox_inches='tight')
