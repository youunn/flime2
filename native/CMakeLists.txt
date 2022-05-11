cmake_minimum_required(VERSION 3.10)

project(rime_bridge)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

option(BUILD_TESTING "" OFF)

# add_subdirectory(thirdparty)

set(Boost_STATIC_VERSION 1_78)
set(Boost_INCLUDE_DIR ~/Projects/thirdParty/Boost-for-Android/build/out/${ANDROID_ABI}/include/boost-1_78)

add_library(boost_regex STATIC IMPORTED)
set_target_properties(boost_regex PROPERTIES IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/../android/app/src/main/jniLibs/${ANDROID_ABI}/libboost_regex.a)

add_library(rime_bridge SHARED src/hello.cpp)
target_link_libraries(
  rime_bridge
  PRIVATE boost_regex
)
target_include_directories(rime_bridge PRIVATE ${Boost_INCLUDE_DIR})

# target_link_libraries(rime_bridge rime)
