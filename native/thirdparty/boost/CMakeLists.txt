# TODO: desktop

add_library(Boost::filesystem STATIC IMPORTED GLOBAL)
set_target_properties(Boost::filesystem PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/../../../android/app/src/main/jniLibs/${ANDROID_ABI}/libboost_filesystem.a)
add_library(Boost::regex STATIC IMPORTED GLOBAL)
set_target_properties(Boost::regex PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/../../../android/app/src/main/jniLibs/${ANDROID_ABI}/libboost_regex.a)
add_library(Boost::system STATIC IMPORTED GLOBAL)
set_target_properties(Boost::system PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/../../../android/app/src/main/jniLibs/${ANDROID_ABI}/libboost_system.a)
