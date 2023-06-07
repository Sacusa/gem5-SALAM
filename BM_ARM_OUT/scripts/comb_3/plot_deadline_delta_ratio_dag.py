#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'LAX': 'xx', 'ELF': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], delta[policy], edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], delta[policy], edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']
deadline = {'canny': 16667, 'deblur': 16667, 'gru': 8000, 'harris': 16667,
        'lstm': 8000}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

delta = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    print(app_mix_str)

    for policy in policies:
        if policy in ['LAX', 'ELF']:
            dir_name = '../../comb_pred_3/' + app_mix_str + policy + \
                    '_MEM_PRED_AVERAGE_15'
        else:
            dir_name = '../../comb_3/' + app_mix_str + policy
        dir_name += '/debug-trace.txt'

        delta[policy].append([])
        dag_id = ''

        print('  ' + policy)

        for line in open(dir_name):
            if 'DAG ID' in line:
                dag_id = int(line.split()[5])
            elif 'DAG deadline difference' in line:
                dag_deadline = deadline[app_mix[dag_id]]
                delta[policy][-1].append(
                        (dag_deadline + float(line.split()[6])) / \
                         dag_deadline)

                print('    ' + app_mix[dag_id] + ': ' + str(delta[policy][-1][-1]))

        delta[policy][-1] = np.quantile(delta[policy][-1],
                [0, 0.25, 0.5, 0.75, 1])[4]

    # normalize the values
    #norm_value = delta['LAX'][-1]
    #for policy in policies:
    #    delta[policy][-1] /= norm_value

# calculate geomean
for policy in policies:
    delta[policy].append(geo_mean(delta[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), 'FCFS',   'FCFS')
add_plot(-width,     'GEDF_D', 'GEDF-D')
add_plot(0,          'GEDF_N', 'GEDF-N')
add_plot(width,      'LAX',    'LAX')
add_plot((width*2),  'ELF',    'ELF')
#width = 0.20
#add_plot(-((3*width)/2), 'FCFS',   'FCFS')
#add_plot(-(width/2),     'GEDF_D', 'GEDF-D')
#add_plot((width/2),      'GEDF_N', 'GEDF-N')
#add_plot((3*width)/2,    'ELF',    'ELF')

plt.xticks(x, x_labels, fontsize=35)

plt.ylabel('Max. deadline violation\n(runtime / deadline)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 4])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3/deadline_delta_ratio_dag.pdf',
        bbox_inches='tight')
