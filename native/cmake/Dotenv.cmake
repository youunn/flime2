cmake_minimum_required(VERSION 3.10)

if(CMAKE_ARGC LESS 4)
  message(FATAL_ERROR "Usage: cmake -P cmake/Env.cmake <dotenv>")
endif()

set(dotenv "${CMAKE_CURRENT_SOURCE_DIR}/../.env")

if(NOT EXISTS "${dotenv}")
  message(FATAL_ERROR "Dot-env file not found: ${dotenv}")
endif()

file(STRINGS "${dotenv}" entries)
foreach(entry IN LISTS entries)
  if(entry MATCHES "^([^=]+)=(.*)$")
    set(key ${CMAKE_MATCH_1})
    set(value ${CMAKE_MATCH_2})

    string(REGEX MATCHALL "\\$[A-Za-z0-9_]+" env_values ${value})
    foreach(env_value IN LISTS env_values)
      string(REPLACE "$" "" env_value ${env_value})
      if(DEFINED ENV{${env_value}})
        string(REPLACE "$${env_value}" $ENV{${env_value}} value ${value})
      else()
        string(REPLACE "$${env_value}" "" value ${value})
      endif()
    endforeach()

    set(ENV{${key}} "${value}")
  else()
    message(FATAL_ERROR "Malformed dotenv entry:\n${entry}")
  endif()
endforeach()
