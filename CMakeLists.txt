cmake_minimum_required(VERSION 3.27)

if (CMAKE_CROSSCOMPILING)
    set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/devices/stm32_runtime_l475_vtg/cmake ${CMAKE_MODULE_PATH})
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/devices/stm32_runtime_l475_vtg ${CMAKE_CURRENT_BINARY_DIR}/stm32_runtime_l475_vtg)
else()
    enable_testing()
endif ()

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/application/blinky-pure-c ${CMAKE_CURRENT_BINARY_DIR}/blinky_app)


