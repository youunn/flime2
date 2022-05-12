cmake_minimum_required(VERSION 3.10)

project(rime_bridge)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

option(BUILD_TESTING "" OFF)
option(BUILD_SHARED_LIBS "" OFF)

add_subdirectory(thirdparty)

add_library(rime_bridge SHARED src/api.c)
target_link_libraries(rime_bridge PRIVATE rime-static)
target_include_directories(rime_bridge PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/thirdparty/librime/src/src)
