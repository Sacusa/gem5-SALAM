#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

avg = lambda l : sum(l) / len(l)

accelerators = ['canny_non_max', 'convolution', 'edge_tracking', 'elem_matrix',
        'grayscale', 'harris_non_max', 'isp']
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

print('ACCELERATORS')
print('============')

for accelerator in accelerators:
    compute_time = 0
    mem_time = 0

    for line in open('../solo_acc/' + accelerator + \
            '_ELF_MEM_PRED_NO_PRED_dm_false/debug-trace.txt'):
        if 'Runtime' in line and 'us' in line:
            compute_time += float(line.split()[1])
        elif 'Transfer completed' in line:
            mem_time += float(line.split()[5])

    print(accelerator + ' c/m:' + "{:.2f}".format(compute_time) + '/' + \
            "{:.2f}".format(mem_time))

print()
print('FORWARDING DISABLED')
print('===================')

for app in applications:
    app_mix_str = ''
    for a in applications:
        app_mix_str += a + '_'
        if a == app: app_mix_str += '1_'
        else:        app_mix_str += '0_'

    compute_time = 0
    mem_time = 0

    for line in open('../solo_app_no_fwd/' + app_mix_str + \
            'ELF_MEM_PRED_NO_PRED_dm_false/debug-trace.txt'):
        if 'Runtime' in line and 'us' in line:
            compute_time += float(line.split()[1])
        elif 'Transfer completed' in line:
            mem_time += float(line.split()[5])

    print(app + ' c/m:' + "{:.2f}".format(compute_time) + '/' + \
            "{:.2f}".format(mem_time))

print()
print('FORWARDING ENABLED')
print('==================')

for app in applications:
    app_mix_str = ''
    for a in applications:
        app_mix_str += a + '_'
        if a == app: app_mix_str += '1_'
        else:        app_mix_str += '0_'

    compute_time = 0
    mem_time = 0

    for line in open('../comb_pred_1/' + app_mix_str + \
            'ELF_MEM_PRED_NO_PRED_dm_false/debug-trace.txt'):
        if 'Runtime' in line and 'us' in line:
            compute_time += float(line.split()[1])
        elif 'Transfer completed' in line:
            mem_time += float(line.split()[5])

    print(app + ' c/m:' + "{:.2f}".format(compute_time) + '/' + \
            "{:.2f}".format(mem_time))
