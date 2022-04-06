#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import re
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
        stat_found = False
        value = 0

        for line in open(base_dir_name + policy + '_pipeline/stats.txt'):
            if stat in line:
                tokens = line.split()

                for t in tokens:
                    try:
                        value = float(t.strip())
                        stat_found = True
                        break
                    except ValueError:
                        continue

        if not stat_found:
            print('Cannot parse the statistic for ' + str(app_mix) + \
                    '_' + policy)
            exit(-2)

        values.append(value)

    return values

if len(sys.argv) != 3:
    print('Usage: ' + sys.argv[0] + ' <stat> <graph label>')
    print('  Suggested stats: sim_ticks, mem_ctrls.bw_total::total')
    exit(-1)

stat = sys.argv[1]
y_label = sys.argv[2]

app_mixes = sorted(list(itertools.combinations(applications, 3)))
stat_values = {p:[] for p in policies}

# read the statistics
for app_mix in app_mixes:
    output = get_stat(app_mix, stat)

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
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.20
add_plot(-((3*width)/2), 'FCFS',  'FCFS')
add_plot(-(width/2),     'LEDF',  'GEDF-D')
add_plot((width/2),      'GLAX',  'LAX')
add_plot(((3*width)/2),  'APRX3', 'ELF')

x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']
plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel(y_label + '\n(norm. to GEDF-N)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.7])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=4, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
filename = '_'.join([re.sub('[^A-Za-z0-9]+', '', t.lower())
    for t in y_label.split()])
plt.savefig('plots/' + filename + '.pdf', bbox_inches='tight')
