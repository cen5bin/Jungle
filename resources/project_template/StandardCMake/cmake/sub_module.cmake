CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

file(GLOB SUB_MODULE LIST_DIRECTORIES true ${PROJECT_SOURCE_DIR}/src/* )

message(STATUS ${SUB_MODULE})
foreach(module ${SUB_MODULE})
    IF (IS_DIRECTORY ${module})
        message(STATUS "add sub module ${module}")
        add_subdirectory(${module})
    ENDIF()
endforeach()
