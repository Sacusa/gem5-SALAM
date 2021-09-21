#!/bin/bash

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 <num lanes> <spm_ports>"
    exit -1
fi

num_lanes=$1
spm_ports=$2

sed -i '12s/.*/    #pragma clang loop unroll_count('"${num_lanes}"')/' hw/isp.c
sed -i '/ports = /c\ports = '"${spm_ports}" hw/isp.ini
