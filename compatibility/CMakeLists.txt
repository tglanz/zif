cmake_minimum_required(VERSION 3.0)

project(
    zif-compatibility 
    VERSION 0.0.1
    DESCRIPTION "functionality in order to enhance zig comptaibility "
    LANGUAGES C)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_BUILD_TYPE Release)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib)

add_library(zif-compatibility SHARED
    src/compatibility.c)

target_include_directories(zif-compatibility PUBLIC
    ${PROJECT_SOURCE_DIR}/src/
    ${PROJECT_SOURCE_DIR}/../external/raylib/include)

# target_link_directories(zif-compatibility PUBLIC
#     ${PROJECT_SOURCE_DIR}/../external/raylib/lib)

# target_link_libraries(zif-compatibility PUBLIC
#     raylib)

add_custom_command(TARGET zif-compatibility
                   POST_BUILD
                   COMMAND mkdir -p ${CMAKE_BINARY_DIR}/include
                   COMMAND cp ${PROJECT_SOURCE_DIR}/src/*.h ${CMAKE_BINARY_DIR}/include)
