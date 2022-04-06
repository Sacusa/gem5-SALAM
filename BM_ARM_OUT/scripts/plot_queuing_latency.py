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
                value = float(line.split()[1]) / 1000
                stat_found = True
                break

        if not stat_found:
            print('Cannot parse the statistic for ' + str(app_mix) + \
                    '_' + policy)
            exit(-2)

        values.append(value)

    return values

app_mixes = sorted(list(itertools.combinations(applications, 3)))
stat_values = {p:[] for p in policies}

# read the statistics
for app_mix in app_mixes:
    #output = get_stat(app_mix, 'avgQLat')
    output = get_stat(app_mix, 'totQLat')

    for i, policy in enumerate(policies):
        stat_values[policy].append(output[i])

    # normalize the values
    norm_value = stat_values['GEDF'][-1]
    for policy in policies:
        stat_values[policy][-1] /= norm_value

# calculate geo-mean for each policy
for policy in policies:
    stat_values[policy].append(geo_mean(stat_values[policy]))

# plot parameters
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(12, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 'FCFS',  'FCFS')
add_plot(-(width/2),     'LEDF',  'GEDF-D')
add_plot((width/2),      'GLAX',  'LAX')
add_plot(((3*width)/2),  'APRX3', 'ELF')

x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Geomean']
plt.xlabel('Application mix', fontsize=25)
plt.xticks(x, x_labels, fontsize=25, rotation='vertical')

plt.ylabel('Queuing latency (norm. to GEDF-N)', fontsize=25)
plt.yticks(fontsize=25)
plt.ylim([0.4, 1.2])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(tick_granularity[stat]))

plt.legend(loc="upper left", ncol=4, fontsize=20)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('plots/queuing_latency.pdf', bbox_inches='tight')
