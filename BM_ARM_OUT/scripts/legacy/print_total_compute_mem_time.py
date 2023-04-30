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

for policy in policies:
    print(policy)

    for app_mix in app_mixes:
        app_mix_str = ''
        for app in applications:
            app_mix_str += app + '_'
            if app in app_mix: app_mix_str += '4_'
            else:              app_mix_str += '0_'

        compute_time = 0
        mem_time = 0

        out_file = '../image_4_parallel_dma_bus/' + app_mix_str + policy + \
                '_pipeline/debug-trace.txt'

        for line in open(out_file):
            if 'Runtime' in line and 'us' in line:
                compute_time += float(line.split()[1])
            elif 'Transfer completed' in line:
                mem_time += float(line.split()[5])

        print('  ' + '_'.join(app_mix) + ' c/m:' + str(int(compute_time)) + '/' + str(int(mem_time)))
