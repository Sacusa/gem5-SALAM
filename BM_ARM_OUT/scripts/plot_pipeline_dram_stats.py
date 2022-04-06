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
        plt.bar([i+offset for i in x], stat_values[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], stat_values[policy], edgecolor='k',
                width=width, label=label, fc='k')

policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

ylim = {'totalEnergy': [0.5, 1.5], 'averagePower': [0.7, 1.15]}

def get_stat(app_mix, stat):
    values = []

    base_dir_name = '../image_4_parallel_dma_bus/'
    for app in applications:
        base_dir_name += app + '_'
        if app in app_mix: base_dir_name += '4_'
        else:              base_dir_name += '0_'

    for policy in policies:
        value = 0
        stat_found = False

        for line in open(base_dir_name + policy + '_pipeline/stats.txt'):
            if ('system.mem_ctrls' in line) and (stat in line):
                value = float(line.split()[1])
                stat_found = True
                break

        if not stat_found:
            print('Cannot parse the statistic for ' + str(app_mix) + \
                    '_' + policy)
            exit(-2)

        values.append(value)

    return values

if len(sys.argv) != 3:
    print('Usage: ' + sys.argv[0] + ' <stat> <graph label>')
    print('  Suggested stats: totalEnergy, averagePower, avgQLat')
    exit(-1)

stat = sys.argv[1]
y_label = sys.argv[2]

app_mixes = sorted(list(itertools.combinations(applications, 3)))
stat_values = {p:[] for p in policies}
x_labels = []

# read the statistics
for app_mix in app_mixes:
    output = get_stat(app_mix, stat)

    for i, policy in enumerate(policies):
        stat_values[policy].append(output[i])

    # normalize the values
    norm_value = stat_values['GEDF'][-1]
    for policy in policies:
        stat_values[policy][-1] /= norm_value

    # create x-axis labels
    x_labels.append('')
    for app in app_mix:
        x_labels[-1] += app + ','
    x_labels[-1] = x_labels[-1][:-1]

# calculate geo-mean for each policy
for policy in policies:
    stat_values[policy].append(geo_mean(stat_values[policy]))
x_labels.append('Geomean')

# plot parameters
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 'FCFS',  'FCFS')
add_plot(-(width/2),     'LEDF',  'GEDF-D')
add_plot((width/2),      'GLAX',  'LAX')
add_plot(((3*width)/2),  'APRX3', 'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel(y_label + '\n(norm. to GEDF-N)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim(ylim[stat])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(tick_granularity[stat]))

plt.legend(loc="upper left", ncol=4, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
filename = '_'.join([t.lower() for t in y_label.split()])
plt.savefig('plots/' + filename + '.pdf', bbox_inches='tight')
