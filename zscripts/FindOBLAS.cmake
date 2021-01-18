# show dirs with:
#  dpkg-query -L libopenblas-pthread-dev
#  dpkg-query -L liblapacke-dev

set(OBLAS_INCLUDE_SEARCH_PATH
    /usr/include
    /usr/include/x86_64-linux-gnu/openblas-pthread
)

set(OBLAS_LIBRARY_SEARCH_PATH
    /usr/lib/x86_64-linux-gnu
    /usr/lib/x86_64-linux-gnu/openblas-pthread
)

find_path(OBLAS_INC_1 cblas.h ${OBLAS_INCLUDE_SEARCH_PATH})
find_path(OBLAS_INC_2 lapacke.h ${OBLAS_INCLUDE_SEARCH_PATH})
find_library(OBLAS_LIB_1 NAMES openblas PATHS ${OBLAS_LIBRARY_SEARCH_PATH})
find_library(OBLAS_LIB_2 NAMES lapacke PATHS ${OBLAS_LIBRARY_SEARCH_PATH})

set(OBLAS_FOUND 1)

foreach(var OBLAS_INC_1 OBLAS_INC_2 OBLAS_LIB_1 OBLAS_LIB_2)
    if(NOT ${var})
        set(OBLAS_FOUND 0)
    endif(NOT ${var})
endforeach(var)

if(OBLAS_FOUND)
    set(OBLAS_IDIRS ${OBLAS_INC_1} ${OBLAS_INC_2})
    set(OBLAS_LIBS ${OBLAS_LIB_1} ${OBLAS_LIB_2})
else()
    message(FATAL_ERROR "cannot find OpenBLAS (and/or Lapacke)")
endif()