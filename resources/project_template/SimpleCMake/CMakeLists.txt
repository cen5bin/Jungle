CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
project(PROJECT_NAME)
aux_source_directory(src source)
include_directories(${PROJECT_SOURCE_DIR}/include)
link_directories(${PROJECT_SOURCE_DIR}/lib)
add_executable(run ${source})
target_link_libraries(run)
ADD_DEFINITIONS(
    -std=c++11 # Or -std=c++0x
    # Other flags
    )
