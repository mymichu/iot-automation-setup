cmake_minimum_required(VERSION 3.16)

set(PLATFORM_FOUND TRUE)

set(FLASH_SCRIPT "flash.jLink")

function(create_jlinkflash_script TARGET_NAME)
    add_custom_target(
        create-flash-script ALL
        DEPENDS ${TARGET_NAME}
        COMMAND echo "erase" > ${FLASH_SCRIPT}
        COMMAND echo "loadfile  ${TARGET_NAME}.hex" >> ${FLASH_SCRIPT}
        COMMAND echo "r" >> ${FLASH_SCRIPT}
        COMMAND echo "qc" >> ${FLASH_SCRIPT}
        WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    )
endfunction(create_jlinkflash_script)

function(add_flash_step)
    if(NOT DEFINED $ENV{JLINK_SERVER})
        add_custom_target(
            flash-hex
            DEPENDS create-flash-script
            COMMAND JLinkExe -IP $ENV{JLINK_SERVER} -Speed 4000 -Device STM32L475VG -si SWD -CommanderScript ${FLASH_SCRIPT} -Log flash.log -ExitOnError 1
            WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        )
    else()
        message(INFO No JLinkServer IP is set. No flash step added.)
    endif()
endfunction(add_flash_step)

function(setup_runtime TARGET_NAME LINKER_FILE LINKER_FLAGS)
    set(FILENAME "${TARGET_NAME}")
    target_link_directories(${TARGET_NAME} PRIVATE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    target_link_options(${TARGET_NAME} PRIVATE -T ${LINKER_FILE} ${LINKER_FLAGS} LINKER:-Map=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${FILENAME}.map)

    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O ihex ${FILENAME} ${FILENAME}.hex
        COMMAND ${CMAKE_OBJCOPY} -O binary ${FILENAME} ${FILENAME}.bin
        WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        COMMENT "Create Target-Application")
endfunction(setup_runtime)

function(set_current_path)
    if(NOT DEFINED CMAKE_RUNTIME_OUTPUT_DIRECTORY)
        message(FATAL_ERROR " CMAKE_RUNTIME_OUTPUT_DIRECTORY variable is not set. Set to a valid folder!")
    endif()
endfunction(set_current_path)

function(setup_flash_step TARGET_NAME)
    create_jlinkflash_script(${TARGET_NAME})
    add_flash_step()
endfunction(setup_flash_step)

function(target_setup_runtime TARGET_NAME)
    set_current_path()
    setup_runtime(${TARGET_NAME} "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../src/STM32L475VGTx_FLASH.ld" "")
    setup_flash_step(${TARGET_NAME})
endfunction(target_setup_runtime)

function(target_setup_runtime_flags TARGET_NAME LINKER_FLAGS)
    if(NOT DEFINED CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
    message(FATAL_ERROR " CMAKE_ARCHIVE_OUTPUT_DIRECTORY variable is not set. Set to a valid folder!")
    endif()
    set_current_path()
    message("${LINKER_FLAGS}")
    setup_runtime(${TARGET_NAME} ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../src/STM32L475VGTx_FLASH.ld "${LINKER_FLAGS}")
    setup_flash_step(${TARGET_NAME})
endfunction(target_setup_runtime_flags)