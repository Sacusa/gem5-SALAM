#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import re
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'ELF': 'xx', 'xbar': '/'}

def geo_mean(iterable):
    a = np.array([v if v > 0 else 1 for v in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], stat_values[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], stat_values[policy], edgecolor='k',
                width=width, label=label, fc='k')

policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']
#policies_ext = policies + ['xbar']
policies_ext = policies
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

def get_stat(app_mix):
    values = []

    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        value = 0

        # Get the stat for all policies
        if policy in ['FCFS', 'GEDF_D']:
            dir_name = '../comb_4_scheds/'
        else:
            dir_name = '../comb_4/'
        dir_name += app_mix_str

        for line in open(dir_name + policy + '/stats.txt'):
            if 'system.mem_ctrls.bytes_read::total' in line:
                value = float(line.split()[1])
            elif 'system.mem_ctrls.bytes_written::total' in line:
                value += float(line.split()[1])
                break

        values.append(value)

    # Get the stat for ELF w/ xbar
    #dir_name = '../comb_4_xbar/' + app_mix_str

    #value = 0
    #for line in open(dir_name + policy + '/stats.txt'):
    #    if 'system.mem_ctrls.bytes_read::total' in line:
    #        value = float(line.split()[1])
    #    elif 'system.mem_ctrls.bytes_written::total' in line:
    #        value += float(line.split()[1])
    #        break

    #values.append(value)

    return values

app_mixes = sorted(list(itertools.combinations(applications, 3)))
stat_values = {p:[] for p in policies_ext}

# read the statistics
for app_mix in app_mixes:
    output = get_stat(app_mix)

    for i, policy in enumerate(policies_ext):
        stat_values[policy].append(output[i])

    # normalize the values
    norm_value = stat_values['LAX'][-1]
    for policy in policies_ext:
        if norm_value == 0:
            stat_values[policy][-1] = 0
        else:
            stat_values[policy][-1] /= norm_value

# calculate geo-mean for each policy
for policy in policies_ext:
    stat_values[policy].append(geo_mean(stat_values[policy]))

# plot parameters
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

#width = 0.16
#add_plot(-(width*2), 'FCFS',   'FCFS')
#add_plot(-width,     'GEDF_D', 'GEDF-D')
#add_plot(0,          'GEDF_N', 'GEDF-N')
#add_plot(width,      'ELF',    'ELF')
#add_plot((width*2),  'xbar',   'ELF-xbar')
width = 0.20
add_plot(-((3*width)/2), 'FCFS',   'FCFS')
add_plot(-(width/2),     'GEDF_D', 'GEDF-D')
add_plot((width/2),      'GEDF_N', 'GEDF-N')
add_plot((3*width)/2,    'ELF',    'ELF')

x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']
plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('DRAM bytes read/written\n(norm. to LAX)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 2.25])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.25))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('plots/dram_traffic.pdf', bbox_inches='tight')
