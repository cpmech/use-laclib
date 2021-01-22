#!/bin/bash

INTEL=${1:-"OFF"}
MPI=${2:-"OFF"}
OMP=${3:-"OFF"}
OPTIMIZED=${4:-"OFF"}
VERBOSE=${5:-"OFF"}

bash zscripts/do_cmake.bash ${INTEL} ${MPI} ${OMP} ${OPTIMIZED} ${VERBOSE}

cd build
make && make test && cd .. && ./build/src/solve_system
