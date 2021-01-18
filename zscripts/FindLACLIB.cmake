set(LACLIB_INCLUDE_SEARCH_PATH
    /usr/local/include/laclib
)

set(LACLIB_LIBRARY_SEARCH_PATH
    /usr/local/lib
)

find_path(LACLIB_INC laclib.h ${LACLIB_INCLUDE_SEARCH_PATH})
find_library(LACLIB_LIB NAMES laclib${PLAT} PATHS ${LACLIB_LIBRARY_SEARCH_PATH})

set(LACLIB_FOUND 1)
foreach(var LACLIB_INC LACLIB_LIB)
    if(NOT ${var})
        set(LACLIB_FOUND 0)
    endif(NOT ${var})
endforeach(var)

if(LACLIB_FOUND)
    set(LACLIB_IDIRS ${LACLIB_INC})
    set(LACLIB_LIBS ${LACLIB_LIB})
else()
    message(FATAL_ERROR "cannot find LACLIB")
endif()
