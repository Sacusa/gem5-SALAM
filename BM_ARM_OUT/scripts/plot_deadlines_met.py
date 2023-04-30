#! /u/sgupta45/conda/bin/python3
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '.', 'ELF': 'xx', 'xbar': '/'}

def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))

def add_plot(offset, stat_value, policy, label):
    if policy in hatch:
        plt.bar([i+offset for i in x], stat_value, edgecolor='k',
                width=width, label=label, fc='w', hatch=hatch[policy])
    else:
        plt.bar([i+offset for i in x], stat_value, edgecolor='k',
                width=width, label=label, fc='k')

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'ELF']

tot_num_nodes = {'canny': 12, 'deblur': 22, 'gru': 120, 'harris': 18,
        'lstm': 144}

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

dag_deadlines_met = {p:[] for p in policies}
node_deadlines_met = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''
    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '4_'
        else:              app_mix_str += '0_'

    for policy in policies:
        if policy in ['FCFS', 'GEDF_D']:
            dir_name = '../comb_4_scheds/'
        else:
            dir_name = '../comb_4/'
        dir_name += app_mix_str + policy + '/debug-trace.txt'

        value_found = False

        for line in open(dir_name):
            if 'Number of DAG deadlines met' in line:
                dag_deadlines_met[policy].append(int(line.split()[8]))
            elif 'Number of node deadlines met' in line:
                node_deadlines_met[policy].append(int(line.split()[8]))
                value_found = True

        if not value_found:
            dag_deadlines_met[policy].append(0)
            node_deadlines_met[policy].append(0)

    norm_value_dag = max(dag_deadlines_met['LAX'][-1], 1)
    norm_value_node = node_deadlines_met['LAX'][-1]

    for policy in policies:
        dag_deadlines_met[policy][-1] = \
                (dag_deadlines_met[policy][-1] * 100) / norm_value_dag
        node_deadlines_met[policy][-1] /= norm_value_node

for policy in policies:
    node_deadlines_met[policy].append(geo_mean(node_deadlines_met[policy]))
    dag_deadlines_met[policy].append(geo_mean(dag_deadlines_met[policy]))

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ['Mix ' + str(i) for i in range(len(app_mixes))] + ['Gmean']

'''
DAG deadlines met
'''
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.16
add_plot(-(width*2), dag_deadlines_met['FCFS'],   'FCFS',   'FCFS')
add_plot(-width,     dag_deadlines_met['GEDF_D'], 'GEDF_D', 'GEDF-D')
add_plot(0,          dag_deadlines_met['GEDF_N'], 'GEDF_N', 'GEDF-N')
add_plot(width,      dag_deadlines_met['LAX'],    'LAX',    'LAX')
add_plot((width*2),  dag_deadlines_met['ELF'],    'ELF',    'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('DAG deadlines met (%)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 100])
#plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/dag_deadlines_met.pdf', bbox_inches='tight')

'''
Node deadlines met
'''
plt.clf()
plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

#width = 0.16
#add_plot(-(width*2), node_deadlines_met['FCFS'],   'FCFS',   'FCFS')
#add_plot(-width,     node_deadlines_met['GEDF_D'], 'GEDF_D', 'GEDF-D')
#add_plot(0,          node_deadlines_met['GEDF_N'], 'GEDF_N', 'GEDF-N')
#add_plot(width,      node_deadlines_met['LAX'],    'LAX',    'LAX')
#add_plot((width*2),  node_deadlines_met['ELF'],    'ELF',    'ELF')
width = 0.20
add_plot(-((3*width)/2), node_deadlines_met['FCFS'],   'FCFS',   'FCFS')
add_plot(-(width/2),     node_deadlines_met['GEDF_D'], 'GEDF_D', 'GEDF-D')
add_plot((width/2),      node_deadlines_met['GEDF_N'], 'GEDF_N', 'GEDF-N')
add_plot((3*width)/2,    node_deadlines_met['ELF'],    'ELF',    'ELF')

plt.xlabel('Application mix', fontsize=35)
plt.xticks(x, x_labels, fontsize=35, rotation='vertical')

plt.ylabel('Node deadlines met\n(norm. to LAX)', fontsize=35)
plt.yticks(fontsize=35)
plt.ylim([0, 3.5])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.5))

plt.legend(loc="upper left", ncol=5, fontsize=35)
plt.grid(color='silver', linestyle='-', linewidth=1)
plt.savefig('plots/node_deadlines_met.pdf', bbox_inches='tight')
