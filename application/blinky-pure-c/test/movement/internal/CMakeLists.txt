add_executable(movement_internal_test
        ${CMAKE_CURRENT_LIST_DIR}/rotation_test.cpp
        ${CMAKE_CURRENT_LIST_DIR}/tracker_test.cpp)
target_link_libraries(movement_internal_test PUBLIC gtest gtest_main movement)
add_test(NAME movement_internal_test COMMAND movement_internal_test)
