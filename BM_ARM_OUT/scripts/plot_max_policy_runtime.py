#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

results_dir = '/u/sgupta45/gem5-SALAM/BM_ARM_OUT/'
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
app_mixes = sorted([c for c in itertools.combinations(applications, 3)])
y_values = [[], [], [], [], []]

hatch = ['*', '.', 'xx']

def get_policy_runtime(policy, cpu):
    out_file = 'scheduler_' + policy + '_' + '_'.join(app_mix) + \
            '/debug-trace.txt'

    for line in open(results_dir + 'scheduler_' + cpu + '/' + out_file):
        if '[Median]' in line:
            tokens = line.split()
            return sum([float(t) for t in tokens[2].split('/')])

def add_plot(offset, index, label):
    if index < len(hatch):
        plt.bar([i+offset for i in x], y_values[index], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[index])
    else:
        plt.bar([i+offset for i in x], y_values[index], edgecolor='k',
                width=width, label=label, fc='k')

min_time = []
max_time = []
avg_time = []
min_avg_time = 100000000    # some large number

for app_mix in app_mixes:
    min_time.append(100000000)  # some large number
    max_time.append(0)          # some small number
    tot_time = []

    out_file = results_dir + 'image_4_parallel_dma_bus/'
    for app in applications:
        out_file += app + '_'
        out_file += '4_' if app in app_mix else '0_'

    # load minimum, maximum, and average accelerator time
    for line in open(out_file + 'APRX3_pipeline/debug-trace.txt'):
        if 'Runtime' in line and 'us' in line:
            time = float(line.split()[1])
            min_time[-1] = min(min_time[-1], time)
            max_time[-1] = max(max_time[-1], time)
            tot_time.append(time)

    avg_time.append(sum(tot_time) / len(tot_time))
    min_avg_time = min(avg_time[-1], min_avg_time)

    # load GEDF total runtime on ex5_LITTLE and add it to the previous
    y_values[0].append(get_policy_runtime('GEDF', 'ex5_LITTLE'))

    # load APRX3 total runtime on ex5_LITTLE
    y_values[1].append(get_policy_runtime('APRX3', 'ex5_LITTLE'))

    # load APRX3 total runtime on HPI
    y_values[2].append(get_policy_runtime('APRX3', 'HPI'))

    # load APRX3 total runtime on O3_ARM_v7a
    y_values[3].append(get_policy_runtime('APRX3', 'O3_ARM_v7a'))

print('App mix\t\t\t\tMin\tMax\t\tAvg')
for i in range(len(min_time)):
    print(str(app_mixes[i]) + '\t' + str(round(min_time[i], 0)) + '\t' + \
            str(round(max_time[i], 0)) + '\t\t' + str(round(avg_time[i], 0)))

x = [i for i in range(len(app_mixes))]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))]

plt.figure(figsize=(24, 8), dpi=100)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 0, 'GEDF-N')
add_plot(-(width/2),     1, 'Cortex-A7')
add_plot((width/2),      2, 'HPI')
add_plot(((3*width)/2),  3, 'O3')

#plt.plot(x, avg_time, label='Avg. accelerator time',
#        marker='o', markersize=4, markerfacecolor='white',
#        linewidth=2, color='k')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Time (us)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 40])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=4, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
#plt.axhline(y=min(min_time), linewidth=2, color='red')
#plt.axhline(y=min_avg_time, linewidth=2, color='red')
plt.savefig('plots/max_policy_runtime.pdf', bbox_inches='tight')
