#! /u/sgupta45/conda/bin/python3
from matplotlib.cm import get_cmap
import itertools
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

hatch = {'FCFS': '*', 'GEDF_D': '/', 'GEDF_N': '.' , 'LAX': '\\',
        'HetSched': '||', 'ELF': '++'}

colormap = matplotlib.cm.get_cmap("tab20").colors
colors = {'FCFS': colormap[1], 'GEDF_D': colormap[3], 'GEDF_N': colormap[5],
        'LAX': colormap[9], 'HetSched': colormap[11], 'ELF':  colormap[7]}
edgecolors = {'FCFS': colormap[0], 'GEDF_D': colormap[2],
        'GEDF_N': colormap[4], 'LAX': colormap[8], 'HetSched': colormap[10],
        'ELF':  colormap[6]}

label = {'GEDF_D': 'GEDF-D', 'GEDF_N': 'GEDF-N', 'ELF': 'RELIEF'}

applications = ['canny', 'deblur', 'gru', 'harris', 'lstm']
policies = ['FCFS', 'GEDF_D', 'GEDF_N', 'LAX', 'HetSched', 'ELF']

accelerators = ['canny_non_max', 'convolution', 'edge_tracking', 'elem_matrix',
        'grayscale', 'harris_non_max', 'isp']

def geo_mean(iterable):
    a = np.array([i if i != 0 else 1 for i in iterable])
    return a.prod()**(1.0/len(a))

def harmonic_mean(iterable):
    return len(iterable) / sum(1/i for i in iterable)

def add_dram_plot(offset, policy, label):
    plt.bar([i+offset for i in x], dram_energy[policy],
            edgecolor=edgecolors[policy], width=width, label=label,
            fc=colors[policy], hatch=hatch[policy], zorder=1)
    plt.bar([i+offset for i in x], dram_energy[policy], fc='none',
            edgecolor='k', width=width, zorder=2)

def add_spad_plot(offset, policy, label):
    #plt.bar([i+offset for i in x], spad_energy[policy],
    #        edgecolor=edgecolors[policy], width=width, label=label,
    #        fc=colors[policy], hatch=hatch[policy], zorder=1,
    #        bottom=dram_energy[policy])
    #plt.bar([i+offset for i in x], spad_energy[policy], fc='none',
    #        edgecolor='k', width=width, zorder=2, bottom=dram_energy[policy])
    plt.bar([i+offset for i in x], spad_energy[policy], edgecolor='k',
            width=width, label=label, fc=colors[policy],
            bottom=dram_energy[policy])

def add_accl_plot(offset, policy, label):
    plt.bar([i+offset for i in x], accl_energy[policy], edgecolor='k',
            width=width, label=label, fc=colors[policy],
            bottom=[dram_energy[policy][i]+spad_energy[policy][i] for i in x])

app_mixes = sorted([c for c in itertools.combinations(applications, 3)])

dram_energy = {p:[] for p in policies}
spad_energy = {p:[] for p in policies}
accl_energy = {p:[] for p in policies}
total_energy = {p:[] for p in policies}

for app_mix in app_mixes:
    app_mix_str = ''

    for app in applications:
        app_mix_str += app + '_'
        if app in app_mix: app_mix_str += '1_'
        else:              app_mix_str += '0_'

    for policy in policies:
        iterations = []

        spad_read_energy = {a:0 for a in accelerators}
        spad_write_energy = {a:0 for a in accelerators}
        spad_num_reads = {a:0 for a in accelerators}
        spad_num_writes = {a:0 for a in accelerators}

        spad_leakage_power = {a:0 for a in accelerators}
        total_exec_time = 0

        accl_power = {a:0 for a in accelerators}
        accl_exec_time = {a:0 for a in accelerators}

        dir_name = '../../comb_3_repeat_time_50000/' + \
                app_mix_str + policy

        curr_accelerator = ''

        for line in open(dir_name + '/debug-trace.txt'):
            if 'Finished DAG iterations' in line:
                iterations.append(int(line.split()[6]))
            elif 'Number of DAG deadlines met' in line:
                iterations[-1] = max(iterations[-1], int(line.split()[8]))
            elif 'system.acctest' in line and 'compute' in line:
                curr_accelerator = line.split('.')[2][:-1]
            elif 'SPM Energy Per Read Access' in line:
                spad_read_energy[curr_accelerator] = float(line.split()[5])
            elif 'SPM Energy Per Write Access' in line:
                spad_write_energy[curr_accelerator] = float(line.split()[5])
            elif 'SPM Optimized Leakage Power:' in line:
                spad_leakage_power[curr_accelerator] = \
                        float(line.split()[4]) * 1000_000  # convert to nW
            elif 'Runtime:' in line and 'us' in line:
                accl_exec_time[curr_accelerator] += float(line.split()[1]) / \
                        1000_000  # convert to seconds
            elif 'Accelerator Power:' in line:
                accl_power[curr_accelerator] = float(line.split()[2]) * \
                        1000_000  # convert to nW

        dram_energy[policy].append(0)
        for line in open(dir_name + '/stats.txt'):
            if 'spm.bytes_read::total' in line:
                accelerator = line.split('.')[2][:-5]
                spad_num_reads[accelerator] = int(line.split()[1]) / 64
            elif 'spm.bytes_written::total' in line:
                accelerator = line.split('.')[2][:-5]
                spad_num_writes[accelerator] = int(line.split()[1]) / 64
            elif 'system.mem_ctrls.rank0.totalEnergy' in line:
                dram_energy[policy][-1] = float(line.split()[1]) / 1000
            elif 'sim_seconds' in line:
                total_exec_time = float(line.split()[1])

        spad_energy[policy].append(0)
        accl_energy[policy].append(0)
        for accelerator in accelerators:
            spad_energy[policy][-1] += \
                    (spad_num_reads[accelerator] * \
                     spad_read_energy[accelerator]) + \
                    (spad_num_writes[accelerator] * \
                     spad_write_energy[accelerator]) + \
                    (spad_leakage_power[accelerator] * total_exec_time)
            accl_energy[policy][-1] += accl_power[accelerator] * \
                    accl_exec_time[accelerator]

        iterations = sum(iterations)
        dram_energy[policy][-1] /= iterations
        spad_energy[policy][-1] /= iterations
        accl_energy[policy][-1] /= iterations

    norm_dram_energy = dram_energy['LAX'][-1]
    norm_spad_energy = spad_energy['LAX'][-1]
    norm_accl_energy = accl_energy['LAX'][-1]
    #norm_total_energy = norm_dram_energy + norm_spad_energy + norm_accl_energy
    norm_total_energy = norm_dram_energy + norm_spad_energy

    for policy in policies:
        dram_energy[policy][-1] /= norm_total_energy
        spad_energy[policy][-1] /= norm_total_energy
        accl_energy[policy][-1] /= norm_total_energy
        #total_energy[policy].append(dram_energy[policy][-1] + \
        #        spad_energy[policy][-1] + accl_energy[policy][-1])
        total_energy[policy].append(dram_energy[policy][-1] + \
                spad_energy[policy][-1])

# calculate geomean
for policy in policies:
    #avg_percent_dram = geo_mean([dram_energy[policy][i] / \
    #        total_energy[policy][i] for i in range(len(total_energy[policy]))])
    #avg_percent_spad = geo_mean([spad_energy[policy][i] / \
    #        total_energy[policy][i] for i in range(len(total_energy[policy]))])
    #avg_percent_accl = geo_mean([accl_energy[policy][i] / \
    #        total_energy[policy][i] for i in range(len(total_energy[policy]))])
    #avg_total_energy = geo_mean(total_energy[policy])
    #
    #print(avg_percent_dram + avg_percent_spad + avg_percent_accl)

    dram_energy[policy].append(geo_mean(dram_energy[policy]))
    spad_energy[policy].append(geo_mean(spad_energy[policy]))
    accl_energy[policy].append(geo_mean(accl_energy[policy]))

print((dram_energy['HetSched'][-1] - dram_energy['ELF'][-1]) / dram_energy['HetSched'][-1])
print((spad_energy['HetSched'][-1] - spad_energy['ELF'][-1]) / spad_energy['HetSched'][-1])
max_gain = 0
for i in range(len(app_mixes)):
    for policy in policies:
        max_gain = max(max_gain, (dram_energy[policy][i] - \
                dram_energy['ELF'][i]) / dram_energy[policy][i])
print(max_gain)
max_gain = 0
for i in range(len(app_mixes)):
    for policy in policies:
        max_gain = max(max_gain, (spad_energy[policy][i] - \
                spad_energy['ELF'][i]) / spad_energy[policy][i])
print(max_gain)

x = [i for i in range(len(app_mixes) + 1)]
x_labels = ["".join([a[0].upper() for a in app_mix])
        for app_mix in app_mixes] + ['Gmean']

plt.figure(figsize=(24, 8), dpi=600)
plt.rc('axes', axisbelow=True)

width = 0.8 / len(policies)
if len(policies) % 2 == 0:
    offset = -width * (0.5 + ((len(policies) / 2) - 1))
else:
    offset = -width * ((len(policies) - 1) / 2)
for policy in policies:
    #plabel = 'ACCL: ' if policy == 'FCFS' else ''
    #plabel += label[policy] if policy in label else policy
    #add_accl_plot(offset, policy, plabel)
    
    plabel = 'SPAD: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_spad_plot(offset, policy, plabel)

    plabel = 'DRAM: ' if policy == 'FCFS' else ''
    plabel += label[policy] if policy in label else policy
    add_dram_plot(offset, policy, plabel)

    offset += width

plt.xticks(x, x_labels, fontsize=30)

plt.ylabel('Memory energy (norm. to LAX)', fontsize=30)
plt.yticks(fontsize=30)
plt.ylim([0, 1.8])
plt.gca().yaxis.set_major_locator(plt.MultipleLocator(0.2))

plt.legend(loc="upper left", ncol=len(policies), fontsize=25)
plt.grid(axis='y', color='silver', linestyle='-', linewidth=1)
plt.savefig('../plots/comb_3_repeat/data_movement_energy.pdf',
        bbox_inches='tight')
