set(MKL_ROOT /opt/intel/oneapi/mkl/latest)
set(IOMP_ROOT /opt/intel/oneapi/compiler/latest/linux/compiler)

set(MKL_INCLUDE_SEARCH_PATH
    ${MKL_ROOT}/include
)

set(MKL_LIBRARY_SEARCH_PATH
    ${MKL_ROOT}/lib/intel64
)

set(IOMP_LIBRARY_SEARCH_PATH
    ${MKL_ROOT}/lib/intel64_lin
)

find_path(MKL_INC mkl.h ${MKL_INCLUDE_SEARCH_PATH})
find_library(MKL_LIB_1 NAMES mkl_intel_lp64 PATHS ${MKL_LIBRARY_SEARCH_PATH})
find_library(MKL_LIB_2 NAMES mkl_intel_thread PATHS ${MKL_LIBRARY_SEARCH_PATH})
find_library(MKL_LIB_3 NAMES mkl_core PATHS ${MKL_LIBRARY_SEARCH_PATH})

set(MKL_FOUND 1)

foreach(var MKL_INC MKL_LIB_1 MKL_LIB_2 MKL_LIB_3)
    if(NOT ${var})
        set(MKL_FOUND 0)
    endif(NOT ${var})
endforeach(var)

if(MKL_FOUND)
    set(MKL_IDIRS ${MKL_INC})
    set(MKL_LIBS ${MKL_LIB_1} ${MKL_LIB_2} ${MKL_LIB_3} iomp5 pthread m dl)
else()
    message(FATAL_ERROR "cannot find MKL")
endif()