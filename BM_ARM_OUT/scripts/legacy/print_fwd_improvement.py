#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

avg = lambda l : sum(l) / len(l)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

num_acc_types = 7
num_instances = [1, 2, 1, 4, 1, 1, 1]
acc_id_to_name = ['canny_non_max', 'convolution', 'edge_tracking',
        'elem_matrix', 'grayscale', 'harris_non_max', 'isp']

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

mem_transfer_time = {}
spm_transfer_time = {}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        latencies = []

        out_file = '../image_4_parallel_dma_bus/' + app_mix_str + policy + \
                '_pipeline/debug-trace.txt'

        for acc_type in range(num_acc_types):
            for acc_inst in range(num_instances[acc_type]):
                is_mem_transfer = False
                is_spm_transfer = False
                access_size = 0

                acc_name = acc_id_to_name[acc_type] + str(acc_inst)

                for line in open(out_file):
                    if acc_name in line:
                        if 'SRC:0x000000008' in line and 'DST:0x000000002' in line:
                            is_mem_transfer = True
                            access_size = int(line.split(' ')[4][4:])

                        elif 'SRC:0x000000002' in line and 'DST:0x000000002' in line:
                            is_spm_transfer = True
                            access_size = int(line.split(' ')[4][4:])

                        elif 'Transfer completed' in line:
                            transfer_time = float(line.split()[5])

                            if is_mem_transfer:
                                if access_size in mem_transfer_time:
                                    mem_transfer_time[access_size].append(transfer_time)
                                else:
                                    mem_transfer_time[access_size] = [transfer_time]
                                is_mem_transfer = False
                            elif is_spm_transfer:
                                if access_size in spm_transfer_time:
                                    spm_transfer_time[access_size].append(transfer_time)
                                else:
                                    spm_transfer_time[access_size] = [transfer_time]
                                is_spm_transfer = False

speedup = {}

for access_size in mem_transfer_time:
    if access_size in spm_transfer_time:
        speedup[access_size] = avg(spm_transfer_time[access_size]) / avg(mem_transfer_time[access_size])
        print('Access size: ' + str(access_size) + ', speedup: ' + str(speedup[access_size]))

print('Geomean: ' + str(geo_mean(list(speedup.values()))))
