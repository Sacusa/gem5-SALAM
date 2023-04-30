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

def get_stat(application):
    data_movement = 0
    latency = 0

    base_dir_name = '../solo_app_w_fwd/'

    for a in applications:
        base_dir_name += a + '_'
        if a == application: base_dir_name += '1_'
        else:                base_dir_name += '0_'

    filename = base_dir_name + 'GEDF/debug-trace.txt'

    for line in open(filename):
        if 'system.acctest' in line and '_dma' in line:
            tokens = line.split()

            if 'LEN' in line:
                data_movement += int(tokens[4][4:])
            elif 'Transfer' in line:
                latency += float(tokens[5])
            else:
                print('Cannot parse: ' + line)
                exit(-1)

    return data_movement, latency

latency = {0:0}

for application in applications:
    dm, l = get_stat(application)
    if dm in latency: print('COLLISION')
    latency[dm] = l

# add the bars
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

x = sorted(latency.keys())
y = [latency[i] for i in x]
plt.plot(x, y, color='green', marker='o', linewidth=2, markersize=12,
        label='gem5')

# Linear regression
x = np.array(sorted(latency.keys())).reshape((-1, 1))
y = [latency[i] for i in sorted(latency.keys())]
model = LinearRegression().fit(x,y)
print('Score (R^2): ' + str(model.score(x,y)))

intercept = model.intercept_
slope = model.coef_
print('Intercept: ' + str(intercept))
print('Slope: ' + str(slope))

x = sorted(latency.keys())
x = [x[0], x[-1]]
y = [intercept + (slope * i) for i in x]
plt.plot(x, y, color='red', marker='o', linestyle='dashed',
        linewidth=2, markersize=12, label='Regression')

plt.xlabel('Total memory bytes accessed', fontsize=35)

plt.ylabel('Total memory access latency', fontsize=35)

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)

# save the image
plt.savefig('plots/mem_traffic_to_improvement_solo_app.png', bbox_inches='tight')
