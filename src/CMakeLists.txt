set(PROGS
    solve_system
)

set(TESTS
    zz_solver_mumps_seq
)

set(TESTS_MPI_NP2
    zz_solver_mumps_np2
)

foreach(var ${PROGS})
    add_executable(${var} "${var}.cpp")
    target_link_libraries(${var} PUBLIC ${LIBS})
endforeach()

if(A2_MPI)
    foreach(var ${TESTS_MPI_NP2})
        add_executable(${var} "${var}.cpp" zz_mpi_main.cpp)
        add_test(NAME ${var} COMMAND mpirun -np 2 $<TARGET_FILE:${var}>)
        target_link_libraries(${var} PUBLIC ${LIBS})
    endforeach(var)
else()
    foreach(var ${TESTS})
        add_executable(${var} "${var}.cpp")
        add_test(NAME ${var} COMMAND ${var})
        target_link_libraries(${var} PUBLIC ${LIBS})
    endforeach(var)
endif()

add_subdirectory(util)

# copy data dir to build dir
add_custom_command(TARGET solve_system POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/data $<TARGET_FILE_DIR:solve_system>/data
)
