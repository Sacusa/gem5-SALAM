#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'LEDF': '.', 'GLAX': 'xx', 'APRX3': '/'}

def geo_mean(iterable):
    a = np.absolute(np.array(iterable))
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], avg_error[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], avg_error[policy], edgecolor='k',
                width=width, label=label, fc='k')

policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

num_acc_types = 7
num_instances = [1, 2, 1, 4, 1, 1, 1]
acc_id_to_name = ['canny_non_max', 'convolution', 'edge_tracking',
        'elem_matrix', 'grayscale', 'harris_non_max', 'isp']
app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

# the first value is the value used by perf model
load_time = {acc:[] for acc in acc_id_to_name}
compute_time = {acc:[] for acc in acc_id_to_name}
store_time = {acc:[] for acc in acc_id_to_name}

# load the perf model time
for acc in acc_id_to_name:
    load_time[acc].append(0)
    compute_time[acc].append(0)
    store_time[acc].append(0)

    is_mem = False
    is_load = False

    for line in open('/u/sgupta45/gem5-SALAM/BM_ARM_OUT/solo_acc/' + acc + \
            '/debug-trace.txt'):
        if is_mem:
            if is_load:
                load_time[acc][0] += float(line.split()[5])
            else:
                store_time[acc][0] += float(line.split()[5])
            is_mem = False

        elif 'SRC:0x000000008' in line:
            is_mem = True
            is_load = True

        elif 'DST:0x000000008' in line:
            is_mem = True
            is_load = False

        elif 'Runtime' in line and 'us' in line:
            compute_time[acc][0] += float(line.split()[1])

LOAD_COMPUTE_TIME, STORE_TIME = range(2)
avg_error = {p:[] for p in policies}

for policy in policies:
    del load_time[acc][1:]
    del compute_time[acc][1:]
    del store_time[acc][1:]

    for app_mix in app_mixes:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            app_mix_str += '4_' if app in app_mix else '0_'

        out_file = '/u/sgupta45/gem5-SALAM/BM_ARM_OUT/' + \
                'image_4_parallel_dma_bus/' + app_mix_str + policy + \
                '_pipeline/debug-trace.txt'

        for acc_type in range(num_acc_types):
            for acc_inst in range(num_instances[acc_type]):
                acc = acc_id_to_name[acc_type]
                acc_name = acc + str(acc_inst)

                is_compute = False
                is_mem = False
                is_load = False
                create_new_entries = True

                curr_state = LOAD_COMPUTE_TIME

                for line in open(out_file):
                    if (acc_name in line) or is_compute:
                        if create_new_entries:
                            load_time[acc].append(0)
                            compute_time[acc].append(0)
                            store_time[acc].append(0)
                            create_new_entries = False

                        if curr_state == LOAD_COMPUTE_TIME:
                            if is_mem:
                                load_time[acc][-1] += float(line.split()[5])
                                is_mem = False
                            elif 'DST:0x000000002' + str(acc_type+1) in line:
                                is_mem = True
                            elif 'DST:0x000000008' in line:
                                print('Store encountered when looking for load/compute')
                                exit()
                            elif is_compute and 'Runtime' in line and 'us' in line:
                                compute_time[acc][-1] += float(line.split()[1])
                                curr_state = STORE_TIME
                                is_compute = False
                            elif acc_name + '.compute' in line:
                                is_compute = True

                        elif curr_state == STORE_TIME:
                            if is_mem:
                                store_time[acc][-1] += float(line.split()[5])
                                is_mem = False
                                create_new_entries = True
                                curr_state = LOAD_COMPUTE_TIME
                            elif 'DST:0x000000002' + str(acc_type+1) in line:
                                create_new_entries = True
                                curr_state = LOAD_COMPUTE_TIME
                                is_mem = True
                                is_load = True
                            elif 'DST:0x000000008' in line:
                                is_mem = True
                                is_load = False
                            elif 'Runtime' in line and 'us' in line:
                                print('Compute encountered when looking for store')
                                exit()

    avg_time = {acc:[] for acc in acc_id_to_name}
    for acc in acc_id_to_name:
        #avg_load = sum(load_time[acc][1:]) / len(load_time[acc][1:])
        #avg_compute = sum(compute_time[acc][1:]) / len(compute_time[acc][1:])
        #avg_store = sum(store_time[acc][1:]) / len(store_time[acc][1:])

        for i in range(1, len(load_time[acc][1:])):
            avg_time[acc].append(load_time[acc][i] + compute_time[acc][i] + \
                    store_time[acc][i])
        avg_time[acc] = sum(avg_time[acc]) / len(avg_time[acc])

        est_total = load_time[acc][0] + compute_time[acc][0] + store_time[acc][0]
        avg_error[policy].append(((avg_time[acc] - est_total) / avg_time[acc]) * 100)

    # calculate geo-mean
    avg_error[policy].append(geo_mean(avg_error[policy]))

x = [i for i in range(len(acc_id_to_name)+1)]
x_labels = acc_id_to_name + ['Gmean of abs. error']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',  'FCFS')
add_plot(-width,     'LEDF',  'GEDF-D')
add_plot(0,          'GEDF',  'GEDF-N')
add_plot(width,      'GLAX',  'LAX')
add_plot((width*2),  'APRX3', 'ELF')

plt.xlabel('Accelerator', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Average error across all\napplication mixes (%)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([-45, 30])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/perf_model_accuracy.pdf', bbox_inches='tight')
