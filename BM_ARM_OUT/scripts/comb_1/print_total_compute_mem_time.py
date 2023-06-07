#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

avg = lambda l : sum(l) / len(l)

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

for policy in policies:
    print(policy)

    for app_mix in applications:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app == app_mix: app_mix_str += '1_'
            else:              app_mix_str += '0_'

        compute_time = 0
        mem_time = 0

        if policy in ['LAX', 'ELF']:
            out_file = '../../comb_pred_1/' + app_mix_str + policy + \
                    '_MEM_PRED_AVERAGE_15/debug-trace.txt'
        else:
            out_file = '../../comb_1/' + app_mix_str + policy + \
                    '/debug-trace.txt'

        for line in open(out_file):
            if 'Runtime' in line and 'us' in line:
                compute_time += float(line.split()[1])
            elif 'Transfer completed' in line:
                mem_time += float(line.split()[5])

        print('  ' + app_mix + ' c/m:' + str(int(compute_time)) + '/' + str(int(mem_time)))
