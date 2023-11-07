#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <interconnect>"
    exit 1
fi

interconnect=$1

scons build/ARM/gem5.opt   -j 16

if [ "$?" -ne 0 ]; then
    exit 1
fi

scons build/ARM/gem5.debug -j 16

if [ "$?" -ne 0 ]; then
    exit 1
fi

cd build/ARM
mv gem5.opt gem5_${interconnect}.opt
mv gem5.debug gem5_${interconnect}.debug
