#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

from sklearn.linear_model import LinearRegression

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

def get_stat(app_mix, stat, is_fwd):
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
        if stat in line:
            value = float(line.split()[1])
            stat_found = True
            break

    if not stat_found:
        print('Cannot parse the statistic for ' + str(app_mix) + \
                'GEDF. is_fwd=' + str(is_fwd))
        exit(-2)

    return value

app_mixes = sorted(list(itertools.combinations(applications, 3)))
no_fwd = {}
fwd = {}

for app_mix in app_mixes:
    no_fwd_data_movement = get_stat(app_mix,
            'system.mem_ctrls.bytes_read::total', False) + \
                    get_stat(app_mix, 'system.mem_ctrls.bytes_written::total',
                            False)
    no_fwd_latency = get_stat(app_mix, 'system.mem_ctrls.totMemAccLat', False)

    fwd_data_movement = get_stat(app_mix,
            'system.mem_ctrls.bytes_read::total', True) + \
                    get_stat(app_mix, 'system.mem_ctrls.bytes_written::total',
                            True)
    fwd_latency = get_stat(app_mix, 'system.mem_ctrls.totMemAccLat', True)

    no_fwd[no_fwd_data_movement] = no_fwd_latency
    fwd[fwd_data_movement] = fwd_latency

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

#x = sorted(no_fwd.keys())
#y = [no_fwd[i] for i in x]
#plt.plot(x, y, color='red', marker='o', linestyle='dashed',
#        linewidth=2, markersize=12, label='No fwd')

x = sorted(fwd.keys())
y = [fwd[i] for i in x]
plt.plot(x, y, color='green', marker='o', linewidth=2, markersize=12,
        label='gem5')

# Linear regression
x = np.array(sorted(fwd.keys())).reshape((-1, 1))
y = [fwd[i] for i in sorted(fwd.keys())]
model = LinearRegression().fit(x,y)
print('Score (R^2): ' + str(model.score(x,y)))

intercept = model.intercept_
slope = model.coef_
print('Slope: ' + str(slope))

x = sorted(fwd.keys())
x = [x[0], x[-1]]
y = [intercept + (slope * i) for i in x]
plt.plot(x, y, color='red', marker='o', linestyle='dashed',
        linewidth=2, markersize=12, label='Regression')

plt.xlabel('Total memory bytes accessed', fontsize=35)

plt.ylabel('Total memory access latency', fontsize=35)

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('plots/mem_traffic_to_improvement.png', bbox_inches='tight')
