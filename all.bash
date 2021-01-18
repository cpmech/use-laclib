#!/bin/bash

USE_INTEL=${1:-"OFF"}
WITH_OMP=${2:-"ON"}
OPTIMIZED=${3:-"ON"}

CC=/usr/bin/mpicc
CXX=/usr/bin/mpicxx

if [ "${USE_INTEL}" = "ON" ]; then
    CC=/opt/intel/oneapi/mpi/latest/bin/mpiicc
    CXX=/opt/intel/oneapi/mpi/latest/bin/mpiicpc
fi

BUILD_TYPE="Debug"
if [ "${OPTIMIZED}" = "ON" ]; then
    BUILD_TYPE="Release"
fi

rm -rf ./build

cmake -D A1_USE_INTEL=${USE_INTEL} \
      -D A2_WITH_OMP=${WITH_OMP} \
      -D A3_OPTIMIZED=${OPTIMIZED} \
      -D CMAKE_C_COMPILER=${CC} \
      -D CMAKE_CXX_COMPILER=${CXX} \
      -D CMAKE_BUILD_TYPE=${BUILD_TYPE} \
      -B build

cd build
make
cd ..

./build/src/solve_system
