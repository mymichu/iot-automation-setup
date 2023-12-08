add_subdirectory(mocks)
add_executable(blinky_test ${CMAKE_CURRENT_LIST_DIR}/blinky_test.cpp)

target_link_libraries(blinky_test PRIVATE gtest gtest_main blinky eiger indication_fake movement_fake)
add_test(NAME blinky_test COMMAND blinky_test)

