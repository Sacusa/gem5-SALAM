#! /u/sgupta45/conda/bin/python3
from matplotlib.ticker import MaxNLocator
import matplotlib.pyplot as plt

applications = ['canny', 'deblur_5', 'gru_8', 'harris', 'lstm_8']
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

label = {'FCFS': 'FCFS', 'LEDF': 'GEDF-D', 'GEDF': 'GEDF-N', 'GLAX': 'LAX',
        'APRX3': 'ELF'}
marker = {'FCFS': 'o', 'LEDF': '<', 'GEDF': '>', 'GLAX':'v', 'APRX3':'*'}

for application in applications:
    runtime = {}

    for policy in policies:
        runtime[policy] = []

        for num_resources in range(1, 11):
            for line in open('../scheduler_sensitivity_resources/scheduler_' + \
                    policy + '_' + application + '_r_' + str(num_resources) + \
                    '/debug-trace.txt'):
                if '[Median]' in line:
                    tokens = line.split()
                    runtime[policy].append(sum(float(t)
                        for t in tokens[2].split('/')))
                    break

    for policy in policies:
        if policy == 'FCFS': continue
        for i in range(len(runtime[policy])):
            runtime[policy][i] /= runtime['FCFS'][i]
    for i in range(1, len(runtime['FCFS'])):
        runtime['FCFS'][i] /= runtime['FCFS'][0]
    runtime['FCFS'][0] = 1

    plt.clf()
    plt.figure(figsize=(6, 6))
    for p in policies:
        plt.plot(range(1, len(runtime[p])+1), runtime[p], marker=marker[p],
                label=label[p], linewidth=3, markersize=7,
                markeredgecolor='k', markeredgewidth=1)

    plt.rc('axes', axisbelow=True)

    plt.title(application.split('_')[0], fontsize=25)

    plt.xlabel('Number of accelerator instances', fontsize=25)
    plt.xticks(fontsize=25)

    plt.ylabel('Run time (norm. to FCFS)', fontsize=25)
    plt.yticks(fontsize=25)

    plt.gca().yaxis.set_major_locator(MaxNLocator(integer=True))

    #plt.legend(loc="upper left", ncol=1, fontsize=20)
    plt.grid(color='silver', linestyle='-', linewidth=1)
    plt.savefig('plots/sensitivity_resources/' + application + '.pdf',
            bbox_inches='tight', dpi=200)
