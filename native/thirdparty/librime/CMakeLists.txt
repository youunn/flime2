configure_file(CMakeLists.txt.in download/CMakeLists.txt)
execute_process(
  COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/download
)
if(result)
  message(FATAL_ERROR "CMake step for librime failed: ${result}")
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/download
)
if(result)
  message(FATAL_ERROR "Build step for librime failed: ${result}")
endif()

add_subdirectory(
  ${CMAKE_CURRENT_BINARY_DIR}/src
  ${CMAKE_CURRENT_BINARY_DIR}/build
  EXCLUDE_FROM_ALL
)

# add_subdirectory(
#   ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src
#   ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/build
#   EXCLUDE_FROM_ALL
# )

# add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/glog)

set(HAVE_SNAPPY TRUE)
option(LEVELDB_BUILD_TESTS "" OFF)
option(LEVELDB_BUILD_BENCHMARKS "" OFF)
option(LEVELDB_INSTALL "" OFF)
add_subdirectory(
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/leveldb
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/leveldb/build
  EXCLUDE_FROM_ALL
)

add_subdirectory(
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/opencc
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/opencc/build
  EXCLUDE_FROM_ALL
)

option(YAML_CPP_BUILD_TOOLS "" OFF)
option(YAML_CPP_BUILD_TESTS "" OFF)
option(YAML_CPP_INSTALL "" OFF)
add_subdirectory(
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/yaml-cpp
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/yaml-cpp/build
  EXCLUDE_FROM_ALL
)