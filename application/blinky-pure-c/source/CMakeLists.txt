add_subdirectory(eiger)
add_subdirectory(movement)
add_subdirectory(indication)
add_subdirectory(blinky)

if (CMAKE_CROSSCOMPILING)
    add_subdirectory(system)
   
    add_executable(blinky_app ${CMAKE_CURRENT_LIST_DIR}/main.c)
    target_link_libraries(blinky_app PRIVATE runtime eiger movement indication blinky system stm32bspiotnode)

    find_package(Platform REQUIRED)
    set(LINKER_FLAGS LINKER:--whole-archive -lsystem -specs=nosys.specs LINKER:--no-whole-archive)
    target_setup_runtime_flags(blinky_app "${LINKER_FLAGS}")
endif ()


