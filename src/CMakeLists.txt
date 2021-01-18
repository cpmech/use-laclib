set(PROGS
    solve_system
)

foreach(var ${PROGS})
    add_executable(${var} "${var}.cpp")
    target_link_libraries(${var} PUBLIC ${LIBS})
endforeach()

# copy data dir to build dir
add_custom_command(TARGET solve_system POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/data $<TARGET_FILE_DIR:solve_system>/data
)
