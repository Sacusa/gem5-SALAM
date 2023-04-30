#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

avg = lambda l : sum(l) / len(l)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

num_acc_types = 7
num_instances = [1, 2, 1, 4, 1, 1, 1]
acc_id_to_name = ['canny_non_max', 'convolution', 'edge_tracking',
        'elem_matrix', 'grayscale', 'harris_non_max', 'isp']

speedup = []

for app in applications:
    app_str = ''
    for a in applications:
        app_str += a + '_'
        if a == app: app_str += '1_'
        else:        app_str += '0_'
    app_str += 'GEDF'

    no_fwd_out_file = '../solo_app_wo_fwd/' + app_str + '/debug-trace.txt'
    fwd_out_file = '../solo_app_w_fwd/' + app_str + '/debug-trace.txt'

    mem_transfer_time = []
    spm_transfer_time = []

    for acc_type in range(num_acc_types):
        for acc_inst in range(num_instances[acc_type]):
            is_load = False
            access_size = 0

            acc_name = acc_id_to_name[acc_type] + str(acc_inst)

            for line in open(no_fwd_out_file):
                if acc_name in line:
                    if 'SRC:0x000000008' in line:
                        is_load = True
                    elif is_load and 'Transfer completed' in line:
                        mem_transfer_time.append(float(line.split()[5]))
                        is_load = False

            for line in open(fwd_out_file):
                if acc_name in line:
                    if 'DST:0x000000002' in line:
                        is_load = True
                    elif is_load and 'Transfer completed' in line:
                        spm_transfer_time.append(float(line.split()[5]))
                        is_load = False

    speedup.append(sum(spm_transfer_time) / sum(mem_transfer_time))

print(speedup)
print('Speedup: ' + str(geo_mean(speedup)))
