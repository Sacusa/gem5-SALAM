#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

def get_stat(app_mix, is_fwd):
    if is_fwd: base_dir_name = '../image_4_parallel_dma_xbar/'
    else:      base_dir_name = '../image_4_parallel_dma_no_fwd/'

    for app in applications:
        base_dir_name += app + '_'
        if app in app_mix: base_dir_name += '4_'
        else:              base_dir_name += '0_'

    value = 0
    stat_found = False

    if is_fwd: filename = base_dir_name + 'GEDF_pipeline/stats.txt'
    else:      filename = base_dir_name + 'GEDF/stats.txt'

    for line in open(filename):
        if 'system.mem_ctrls.totMemAccLat' in line:
            value = float(line.split()[1])
            stat_found = True
            break

    if not stat_found:
        print('Cannot parse the statistic for ' + str(app_mix) + \
                'GEDF. is_fwd=' + str(is_fwd))
        exit(-2)

    return value

app_mixes = sorted(list(itertools.combinations(applications, 3)))
speedup = []

for app_mix in app_mixes:
    no_fwd_latency = get_stat(app_mix, False)
    fwd_latency = get_stat(app_mix, True)
    speedup.append(fwd_latency / no_fwd_latency)
    print(app_mix, speedup[-1])

print('Geomean: ' + str(geo_mean(speedup)))
