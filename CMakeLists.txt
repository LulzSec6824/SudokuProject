cmake_minimum_required(VERSION 4.0.1)
project(SudokuSolver VERSION 1.0 LANGUAGES CXX)

# Set default build type to Release if not specified, e.g., by an IDE or build script
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
  message(STATUS "CMAKE_BUILD_TYPE not set, defaulting to Release.")
endif()

# Support for cross-compilation via toolchain file
if(CMAKE_TOOLCHAIN_FILE)
  message(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
else()
  message(STATUS "No toolchain file specified, configuring for native build.")
endif()

# Specify C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Compiler selection (primarily for native builds, toolchain file handles cross-compilers)
if (WIN32)
    # Use MSVC by default on Windows, but allow MinGW or Clang if specified
    if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        message(STATUS "Using MSVC on Windows.")
    else(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        message(STATUS "Using MinGW GCC on Windows.")
    endif()
else()
    # For non-Windows, let CMake find the default C and CXX compilers
    # Or explicitly set them if needed, e.g.:
    # set(CMAKE_C_COMPILER "gcc")
    # set(CMAKE_CXX_COMPILER "g++")
    message(STATUS "Using default C/CXX compilers for non-Windows OS.")
endif()

# Add compiler flags
if (MSVC)
    # MSVC compiler flags
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
else()
    # GCC/Clang compiler flags
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic")
endif()

# Include directories
include_directories(${PROJECT_SOURCE_DIR}/include)

# Add source files
set(SOURCES
    src/main.cpp
    src/SudokuSolver.cpp
)

# Create executable
add_executable(sudoku_solver ${SOURCES})

# Install target
install(TARGETS sudoku_solver DESTINATION bin)
