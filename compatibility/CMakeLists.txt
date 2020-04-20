cmake_minimum_required(VERSION 3.0)

project(
    zif-compatibility 
    VERSION 0.0.1
    DESCRIPTION "functionality in order to enhance zig comptaibility "
    LANGUAGES C)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_BUILD_TYPE Release)

set(EXTERNAL_DIR ${PROJECT_SOURCE_DIR}/../external)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib)

file(GLOB_RECURSE source_files
     "${PROJECT_SOURCE_DIR}/src/*.c")

add_library(zif-compatibility SHARED ${source_files})

target_include_directories(zif-compatibility PUBLIC
    ${PROJECT_SOURCE_DIR}/src/
    ${EXTERNAL_DIR}/raylib/include)

find_library(raylib_lib raylib "${EXTERNAL_DIR}/raylib/lib")
target_link_libraries(zif-compatibility PUBLIC ${raylib_lib})

if(MSVC)
    set_target_properties(zif-compatibility PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
    set_target_properties(zif-compatibility PROPERTIES LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
    set_target_properties(zif-compatibility PROPERTIES LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
endif()

if (UNIX)
    add_custom_command(TARGET zif-compatibility
                   POST_BUILD
                   COMMAND mkdir -p ${CMAKE_BINARY_DIR}/include
                   COMMAND cp ${PROJECT_SOURCE_DIR}/src/*.h ${CMAKE_BINARY_DIR}/include)
elseif (WIN32)
    set(src "${PROJECT_SOURCE_DIR}\\src\\*.h")
    set(dst "${CMAKE_BINARY_DIR}/include")

    add_custom_command(TARGET zif-compatibility
                   POST_BUILD
                   COMMAND xcopy /EIY \"${src}\" \"${dst}\") # please fuck windows' cmd
endif()