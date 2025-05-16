cmake_minimum_required(VERSION 3.10)
project(SudokuSolver VERSION 1.0 LANGUAGES CXX)

# Specify C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Set Clang as the compiler if not already specified
if(NOT CMAKE_C_COMPILER)
  find_program(CLANG_FOUND "clang")
  if(CLANG_FOUND)
    set(CMAKE_C_COMPILER "clang")
  endif()
endif()

if(NOT CMAKE_CXX_COMPILER)
  find_program(CLANGPP_FOUND "clang++")
  if(CLANGPP_FOUND)
    set(CMAKE_CXX_COMPILER "clang++")
  endif()
endif()

# Enable interprocedural optimization (IPO/LTO)
include(CheckIPOSupported)
check_ipo_supported(RESULT IPO_SUPPORTED OUTPUT IPO_ERROR)
if(IPO_SUPPORTED)
  message(STATUS "IPO/LTO enabled")
  set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
else()
  message(STATUS "IPO/LTO not supported: ${IPO_ERROR}")
endif()

# Performance optimization flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic")

# Advanced performance optimization flags for Release builds
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG -march=native \
  -flto \
  -ffast-math \
  -funroll-loops \
  -fomit-frame-pointer \
  -fstrict-aliasing \
  -fstrict-overflow \
  -fmerge-all-constants \
  -ftree-vectorize")

# Cache optimization
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -falign-functions=16")

# Set default build type to Release if not specified
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
endif()

# Add options for Profile-Guided Optimization (PGO)
option(ENABLE_PGO_GENERATE "Enable PGO generation phase" OFF)
option(ENABLE_PGO_USE "Enable PGO use phase" OFF)

if(ENABLE_PGO_GENERATE)
  message(STATUS "Configuring for PGO generation phase")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-generate")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-generate")
elseif(ENABLE_PGO_USE)
  message(STATUS "Configuring for PGO use phase")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-use -fprofile-correction")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-use")
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

# Enable code coverage option
option(ENABLE_COVERAGE "Enable coverage reporting" OFF)

# Linker optimization flags
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set_target_properties(sudoku_solver PROPERTIES LINK_FLAGS "-Wl,--gc-sections")
endif()

# Install target
install(TARGETS sudoku_solver DESTINATION bin)

# Testing configuration
option(BUILD_TESTS "Build the tests" OFF)
if(BUILD_TESTS)
    # Use FetchContent to download and configure Catch2
    include(FetchContent)
    FetchContent_Declare(
        catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_TAG v2.13.9
    )
    FetchContent_MakeAvailable(catch2)
    
    # Enable testing
    enable_testing()
    
    # Add test executable
    add_executable(sudoku_tests 
        tests/test_main.cpp
        tests/test_game_logic.cpp
        tests/test_performance.cpp
        tests/test_sudoku_solver.cpp
        src/SudokuSolver.cpp
    )
    
    # Link with Catch2
    target_link_libraries(sudoku_tests Catch2::Catch2)
    
    # Add coverage flags if enabled
    if(ENABLE_COVERAGE)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --coverage")
    endif()
    
    # Add test to CTest
    add_test(NAME SudokuTests COMMAND sudoku_tests)
endif()

# Installation rules
install(TARGETS sudoku_solver DESTINATION bin)
install(FILES include/SudokuSolver.hpp DESTINATION include)
