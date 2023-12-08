cmake_minimum_required(VERSION 3.16)
# include(ExternalProject)
# ExternalProject_Add(hall4 
# SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../stm32_hal_l4
# URL ""
# DOWNLOAD_COMMAND ""
# CMAKE_ARGS -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${CMAKE_TOOLCHAIN_FILE} 
# INSTALL_COMMAND ""
# )

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/../stm32_hal_l4 ${CMAKE_CURRENT_BINARY_DIR}/stm32_hal_l4)

project(STM_BSP_IOT_NODE C ASM)

set(CMAKE_C_STANDARD 99)


add_subdirectory(src)

