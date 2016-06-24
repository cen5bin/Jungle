CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
set(PROJECG_NAME ZMQTest)
project(${PROJECG_NAME})

set(PROJECT_DEP_LIST
    glog
    zmq
)

set(CMAKE_CXX_FLAGS -std=c++11)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O2 -pg")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")

set(THIRDPARTY_DIR ${PROJECT_SOURCE_DIR}/_thirdparty)
set(BUILD_DIR ${PROJECT_SOURCE_DIR}/_build)
set(BIN_DIR ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/src)
link_directories(${PROJECT_SOURCE_DIR}/lib)
aux_source_directory(src source)

option(NORMAL_MODE "normal mode" ON)
option(NORMAL_MODE_WITHOUT_TEST "normal mode without test" OFF)
option(OTHER_MAIN_MODE "other main mode" OFF)


IF (${NORMAL_MODE} OR ${NORMAL_MODE_WITHOUT_TEST})
    message(STATUS "build main")
    add_executable(run ${source})
    target_link_libraries(run ${PROJECT_DEP_LIST})
ENDIF()

IF (${NORMAL_MODE} OR ${OTHER_MAIN_MODE})
    message(STATUS "build shared library")
    add_library(${PROJECG_NAME} STATIC ${source})
    target_link_libraries(${PROJECG_NAME} ${PROJECT_DEP_LIST})
    set(COMMON_LIBRARIES ${PROJECG_NAME})
ENDIF()

IF (${OTHER_MAIN_MODE}) 
    message(STATUS "build other main")
    get_filename_component(OTHER_MAIN_TARGET ${OTHER_MAIN_FILE} NAME_WE)
    add_executable(${OTHER_MAIN_TARGET} ${OTHER_MAIN_FILE})
    target_link_libraries(${OTHER_MAIN_TARGET} ${PROJECT_DEP_LIST} ${COMMON_LIBRARIES})
    set_target_properties(${OTHER_MAIN_TARGET}
        PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${BIN_DIR}
    )
ENDIF()

IF (${NORMAL_MODE})
    message(STATUS "build test")
    include(gtest)
ENDIF()

include(sub_module)
