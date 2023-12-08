


add_library(system STATIC
        ${CMAKE_CURRENT_LIST_DIR}/SystemClock.c
        ${CMAKE_CURRENT_LIST_DIR}/SystemClock.h
        ${CMAKE_CURRENT_LIST_DIR}/platform-controller/stm32l4xx_it.c
        ${CMAKE_CURRENT_LIST_DIR}/platform-controller/stm32l4xx_hal_timebase_TIM.c)
target_include_directories(system PUBLIC ${CMAKE_CURRENT_LIST_DIR})
target_link_libraries(system PUBLIC
        stm32bspiotnode
        stm32hallm4)

#target_configure_coverage(system)