#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'LEDF': '.', 'GLAX': 'xx', 'APRX3': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], total_mem_time[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], total_mem_time[policy], edgecolor='k',
                width=width, label=label, fc='k')

policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3', 'xbar']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

num_acc_types = 7
num_instances = [1, 2, 1, 4, 1, 1, 1]
acc_id_to_name = ['canny_non_max', 'convolution', 'edge_tracking',
        'elem_matrix', 'grayscale', 'harris_non_max', 'isp']
app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

total_mem_time = {p:[] for p in policies}

for policy in policies:
    for app_mix in app_mixes:
        critical_path = [[[] for j in range(num_instances[i])]
                for i in range(num_acc_types)]
        mem_time = [[[] for j in range(num_instances[i])]
                for i in range(num_acc_types)]

        # load the critical path
        out_file = '/u/sgupta45/scheduler/critical_paths/'
        if policy == 'xbar': out_file += 'APRX3/' + '_'.join(app_mix)
        else:                out_file += policy + '/' + '_'.join(app_mix)

        for line in open(out_file):
            tokens = line.split()
            if len(tokens) == 0: continue

            acc_type = int(tokens[0])
            acc_inst = int(tokens[1])
            node_id = int(tokens[2])

            critical_path[acc_type][acc_inst].append(node_id)

        # load all memory access times
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            app_mix_str += '4_' if app in app_mix else '0_'

        out_file = '/u/sgupta45/gem5-SALAM/BM_ARM_OUT/'
        if policy == 'xbar':
            out_file += 'image_4_parallel_dma_xbar/' + app_mix_str + \
                    'APRX3_pipeline/debug-trace.txt'
        else:
            out_file += 'image_4_parallel_dma_bus/' + app_mix_str + policy + \
                    '_pipeline/debug-trace.txt'

        for acc_type in range(num_acc_types):
            for acc_inst in range(num_instances[acc_type]):
                acc_name = acc_id_to_name[acc_type] + str(acc_inst)

                curr_mem_time = 0
                is_compute_valid = False
                dma_op = ''

                for line in open(out_file):
                    if (acc_name in line) or ('Runtime' in line):
                        if 'Transfer completed' in line:
                            dma_time = float(line.split()[5])
                            if 'DST:0x000000008' in dma_op:
                                mem_time[acc_type][acc_inst][-1] += dma_time
                            else:
                                curr_mem_time += dma_time
                        elif is_compute_valid and ('Runtime' in line) and \
                             ('us' in line):
                            mem_time[acc_type][acc_inst].append(curr_mem_time)

                            curr_mem_time = 0
                            is_compute_valid = False

                        if 'SRC:' in line:
                            dma_op = line
                        if '.compute' in line:
                            is_compute_valid = True

        # accumulate compute and mem time on the critical path
        mem_critical = 0

        for acc_type in range(num_acc_types):
            for acc_inst in range(num_instances[acc_type]):
                for i in range(len(mem_time[acc_type][acc_inst])):
                    if i in critical_path[acc_type][acc_inst]:
                        mem_critical += mem_time[acc_type][acc_inst][i]

        total_mem_time[policy].append(mem_critical)

# calculate geo-mean for each policy
for policy in policies:
    if policy == 'GEDF': continue

    for i in range(len(total_mem_time['GEDF'])):
        total_mem_time[policy][i] /= total_mem_time['GEDF'][i]

    total_mem_time[policy].append(geo_mean(total_mem_time[policy]))

x = [i for i in range(len(app_mixes)+1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',  'FCFS')
add_plot(-width,     'LEDF',  'GEDF-D')
add_plot(0,          'GLAX',  'LAX')
add_plot(width,      'APRX3', 'ELF')
add_plot((width*2),  'xbar',  'ELF-xbar')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Time spent on DMA\n(norm. to GEDF-N)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 1.7])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/mem_time_critical.pdf', bbox_inches='tight')
