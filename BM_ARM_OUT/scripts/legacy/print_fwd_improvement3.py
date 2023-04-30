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

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

no_fwd_load_time = {}
fwd_load_time = {}

no_fwd_store_time = {}
fwd_store_time = {}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for acc_type in range(num_acc_types):
        for acc_inst in range(num_instances[acc_type]):
            acc_name = acc_id_to_name[acc_type] + str(acc_inst)

            is_load = False
            is_store = False
            access_size = 0

            # load no fwd time
            out_file = '../image_4_parallel_dma_no_fwd/' + app_mix_str + \
                    'GEDF/debug-trace.txt'

            for line in open(out_file):
                if acc_name in line:
                    if 'SRC:0x000000008' in line and 'DST:0x000000002' in line:
                        is_load = True
                        access_size = int(line.split(' ')[4][4:])

                    elif 'SRC:0x000000002' in line and 'DST:0x000000008' in line:
                        is_store = True
                        access_size = int(line.split(' ')[4][4:])

                    elif 'Transfer completed' in line:
                        transfer_time = float(line.split()[5])

                        if is_load:
                            if access_size in no_fwd_load_time:
                                no_fwd_load_time[access_size].append(transfer_time)
                            else:
                                no_fwd_load_time[access_size] = [transfer_time]
                            is_load = False
                        elif is_store:
                            if access_size in no_fwd_store_time:
                                no_fwd_store_time[access_size].append(transfer_time)
                            else:
                                no_fwd_store_time[access_size] = [transfer_time]
                            is_store = False

            # load fwd time
            out_file = '../image_4_parallel_dma_xbar/' + app_mix_str + 'GEDF' + \
                    '_pipeline/debug-trace.txt'

            for line in open(out_file):
                if acc_name in line:
                    if 'SRC:0x000000002' in line and 'DST:0x000000002' in line:
                        is_load = True
                        access_size = int(line.split(' ')[4][4:])

                    elif 'SRC:0x000000002' in line and 'DST:0x000000008' in line:
                        is_store = True
                        access_size = int(line.split(' ')[4][4:])

                    elif 'Transfer completed' in line:
                        transfer_time = float(line.split()[5])

                        if is_load:
                            if access_size in fwd_load_time:
                                fwd_load_time[access_size].append(transfer_time)
                            else:
                                fwd_load_time[access_size] = [transfer_time]
                            is_load = False
                        elif is_store:
                            if access_size in fwd_store_time:
                                fwd_store_time[access_size].append(transfer_time)
                            else:
                                fwd_store_time[access_size] = [transfer_time]
                            is_store = False

speedup = {}

for access_size in no_fwd_store_time:
    avg_no_fwd_store_time = avg(no_fwd_store_time[access_size])
    print('[NO_FWD_STORE] Access size: ' + str(access_size) + ', avg. no fwd time: ' + \
            str(avg_no_fwd_store_time))
print()

for access_size in fwd_store_time:
    avg_fwd_store_time = avg(fwd_store_time[access_size])
    print('[FWD_STORE] Access size: ' + str(access_size) + ', avg. no fwd time: ' + \
            str(avg_fwd_store_time))
print()

for access_size in no_fwd_load_time:
    avg_no_fwd_load_time = avg(no_fwd_load_time[access_size])
    print('Access size: ' + str(access_size) + ', avg. no fwd time: ' + \
            str(avg_no_fwd_load_time), end='')

    if access_size in fwd_load_time:
        speedup[access_size] = avg(fwd_load_time[access_size]) / avg_no_fwd_load_time
        print(', speedup: ' + str(speedup[access_size]))
    else:
        print()

print('Geomean: ' + str(geo_mean(list(speedup.values()))))
