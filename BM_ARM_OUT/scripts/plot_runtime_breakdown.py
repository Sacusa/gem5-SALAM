#! /u/sgupta45/conda/bin/python3
from enum import auto, Enum
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

class ReadState(Enum):
    FIRST_ARGUMENT = auto()
    REM_ARGUMENTS = auto()
    RESULTS = auto()

def acc_runtime(ax):
    accelerators = ['canny_non_max', 'convolution', 'edge_tracking',
            'elem_matrix', 'grayscale', 'harris_non_max', 'isp']
    acc_config = ['8_2', '32_2', '4_1', '32_2', '8_4', '1_1', '2_4']
    runtime = {'compute': [], 'memory': []}

    for i, acc in enumerate(accelerators):
        runtime['compute'].append([])
        runtime['memory'].append([])
        read_state = ReadState.FIRST_ARGUMENT

        for line in open('../ref_and_sweep/' + acc + '_sweep/' + acc + '_' + \
                acc_config[i] + '/debug-trace.txt'):
            if 'Transfer completed' in line:
                time = float(line.split()[5])

                if read_state.FIRST_ARGUMENT:
                    runtime['memory'][i].append(time)
                    read_state = ReadState.REM_ARGUMENTS
                elif read_state.REM_ARGUMENTS:
                    runtime['memory'][i][-1] += time
                elif read_state.RESULTS:
                    runtime['memory'][i][-1] += time
                    read_state = ReadState.FIRST_ARGUMENT
                else:
                    print('Invalid read state')
                    exit(-1)

            elif ('Runtime' in line) and ('us' in line):
                runtime['compute'][i].append(float(line.split()[1]))
                read_state = ReadState.RESULTS

        avg_compute_ratio = 0
        for j in range(len(runtime['compute'][i])):
            compute_time = runtime['compute'][i][j]
            memory_time = runtime['memory'][i][j]
            avg_compute_ratio += compute_time / (compute_time + memory_time)
        avg_compute_ratio = (avg_compute_ratio / len(runtime['compute'][i])) * 100

        runtime['compute'][i] = avg_compute_ratio
        runtime['memory'][i] = 100 - avg_compute_ratio

    # add the bars
    rects1 = ax.bar(accelerators, runtime['compute'], width, label='Compute',
            edgecolor='k', zorder=3, fc='w', hatch='xx')
    rects2 = ax.bar(accelerators, runtime['memory'], width, label='Data transfer',
            edgecolor='k', zorder=3, bottom=runtime['compute'], fc='w',
            hatch='..')

    # add labels and colors
    ax.set_xlabel('Accelerator', fontsize=25)
    ax.set_xticklabels(accelerators, rotation='vertical')

    ax.set_yticks(range(10, 110, 10))
    ax.set_ylabel('Time (%)', fontsize=25)
    ax.set_ylim([0,120])

    ax.grid(color='silver', linestyle='-', linewidth=1, zorder=0)
    ax.tick_params(axis='both', which='major', labelsize=25)
    ax.legend(ncol=2, fontsize=20)

def pipeline_runtime(ax):
    pipelines = ['canny', 'deblur', 'harris', 'gru', 'lstm']
    runtime = {'compute': [], 'memory': []}

    for i, pipeline in enumerate(pipelines):
        runtime['compute'].append(0)
        runtime['memory'].append(0)
        read_state = ReadState.FIRST_ARGUMENT

        for line in open('../ref_and_sweep/' + pipeline + \
                '_wo_fwd_pipeline/debug-trace.txt'):
            if 'Transfer completed' in line:
                runtime['memory'][i] += float(line.split()[5])

            elif ('Runtime' in line) and ('us' in line):
                runtime['compute'][i] += float(line.split()[1])

        compute_ratio = (runtime['compute'][i] / (runtime['compute'][i] + \
                runtime['memory'][i])) * 100
        runtime['compute'][i] = compute_ratio
        runtime['memory'][i] = 100 - compute_ratio

    # add the bars
    rects1 = ax.bar(pipelines, runtime['compute'], width, label='Compute',
            edgecolor='k', zorder=3, fc='w', hatch='xx')
    rects2 = ax.bar(pipelines, runtime['memory'], width, label='Data transfer',
            edgecolor='k', zorder=3, bottom=runtime['compute'], fc='w',
            hatch='..')

    # add labels and colors
    ax.set_xlabel('Application', fontsize=25)
    ax.set_xticklabels(pipelines, rotation='vertical')

    ax.set_yticks(range(10, 110, 10))
    #ax.set_ylabel('Time (%)', fontsize=25)
    ax.set_ylim([0,120])

    ax.grid(color='silver', linestyle='-', linewidth=1, zorder=0)
    ax.tick_params(axis='both', which='major', labelsize=25)
    ax.legend(ncol=2, fontsize=20)

fig, ax = plt.subplots(1, 2)
width = 0.5

acc_runtime(ax[0])
pipeline_runtime(ax[1])

title_offset = -1
ax[0].set_title('(a)', fontsize=25)
ax[1].set_title('(b)', fontsize=25)

fig.set_size_inches(14, 8)
fig.tight_layout()

# save the image
plt.savefig('plots/runtime_breakdown.pdf')
