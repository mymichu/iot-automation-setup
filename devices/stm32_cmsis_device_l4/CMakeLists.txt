cmake_minimum_required(VERSION 3.27)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
include(FetchContent)



set(STM_CMSIS_CORE_DIR ${CMAKE_SOURCE_DIR}/3rdparty/stm32_cmsis_core)

FetchContent_Declare(
    stm32_cmsis_core
    GIT_REPOSITORY "https://github.com/STMicroelectronics/cmsis_core.git" 
    GIT_TAG "v5.9.0" # renovate: datasource=github-tags depName=STMicroelectronics/cmsis_core
    GIT_SHALLOW TRUE
    GIT_PROGRESS TRUE
    SOURCE_DIR "${STM_CMSIS_CORE_DIR}"
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD ON
)

set(STM_CMSIS_DEVICE_DIR ${CMAKE_SOURCE_DIR}/3rdparty/stm32_cmsis_device)

FetchContent_Declare(
    stm32_cmsis_device

    GIT_REPOSITORY "https://github.com/STMicroelectronics/cmsis_device_l4.git" 
    GIT_TAG "v1.7.4" # renovate: datasource=github-tags depName=STMicroelectronics/cmsis_device_l4
    GIT_SHALLOW TRUE
    GIT_PROGRESS TRUE
    SOURCE_DIR "${STM_CMSIS_DEVICE_DIR}"
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD ON
)

FetchContent_MakeAvailable(stm32_cmsis_core stm32_cmsis_device)

if(${CMAKE_CROSSCOMPILING})
    set(LIBRARY_NAME stm32_cmsis_device_l4)
    add_library(${LIBRARY_NAME} INTERFACE)
    target_include_directories(${LIBRARY_NAME} INTERFACE ${STM_CMSIS_CORE_DIR}/Include ${STM_CMSIS_DEVICE_DIR}/Include)
endif()