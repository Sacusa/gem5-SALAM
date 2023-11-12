#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

if len(sys.argv) != 2:
    print('Usage: ' + sys.argv[0] + ' <dm>')
    exit(0)

enable_dm = sys.argv[1] == 'yes'
applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
app_mix = ('canny', 'gru', 'lstm')
#app_mix = ('gru', 'harris', 'lstm')
#app_mix = ('canny', 'gru', 'harris')
#app_mix = ('canny', 'harris', 'lstm')
dag_id = 2

app_mix_str = ''
for app in applications:
    app_mix_str += app + '_'
    if app in app_mix: app_mix_str += '1_'
    else:              app_mix_str += '0_'

if enable_dm:
    dir_name = '../../comb_pred_3_enhanced/' + app_mix_str + \
            'ELF_MEM_PRED_AVERAGE_15/debug-trace.txt'
else:
    dir_name = '../../comb_pred_3_no_dm_enhanced/' + app_mix_str + \
            'ELF_MEM_PRED_AVERAGE_15/debug-trace.txt'

count = 0
dag_id = -1
node_id = -1
node_ddl_difference = -1

prev_dag_id = -1
prev_node_id = -1

for line in open(dir_name):
    if 'DAG ID = ' in line:
        prev_dag_id = dag_id
        dag_id = int(line.split()[5])
    elif 'Node ID =' in line:
        prev_node_id = node_id
        node_id = int(line.split()[5])
    elif 'Node deadline difference =' in line:
        node_ddl_difference = int(line.split()[6])
        count += 1

        if prev_dag_id != dag_id or node_id < prev_node_id :
            print(dag_id, node_id, count, node_ddl_difference)
            count = 0

print(dag_id, node_id, node_ddl_difference)
