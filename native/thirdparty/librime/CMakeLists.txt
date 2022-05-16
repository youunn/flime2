option(BUILD_TEST "" OFF)
option(ENABLE_LOGGING "" OFF)
# set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

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

# add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/glog)

include_directories(${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/include)
if(DEFINED ENV{BOOST_FOR_ANDROID_DIR} AND DEFINED ENV{BOOST_PREBUILD_VERSION})
    include_directories("$ENV{BOOST_FOR_ANDROID_DIR}/build/out/${ANDROID_ABI}/include/boost-$ENV{BOOST_PREBUILD_VERSION}")
else()
    message(FATAL_ERROR "set BOOST_FOR_ANDROID_DIR and BOOST_PREBUILD_VERSION environment in .env")
endif()

set(HAVE_SNAPPY FALSE)
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
file(GLOB OPENCC_HEADERS
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/opencc/src/*.hpp
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/opencc/src/*.h
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/opencc/build/src/opencc_config.h
)
set(OPENCC_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/opencc/build/include)
file(MAKE_DIRECTORY ${OPENCC_INCLUDE_DIR}/opencc)
foreach(header ${OPENCC_HEADERS})
  configure_file(${header} ${OPENCC_INCLUDE_DIR}/opencc COPYONLY)
endforeach()

option(YAML_CPP_BUILD_TOOLS "" OFF)
option(YAML_CPP_BUILD_TESTS "" OFF)
option(YAML_CPP_INSTALL "" OFF)
add_subdirectory(
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/yaml-cpp
  ${CMAKE_CURRENT_BINARY_DIR}/src/thirdparty/src/yaml-cpp/build
  EXCLUDE_FROM_ALL
)

add_subdirectory(
  ${CMAKE_CURRENT_BINARY_DIR}/src
  ${CMAKE_CURRENT_BINARY_DIR}/build
  EXCLUDE_FROM_ALL
)
