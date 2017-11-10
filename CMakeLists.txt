project(gst-template-vala)
cmake_minimum_required(VERSION 3.1.0)

#version info
set (VERSION_MAJOR 3)
set (VERSION_MINOR 0)
set (VERSION_PATCH 1)
set (VERSION_STRING "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}")

# export compilation database
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if (NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Release")
  set(CMAKE_BUILD_TYPE "Release")
endif()

# output directory for general files
set(MAIN_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
if (NOT MSVC)
    set(MAIN_OUTPUT_DIRECTORY "${MAIN_OUTPUT_DIRECTORY}/${CMAKE_BUILD_TYPE}")
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${MAIN_OUTPUT_DIRECTORY})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${MAIN_OUTPUT_DIRECTORY})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${MAIN_OUTPUT_DIRECTORY})

# global debug options
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_RELEASE} -Wall")
if(NOT MSVC)
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -DDEBUG  -Wall -ggdb")
endif()

set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Wall")
if(NOT MSVC)
  set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3")
endif()

if (MSVC)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /wd4061 /wd4334 /wd4514 /wd4571 /wd4710 /wd4711 /wd4820 /wd4624 /wd4625 /wd4626")
endif ()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")

# dependencies
find_package(GLIB COMPONENTS gobject REQUIRED)
find_package(GStreamer REQUIRED)
find_package(Vala REQUIRED)
include(${VALA_USE_FILE})

add_subdirectory(src)

