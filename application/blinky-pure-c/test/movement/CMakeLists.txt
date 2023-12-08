add_subdirectory(internal)

add_executable(movement_test
        ${CMAKE_CURRENT_LIST_DIR}/movement_test.cpp)
target_link_libraries(movement_test PUBLIC gtest gtest_main movement)
add_test(NAME movement_test COMMAND movement_test)