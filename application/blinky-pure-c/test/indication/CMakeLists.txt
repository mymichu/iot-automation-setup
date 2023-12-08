add_executable(indication_test
        ${CMAKE_CURRENT_LIST_DIR}/indication_test.cpp)

target_link_libraries(indication_test PUBLIC gtest gtest_main indication)
add_test(NAME indication_test COMMAND indication_test)