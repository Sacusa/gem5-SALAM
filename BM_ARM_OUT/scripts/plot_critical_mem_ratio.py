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
        plt.bar([i+offset for i in x], mem_ratio[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], mem_ratio[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

num_acc_types = 7
num_instances = [1, 2, 1, 4, 1, 1, 1]
acc_id_to_name = ['canny_non_max', 'convolution', 'edge_tracking',
        'elem_matrix', 'grayscale', 'harris_non_max', 'isp']
app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

mem_ratio = {p:[] for p in policies}

for policy in policies:
    for app_mix in app_mixes:
        critical_path = [[[] for j in range(num_instances[i])]
                for i in range(num_acc_types)]
        compute_time = [[[] for j in range(num_instances[i])]
                for i in range(num_acc_types)]
        mem_time = [[[] for j in range(num_instances[i])]
                for i in range(num_acc_types)]

        # load the critical path
        out_file = '/u/sgupta45/scheduler/critical_paths/' + policy + '/' + \
                '_'.join(app_mix)
        for line in open(out_file):
            tokens = line.split()
            if len(tokens) == 0: continue

            acc_type = int(tokens[0])
            acc_inst = int(tokens[1])
            node_id = int(tokens[2])

            critical_path[acc_type][acc_inst].append(node_id)

        # load all compute and memory access times
        out_file = '/u/sgupta45/gem5-SALAM/BM_ARM_OUT/image_4/'
        for app in applications:
            out_file += app + '_'
            out_file += '4_' if app in app_mix else '0_'
        out_file += policy + '_pipeline/debug-trace.txt'

        for acc_type in range(num_acc_types):
            for acc_inst in range(num_instances[acc_type]):
                acc_name = acc_id_to_name[acc_type] + str(acc_inst)

                curr_mem_time = 0
                is_compute_valid = False
                dma_op = ''

                for line in open(out_file):
                    if (acc_name in line) or ('Runtime' in line):
                        if ('Transfer completed' in line) and \
                           ('DST:0x000000008' not in dma_op):
                            curr_mem_time += float(line.split()[5])
                        elif is_compute_valid and ('Runtime' in line) and \
                             ('us' in line):
                            compute_time[acc_type][acc_inst].append(
                                    float(line.split()[1]))
                            mem_time[acc_type][acc_inst].append(curr_mem_time)

                            curr_mem_time = 0
                            is_compute_valid = False

                        if 'SRC:' in line:
                            dma_op = line
                        if '.compute' in line:
                            is_compute_valid = True

        # accumulate compute and mem time on the critical path
        compute_critical = 0
        mem_critical = 0

        for acc_type in range(num_acc_types):
            for acc_inst in range(num_instances[acc_type]):
                for i in range(len(compute_time[acc_type][acc_inst])):
                    if i in critical_path[acc_type][acc_inst]:
                        compute_critical += compute_time[acc_type][acc_inst][i]
                        mem_critical += mem_time[acc_type][acc_inst][i]

        total_time = compute_critical + mem_critical
        mem_ratio[policy].append((mem_critical / total_time) * 100)

# calculate geo-mean for each policy
for policy in policies:
    mem_ratio[policy].append(geo_mean(mem_ratio[policy]))

x = [i for i in range(len(app_mixes)+1)]
x_labels = [','.join(app_mix) for app_mix in app_mixes] + ['Geomean']

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

plt.ylabel('% time spent on DMA transfers', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 70])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/mem_ratio_critical.pdf', bbox_inches='tight')
