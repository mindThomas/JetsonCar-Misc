# Copyright (C) 2018-2020 Thomas Jespersen, TKJ Electronics. All rights reserved.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the MIT License
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the MIT License for further details.
#
# Contact information
# ------------------------------------------
# Thomas Jespersen, TKJ Electronics
# Web      :  http://www.tkjelectronics.dk
# e-mail   :  thomasj@tkjelectronics.dk
# ------------------------------------------


project(JetsonCar-Misc)

cmake_minimum_required(VERSION 3.1)

message("##################################\n"
        "# Thomas' Automatic CMake loader #\n"
        "##################################")

## Add support for C++11
#add_definitions(-std=c++11)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS NO) # use -std=c++14 instead of -std=gnu++14

#include(CheckCXXCompilerFlag)
#CHECK_CXX_COMPILER_FLAG("-march=native" COMPILER_SUPPORTS_MARCH_NATIVE)
#if(COMPILER_SUPPORTS_MARCH_NATIVE)
#    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
#endif()
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=x86-64 -mavx")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Winit-self -D_FORTIFY_SOURCE=2 -fstack-protector-strong") # "-Werror=format-security -Werror=implicit-function-declaration"
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -DNDEBUG") # Disable assert() in release builds
set(COMMON_LINK_FLAGS "") # "-Wl,--copy-dt-needed-entries -Wl,-E -Wl,-z,relro,-z,now -Wl,--as-needed -Wl,-z,noexecstack"

## Use -pthread or the compiler's equivalent
find_package(Threads REQUIRED)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)

## Make sure -fPIC is enabled
set(CMAKE_POSITION_INDEPENDENT_CODE True)
# -pie is needed here because of https://gitlab.kitware.com/cmake/cmake/issues/14983
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${COMMON_LINK_FLAGS} -pie")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${COMMON_LINK_FLAGS}")
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} ${COMMON_LINK_FLAGS}")

## For using pkg-config to find library flags
find_package(PkgConfig)

# build type
if(CMAKE_BUILD_TYPE STREQUAL "")
  unset(CMAKE_BUILD_TYPE CACHE) # no ambiguity
endif()
set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "RelWithDebInfo, Release or Debug")

message(STATUS "Default Compile flags [current build: ${CMAKE_BUILD_TYPE}]")
message(STATUS "  CMAKE_C_FLAGS_DEBUG: ${CMAKE_C_FLAGS_DEBUG}")
message(STATUS "  CMAKE_C_FLAGS_RELEASE: ${CMAKE_C_FLAGS_RELEASE}")
message(STATUS "  CMAKE_C_FLAGS_RELWITHDEBINFO: ${CMAKE_C_FLAGS_RELWITHDEBINFO}")
message(STATUS "  CMAKE_C_FLAGS_MINSIZEREL: ${CMAKE_C_FLAGS_MINSIZEREL}")

message(STATUS "  CMAKE_CXX_FLAGS_DEBUG: ${CMAKE_CXX_FLAGS_DEBUG}")
message(STATUS "  CMAKE_CXX_FLAGS_RELEASE: ${CMAKE_CXX_FLAGS_RELEASE}")
message(STATUS "  CMAKE_CXX_FLAGS_RELWITHDEBINFO: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
message(STATUS "  CMAKE_CXX_FLAGS_MINSIZEREL: ${CMAKE_CXX_FLAGS_MINSIZEREL}")
message(STATUS "\n--")

#LIST(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake_common)
include(cmake_common/cuda.cmake)
include(cmake_common/qt5.cmake) # MUST COME BEFORE pcl.cmake
include(cmake_common/pcl.cmake)
include(cmake_common/eigen/eigen.cmake)
include(cmake_common/opencv/opencv3.cmake)
include(cmake_common/pangolin/pangolin.cmake)
include(cmake_common/openmp.cmake) # for code optimization
include(cmake_common/yaml/yaml.cmake)
include(cmake_common/easy_profiler/easy_profiler.cmake) # profiling tool
include(cmake_common/openblas/openblas.cmake)
include(cmake_common/easy_profiler/easy_profiler.cmake) # profiling tool
include(cmake_common/acado/acado.cmake) # for MPC code generation
include(cmake_common/mrpt/mrpt.cmake)
include(cmake_common/gtsam/gtsam.cmake)
include(cmake_common/g2o/g2o.cmake)

find_package(Boost REQUIRED COMPONENTS system signals python thread program_options regex filesystem QUIET)
mark_as_advanced(BOOST_THREAD_LIBRARY)

find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)

include_directories(... ${OpenCV_INCLUDE_DIRS})
include_directories(... ${ACADO_INCLUDE_DIRS})
include_directories(... ${Boost_INCLUDE_DIRS})
link_directories(... ${Boost_LIBRARY_DIRS})

include_directories(include)

# Make a compiler flag for the current source folder path
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__SOURCE_FOLDER__='\"$(dir $(abspath $<))\"'")

# Place the executable in the root of build folder
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "../../")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "../")

## Loading parts below
message(STATUS "\n--")
message(STATUS "Root directory: " ${CMAKE_CURRENT_SOURCE_DIR})

# Load Global Headers placed in include folder
set(GLOBAL_HEADERS "")
add_subdirectory(include)

MACRO(HEADER_DIRECTORIES return_list)
    FILE(GLOB_RECURSE new_list *.h)
    SET(dir_list "")
    FOREACH(file_path ${new_list})
        GET_FILENAME_COMPONENT(dir_path ${file_path} PATH)
        SET(dir_list ${dir_list} ${dir_path})
    ENDFOREACH()
    LIST(REMOVE_DUPLICATES dir_list)
    SET(${return_list} ${dir_list})
ENDMACRO()

MACRO(CMAKE_DIRECTORIES return_list)
    set(EXCLUDE_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
    set(EXCLUDE_LIBS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libs)
    FILE(GLOB_RECURSE new_list CMakeLists.txt)
    SET(dir_list "")
    FOREACH(file_path ${new_list})
        GET_FILENAME_COMPONENT(dir_path ${file_path} PATH)
        string (FIND ${dir_path} ${EXCLUDE_INCLUDE_DIR} EXCLUDE_INCLUDE_DIR_FOUND)
        string (FIND ${dir_path} ${EXCLUDE_LIBS_DIR} EXCLUDE_LIBS_DIR_FOUND)
        if (${EXCLUDE_INCLUDE_DIR_FOUND} EQUAL -1 AND ${EXCLUDE_LIBS_DIR_FOUND} EQUAL -1)
        	SET(dir_list ${dir_list} ${dir_path})
	endif ()
    ENDFOREACH()
    LIST(REMOVE_DUPLICATES dir_list)
    LIST(REMOVE_ITEM dir_list ${CMAKE_CURRENT_SOURCE_DIR})
    SET(${return_list} ${dir_list})
ENDMACRO()

MACRO(SUBDIRLIST result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
      LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()
  SET(${result} ${dirlist})
ENDMACRO()

MACRO(update_folder_name)
    get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
    string(REPLACE " " "_" folder_name ${folder_name})
ENDMACRO()

MACRO(prepare_binary)
    message(STATUS "   " ${CMAKE_CURRENT_SOURCE_DIR} "\t\t[${CMAKE_BUILD_TYPE}]")
    update_folder_name() # Name the binary in this folder as the folder name
    FILE(GLOB_RECURSE binary_sources *.cpp) # find all cpp files
    FILE(GLOB_RECURSE binary_headers *.hpp) # find all hpp files
    #message(STATUS "        Binary sources: " ${binary_sources})
    #message(STATUS "        Binary headers: " ${binary_headers})
    #message(STATUS "        Global headers: " ${GLOBAL_HEADERS})
    add_executable( ${folder_name} ${binary_sources} ${binary_headers} ${GLOBAL_HEADERS} )
    target_link_libraries( ${folder_name} ${binary_dependencies} )

    set_target_properties( ${folder_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} )
    set_target_properties( ${folder_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} )
    set_target_properties( ${folder_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} )

    set_target_properties( ${folder_name} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY} )
    set_target_properties( ${folder_name} PROPERTIES LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY} )
    set_target_properties( ${folder_name} PROPERTIES LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY} )
ENDMACRO()

# Load libraries
message(STATUS "Adding libraries:")
SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR}/libs)
FOREACH(subdir ${SUBDIRS})
  #message(STATUS "   " ${CMAKE_CURRENT_SOURCE_DIR}/libs/${subdir})
  ADD_SUBDIRECTORY(${CMAKE_CURRENT_SOURCE_DIR}/libs/${subdir})
ENDFOREACH()

# Load src subdirectories
message(STATUS "Adding source subdirectories:")
CMAKE_DIRECTORIES(SUBDIRS)
FOREACH(subdir ${SUBDIRS})
  #message(STATUS "   " ${subdir})
  ADD_SUBDIRECTORY(${subdir})
  include_directories(${subdir})
ENDFOREACH()

message(STATUS "\n--")
