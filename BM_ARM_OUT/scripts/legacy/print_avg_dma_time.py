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

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

is_fwd = {'canny_non_max': [False],
          'convolution': [False, False],
          'edge_tracking': [False],
          'elem_matrix': [False for i in range(4)],
          'grayscale': [False],
          'harris_non_max': [False],
          'isp': [False]}

for policy in policies:
    print(policy)
    for app_mix in app_mixes:
        fwd_time = []
        mem_time = []

        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '4_'
            else:              app_mix_str += '0_'

        out_file = '../image_4_parallel_dma_xbar/' + app_mix_str + policy + \
                '_pipeline/debug-trace.txt'

        for line in open(out_file):
            if 'SRC:' in line:
                tokens = line.split()

                acc_type = tokens[1].split('.')[2][:-6]
                acc_id = int(tokens[1].split('.')[2][-6])

                src_addr = tokens[2][4:-1]
                dst_addr = tokens[3][4:-1]

                is_fwd[acc_type][acc_id] = '0x000000002' in src_addr and \
                        '0x000000002' in dst_addr

            elif 'Transfer' in line:
                tokens = line.split()

                acc_type = tokens[1].split('.')[2][:-6]
                acc_id = int(tokens[1].split('.')[2][-6])
                transfer_time = float(tokens[5])

                if is_fwd[acc_type][acc_id]:
                    fwd_time.append(transfer_time)
                else:
                    mem_time.append(transfer_time)

        print('  ' + str(app_mix) + ': ' + str(max(fwd_time)) + ', ' + \
                str(max(mem_time)))
