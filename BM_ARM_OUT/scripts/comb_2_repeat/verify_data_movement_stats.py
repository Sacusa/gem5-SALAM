#! /u/sgupta45/conda/bin/python3
import itertools
import numpy as np
import sys

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
#policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']
policies = ['HetSched', 'ELF']

app_mixes = sorted([c for c in itertools.combinations(applications, 2)])

for app_mix in app_mixes:
    app_mix_str = ''

    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        trace_data = 0
        stat_data = 0

        dir_name = '../../comb_2_opt_repeat_10_min_3/' + app_mix_str + policy

        for line in open(dir_name + '/debug-trace.txt'):
            if 'DRAM data movement' in line:
                trace_data += int(line.split()[6])

        for line in open(dir_name + '/stats.txt'):
            if 'system.membus.pkt_size_system.cpu.icache.mem_side::total' in line:
                stat_data -= int(line.split()[1])
            elif 'system.membus.pkt_size_system.cpu.dcache.mem_side::system.mem_ctrls.port' in line:
                stat_data -= int(line.split()[1])
            elif 'system.mem_ctrls.bytes_read::total' in line:
                stat_data += int(line.split()[1])
            elif 'system.mem_ctrls.bytes_written::total' in line:
                stat_data += int(line.split()[1])
            elif 'End Simulation Statistics' in line:
                break

        if stat_data == 0: continue
        #print(app_mix, policy, ((stat_data - trace_data) * 100) / stat_data)
        print(app_mix, policy, stat_data - trace_data)
    print()
