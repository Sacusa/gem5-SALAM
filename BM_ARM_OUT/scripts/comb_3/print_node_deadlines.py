#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']

app_mix = ('canny', 'gru', 'lstm')
dag_id = 2

app_mix_str = ''
for app in applications:
    app_mix_str += app + '_'
    if app in app_mix: app_mix_str += '1_'
    else:              app_mix_str += '0_'

#dir_name = '../../comb_pred_3_enhanced/' + app_mix_str + \
dir_name = '../../comb_pred_3_no_dm_enhanced/' + app_mix_str + \
        'ELF_MEM_PRED_AVERAGE_15/debug-trace.txt'

node_id = 0
matching_node = False

for line in open(dir_name):
    if ('DAG ID = ' + str(dag_id)) in line:
        matching_node = True
    elif 'Node ID =' in line:
        node_id = int(line.split()[5])
    elif 'Node deadline difference =' in line and matching_node:
        print(str(node_id) + ': ' + line.split()[6])
        matching_node = False
