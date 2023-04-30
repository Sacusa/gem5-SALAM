#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import re

hatch = {'APRX3': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], occupancy[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], occupancy[policy], edgecolor='k',
                width=width, label=label, fc='k')

policies = ['GEDF', 'APRX3']
policies_ext = policies + ['xbar']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
app_mixes = sorted(list(itertools.combinations(applications, 3)))

def get_stat(app_mix, interconnect):
    values = []

    base_dir_name = '../image_4_parallel_dma_' + interconnect + '/'
    for app in applications:
        base_dir_name += app + '_'
        if app in app_mix: base_dir_name += '4_'
        else:              base_dir_name += '0_'

    for policy in policies:
        for line in open(base_dir_name + policy + '_pipeline/stats.txt'):
            if 'system.acctest.local_bus.utilization' in line:
                values.append(float(line.split()[1]))
                break

    return values

occupancy = {p:[] for p in policies_ext}

for app_mix in app_mixes:
    bus_util = get_stat(app_mix, 'bus')
    xbar_util = get_stat(app_mix, 'xbar')

    for i, policy in enumerate(policies):
        occupancy[policy].append(bus_util[i])

    occupancy['xbar'].append(xbar_util[-1])

    # normalize to GEDF
    norm_value = occupancy['GEDF'][-1]
    for policy in policies_ext:
        occupancy[policy][-1] /= norm_value

# calculate geo-mean for each policy
for policy in policies_ext:
    occupancy[policy].append(geo_mean(occupancy[policy]))

print(occupancy['xbar'])

# plot parameters
x = np.arange(len(app_mixes) + 1)

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.3
add_plot(-(width/2), 'APRX3', 'ELF')
add_plot((width/2),  'xbar',  'ELF-xbar')

x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']
plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Interconnect occupancy\n(norm. to GEDF-N)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.7])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('plots/interconnect_occupancy_elf.pdf', bbox_inches='tight')
