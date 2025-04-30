cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(blinky_app C CXX ASM)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

# find_package("Coverage" REQUIRED)

if (NOT CMAKE_CROSSCOMPILING)
    MESSAGE(STATUS "Building for host")
    include(FetchContent)

    set(GTEST_DIR ${CMAKE_SOURCE_DIR}/3rdparty/gtest)

    FetchContent_Declare(
        gtest3rd
        GIT_REPOSITORY "https://github.com/google/googletest.git" 
        GIT_TAG "v1.17.0" # renovate: datasource=github-tags depName=google/googletest
        GIT_SHALLOW TRUE
        GIT_PROGRESS TRUE
        SOURCE_DIR "${GTEST_DIR}"
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        LOG_DOWNLOAD ON
    )

    set(ABSEIL_DIR ${CMAKE_SOURCE_DIR}/3rdparty/abseil)

    FetchContent_Declare(
        abseil3rd
        GIT_REPOSITORY "https://github.com/abseil/abseil-cpp.git" 
        
        GIT_TAG "20250127.1" # renovate: datasource=github-tags depName=abseil/abseil-cpp
        GIT_SHALLOW TRUE
        GIT_PROGRESS TRUE
        SOURCE_DIR "${ABSEIL_DIR}"
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        LOG_DOWNLOAD ON
    )
    
    FetchContent_MakeAvailable(gtest3rd)
    FetchContent_MakeAvailable(abseil3rd)

    

endif ()

# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if (CMAKE_CROSSCOMPILING)
    add_subdirectory(../../devices/stm32_bsp_iot_node ${CMAKE_CURRENT_BINARY_DIR}/stm32_bsp_iot_node)
endif ()

add_subdirectory(source)

if (NOT CMAKE_CROSSCOMPILING)
    enable_testing()
    add_subdirectory(test)
endif ()

# add_custom_target(graphviz 
#                   "${CMAKE_COMMAND}" "--graphviz=cmake-target-graph.dot" .
#                   WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")

#conan profile update settings.compiler.libcxx=libstdc++11 default
