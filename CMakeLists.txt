cmake_minimum_required(VERSION 3.16)
project(Project)

set(CMAKE_CXX_STANDARD 17)

# options ####################################################################################

option(A1_USE_INTEL "use Intel MKL and MPI" OFF)
option(A2_WITH_OMP "with OpenMP" ON)
option(A3_OPTIMIZED "Make optimized (-O3)" ON)

set(PLAT "_open")

if(A1_USE_INTEL)
    add_definitions(-DUSE_INTEL -diag-disable=2196) # disable warning due to doctest.h functions: warning #2196: routine is both "inline" and "noinline"
    set(PLAT "_intel")
endif()

if(A2_WITH_OMP)
    set(PLAT "${PLAT}_omp")
endif()

if(A3_OPTIMIZED)
    add_definitions(-O3)
else()
    add_definitions(-g -Wall)
endif()

# dependencies ###############################################################################

if(A1_USE_INTEL)
    include(zscripts/FindMKL.cmake)
    include_directories(${MKL_IDIRS})
    set(LA_LIBS ${MKL_LIBS})
else()
    include(zscripts/FindOBLAS.cmake)
    include_directories(${OBLAS_IDIRS})
    set(LA_LIBS ${OBLAS_LIBS})
endif()

include(zscripts/FindMUMPS.cmake)
include_directories(${MUMPS_IDIRS})

include(zscripts/FindLACLIB.cmake)
include_directories(${LACLIB_IDIRS})

set(LIBS ${MUMPS_LIBS} ${LA_LIBS} ${LACLIB_LIBS})

# subdirectories #############################################################################

add_subdirectory(src)
