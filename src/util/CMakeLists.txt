set(TESTS
    zz_say_hello
)

set(TESTS_MPI_NP3
    zz_doctest_mpi
)

foreach(var ${TESTS})
    add_executable(${var} "${var}.cpp")
    add_test(NAME ${var} COMMAND ${var})
endforeach(var)

if(A2_MPI)
    foreach(var ${TESTS_MPI_NP3})
        add_executable(${var} "${var}.cpp" zz_doctest_main.cpp)
        add_test(NAME ${var} COMMAND mpirun -np 3 $<TARGET_FILE:${var}>)
        target_link_libraries(${var} PUBLIC ${LIBS})
    endforeach(var)
endif()
