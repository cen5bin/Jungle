CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
set(PROJECG_NAME __project_name__)
project(${PROJECG_NAME})

set(PROJECT_DEP_LIST
    glog
    )


set(THIRDPARTY_DIR ${PROJECT_SOURCE_DIR}/_thirdparty)
set(BUILD_DIR ${PROJECT_SOURCE_DIR}/_build)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/src)
link_directories(${PROJECT_SOURCE_DIR}/lib)


aux_source_directory(src source)
add_executable(run ${source})
add_library(${PROJECG_NAME} SHARED ${source})

target_link_libraries(run ${PROJECT_DEP_LIST})
target_link_libraries(${PROJECG_NAME} ${PROJECT_DEP_LIST})

ADD_DEFINITIONS(
    -std=c++11 # Or -std=c++0x
    # Other flags
    )

set(COMMON_LIBRARIES ${PROJECG_NAME})

include(gtest)
