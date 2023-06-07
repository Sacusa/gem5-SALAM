#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

linestyle = {'FCFS': 'bo--', 'GEDF_D': 'g*--', 'GEDF_N': 'yX--',
        'LAX': 'rP--', 'ELF': 'ks--'}

avg = lambda l : sum(l) / len(l)

def geo_mean(iterable):
    a = np.array([abs(i) for i in iterable])
    return a.prod()**(1.0/len(a))

def add_plot(policy, label):
    plt.plot(x, tail_latency[policy], linestyle[policy], linewidth=2,
            markersize=18, markeredgecolor='k', label=label, zorder=3)

num_nodes = [(2 ** (i + 1)) for i in range(10)]
#num_nodes = [(100 * (i + 1)) for i in range(10)]
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

tail_latency = {p:[] for p in policies}

for policy in policies:
    dir_name = '../scale/canny_0_deblur_0_gru_0_harris_0_lstm_0_scale_1024_' \
            + policy + '/debug-trace.txt'

    latency = []

    is_first = True
    elf_index = 0

    for line in open(dir_name):
        if 'Timer #2 stopped' in line:
            if is_first:
                is_first = False
                continue

            latency.append(float(line.split()[9]) / 1000_000)

    for n in num_nodes:
        tail_latency[policy].append(max(latency[0:n]))
        print(policy + ' ' + str(n) + ': ' + str(tail_latency[policy][-1]))
        #print(policy + ' ' + str(n) + ': ' + str(avg(latency[0:n])))

x = [i for i in range(len(num_nodes))]
x_labels = [str(i) for i in num_nodes]

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

add_plot('FCFS', 'FCFS')
add_plot('GEDF_D', 'GEDF-D')
add_plot('GEDF_N', 'GEDF-N')
add_plot('LAX', 'LAX')
add_plot('ELF', 'ELF')

plt.xlabel('Number of nodes', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Tail latency (us)', fontsize=35)
plt.yticks(fontsize=35)
#plt.ylim([-5, 140])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(20))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/scalability.pdf', bbox_inches='tight')
