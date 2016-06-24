CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
set(MODULE_NAME __module_name__)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} source1)
add_executable(${MODULE_NAME} ${source1})
target_link_libraries(${MODULE_NAME} ${PROJECT_DEP_LIST})
set_target_properties(${MODULE_NAME}
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${BIN_DIR}
)

