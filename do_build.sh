#!/bin/bash

scons build/ARM/gem5.opt   -j 16
scons build/ARM/gem5.debug -j 16
