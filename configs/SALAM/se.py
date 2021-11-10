# Copyright (c) 2016-2017 ARM Limited
# All rights reserved.
#
# The license below extends only to copyright in the software and shall
# not be construed as granting a license to any other intellectual
# property including but not limited to intellectual property relating
# to a hardware implementation of the functionality of the software
# licensed hereunder.  You may use the software subject to the license
# terms below provided that you ensure that this notice is replicated
# unmodified and in its entirety in all distributions of the software,
# modified or unmodified, in source code or in binary form.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met: redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer;
# redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution;
# neither the name of the copyright holders nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#  Authors:  Andreas Sandberg
#            Chuan Zhu
#            Gabor Dozsa
#

"""This script is the syscall emulation example script from the ARM
Research Starter Kit on System Modeling. More information can be found
at: http://www.arm.com/ResearchEnablement/SystemModeling
"""

from __future__ import print_function
from __future__ import absolute_import

import os
import m5
from m5.util import addToPath
from m5.objects import *
import shlex
import optparse

m5.util.addToPath('..')

from common import ObjectList
from common import MemConfig
from common import Options
from common.cores.arm import HPI
from common.cores.arm import ex5_LITTLE
from common.cores.arm import O3_ARM_v7a
from common.FSConfig  import MemBus

m5.util.addToPath('../example/arm')

import devices

# Pre-defined CPU configurations. Each tuple must be ordered as : (cpu_class,
# l1_icache_class, l1_dcache_class, walk_cache_class, l2_Cache_class). Any of
# the cache class may be 'None' if the particular cache is not present.
cpu_types = {
    "AtomicSimpleCPU" : ( AtomicSimpleCPU, None, None, None, None),
    "MinorCPU" : (MinorCPU,
               devices.L1I, devices.L1D,
               devices.WalkCache,
               devices.L2),
    "HPI" : ( HPI.HPI,
              HPI.HPI_ICache, HPI.HPI_DCache,
              HPI.HPI_WalkCache,
              HPI.HPI_L2),
    "ex5_LITTLE" : ( ex5_LITTLE.ex5_LITTLE,
                     ex5_LITTLE.L1I,
                     ex5_LITTLE.L1D,
                     None,
                     None),
    "O3_ARM_v7a_3" : ( O3_ARM_v7a.O3_ARM_v7a_3,
                     O3_ARM_v7a.O3_ARM_v7a_ICache,
                     O3_ARM_v7a.O3_ARM_v7a_DCache,
                     None,
                     O3_ARM_v7a.O3_ARM_v7aL2)
}


class SimpleSeSystem(System):
    # Use a fixed cache line size of 64 bytes
    cache_line_size = 64

    def __init__(self, options, **kwargs):
        super(SimpleSeSystem, self).__init__(**kwargs)

        # Setup book keeping to be able to use CpuClusters from the
        # devices module.
        self._clusters = []
        self._num_cpus = 0

        # Create a voltage and clock domain for system components
        self.voltage_domain = VoltageDomain(voltage = options.sys_voltage)
        self.clk_domain = SrcClockDomain(clock = options.sys_clock,
                                         voltage_domain = self.voltage_domain)

        # Create the off-chip memory bus.
        self.membus = MemBus()

        # Wire up the system port that gem5 uses to load the kernel
        # and to perform debug accesses.
        self.system_port = self.membus.slave


        # Add CPUs to the system. A cluster of CPUs typically have
        # private L1 caches and a shared L2 cache.
        self.cpu_cluster = devices.CpuCluster(self,
                                              options.num_cpus,
                                              options.cpu_clock, "1V",
                                              *cpu_types[options.cpu_type])

        # Create a cache hierarchy (unless we are simulating a
        # functional CPU in atomic memory mode) for the CPU cluster
        # and connect it to the shared memory bus.
        if self.cpu_cluster.memoryMode() == "timing":
            self.cpu_cluster.addL1()
            self.cpu_cluster.addL2(self.cpu_cluster.clk_domain)
        self.cpu_cluster.connectMemSide(self.membus)

        # Tell gem5 about the memory mode used by the CPUs we are
        # simulating.
        self.mem_mode = self.cpu_cluster.memoryMode()

    def numCpuClusters(self):
        return len(self._clusters)

    def addCpuCluster(self, cpu_cluster, num_cpus):
        assert cpu_cluster not in self._clusters
        assert num_cpus > 0
        self._clusters.append(cpu_cluster)
        self._num_cpus += num_cpus

    def numCpus(self):
        return self._num_cpus

def get_process(argv):
    cwd = os.getcwd()
    process = Process(pid=100, cwd=cwd, cmd=argv, executable=argv[0])
    return process


def create(options, args):
    ''' Create and configure the system object. '''

    system = SimpleSeSystem(options)

    # Tell components about the expected physical memory ranges. This
    # is, for example, used by the MemConfig helper to determine where
    # to map DRAMs in the physical address space.
    system.mem_ranges = [AddrRange(start=0, size=options.mem_size)]

    # Configure the off-chip memory system.
    MemConfig.config_mem(options, system)

    # Parse the command line and get the process
    process = get_process(args)
    for cpu in system.cpu_cluster.cpus:
        cpu.workload = process

    return system


def main():
    parser = optparse.OptionParser()
    Options.addCommonOptions(parser)
    Options.addFSOptions(parser)
    (options, args) = parser.parse_args()

    # Create a single root node for gem5's object hierarchy. There can
    # only exist one root node in the simulator at any given
    # time. Tell gem5 that we want to use syscall emulation mode
    # instead of full system mode.
    root = Root(full_system=False)

    # Populate the root node with a system. A system corresponds to a
    # single node with shared memory.
    root.system = create(options, args)

    # Instantiate the C++ object hierarchy. After this point,
    # SimObjects can't be instantiated anymore.
    m5.instantiate()

    # Start the simulator. This gives control to the C++ world and
    # starts the simulator. The returned event tells the simulation
    # script why the simulator exited.
    event = m5.simulate()

    # Print the reason for the simulation exit. Some exit codes are
    # requests for service (e.g., checkpoints) from the simulation
    # script. We'll just ignore them here and exit.
    print(event.getCause(), " @ ", m5.curTick())
    sys.exit(event.getCode())


if __name__ == "__m5_main__":
    main()
