#! /u/sgupta45/conda/bin/python3
from matplotlib.ticker import MaxNLocator
from scipy import polyval, polyfit
import matplotlib.pyplot as plt

applications = ['canny', 'deblur_5', 'gru_8', 'harris', 'lstm_8']
policies = ['FCFS', 'LEDF', 'GEDF', 'GLAX', 'APRX3']

label = {'FCFS': 'FCFS', 'LEDF': 'GEDF-D', 'GEDF': 'GEDF-N', 'GLAX': 'LAX',
        'APRX3': 'ELF'}
marker = {'FCFS': 'o', 'LEDF': '<', 'GEDF': '>', 'GLAX':'v', 'APRX3':'*'}

for application in applications:
    sched_runtime = {}
    app_runtime = {}
    x = list(range(10, 110, 10))

    for policy in policies:
        sched_runtime[policy] = []
        app_runtime[policy] = []

        for num_dags in x:
            # read scheduler execution time
            for line in open('../scheduler_sensitivity_dags/scheduler_' + \
                    policy + '_' + application + '_' + str(num_dags) + \
                    '/debug-trace.txt'):
                if '[Total]' in line:
                    tokens = line.split()
                    sched_runtime[policy].append(sum(float(t)
                        for t in tokens[2].split('/')))
                    break

        for num_dags in range(1,11):
            # read application execution time
            dirname = '../multi_tenant_runtime/'
            for a in applications:
                dirname += a.split('_')[0] + '_'
                if a == application: dirname += str(num_dags)
                else:                dirname += '0'
                dirname += '_'
            dirname += policy

            for line in open(dirname + '/stats.txt'):
                if 'sim_ticks' in line:
                    app_runtime[policy].append(float(line.split()[1]) / 1000000)
                    break

        # extrapolation function
        a,b,c = polyfit(range(1,11), app_runtime[policy], 2)
        app_runtime[policy] = [polyval([a,b,c], i) for i in x]

    '''
    for policy in policies:
        if policy == 'FCFS': continue
        for i in range(len(sched_runtime[policy])):
            sched_runtime[policy][i] /= sched_runtime['FCFS'][i]
    for i in range(1, len(sched_runtime['FCFS'])):
        sched_runtime['FCFS'][i] /= sched_runtime['FCFS'][0]
    sched_runtime['FCFS'][0] = 1
    '''

    plt.clf()
    plt.figure(figsize=(6, 6))

    for p in policies:
        plt.plot(x, sched_runtime[p], marker=marker[p], label=label[p],
                linewidth=3, markersize=7, markeredgecolor='k',
                markeredgewidth=1)
    for i in range(len(app_runtime['APRX3'])):
        app_runtime['APRX3'][i] = app_runtime['GEDF'][i] - \
                app_runtime['APRX3'][i] + sched_runtime['GEDF'][i]
    plt.plot(x, app_runtime['APRX3'], marker=marker[p], label=label[p],
            linewidth=3, markersize=7, markeredgecolor='k',
            markeredgewidth=1)

    plt.rc('axes', axisbelow=True)

    plt.title(application.split('_')[0], fontsize=25)

    plt.xlabel('Number of DAGs', fontsize=25)
    plt.xticks(fontsize=25)

    plt.ylabel('Run time (norm. to FCFS)', fontsize=25)
    plt.yticks(fontsize=25)

    plt.gca().yaxis.set_major_locator(MaxNLocator(integer=True))

    plt.legend(loc="upper left", ncol=2, fontsize=20)
    plt.grid(color='silver', linestyle='-', linewidth=1)
    plt.savefig('plots/sensitivity_dags/' + application + '.pdf',
            bbox_inches='tight', dpi=200)
