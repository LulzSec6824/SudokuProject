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

# Compiler selection is typically handled by CMake or a toolchain file.
# The following manual override for Clang is removed to allow standard CMake behavior.
# If you need to specify Clang, set CMAKE_C_COMPILER and CMAKE_CXX_COMPILER environment variables
# or use a toolchain file.

# Enable interprocedural optimization (IPO/LTO)
include(CheckIPOSupported)
check_ipo_supported(RESULT IPO_SUPPORTED OUTPUT IPO_ERROR)
if(IPO_SUPPORTED)
  message(STATUS "IPO/LTO will be enabled for the target.")
  # We will apply this to the target later using target_property
else()
  message(STATUS "IPO/LTO not supported: ${IPO_ERROR}")
  set(IPO_SUPPORTED FALSE) # Ensure IPO_SUPPORTED is defined as FALSE if not supported
endif()

# Common warning flags (will be applied to the target)
set(COMMON_WARNING_FLAGS "-Wall -Wextra -Wpedantic")

# Option for architecture-specific optimizations
option(ENABLE_NATIVE_OPTIMIZATIONS "Enable architecture-specific optimizations (e.g., -march=native)" OFF)

# Option for aggressive math optimizations
option(ENABLE_FAST_MATH "Enable aggressive floating-point optimizations (e.g., -ffast-math)" OFF)

# Performance optimization flags will be set per-target and per-compiler
# General Release flags for GCC/Clang
set(GCC_CLANG_RELEASE_FLAGS "-O3 -DNDEBUG")
# General Release flags for MSVC
set(MSVC_RELEASE_FLAGS "/O2 /DNDEBUG /Oi /Ot /Oy") # /GL is for LTO, handled by CMAKE_INTERPROCEDURAL_OPTIMIZATION

# Additional aggressive GCC/Clang flags (can be made optional or configured)
set(GCC_CLANG_AGGRESSIVE_FLAGS "-funroll-loops -fomit-frame-pointer -fmerge-all-constants -ftree-vectorize")
# -fstrict-aliasing and -fstrict-overflow can be added if code is known to be safe
# -falign-functions=16 is a cache optimization

# PGO flags are handled later

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

# Include directories will be set per-target

# Add source files
set(SOURCES
    src/main.cpp
    src/SudokuSolver.cpp
)

# Create executable
add_executable(sudoku_solver ${SOURCES})

# Apply C++ standard to the target
target_compile_features(sudoku_solver PRIVATE cxx_std_17)

# Apply include directories to the target
target_include_directories(sudoku_solver PUBLIC ${PROJECT_SOURCE_DIR}/include)

# Apply IPO/LTO to the target if supported
if(IPO_SUPPORTED)
  set_property(TARGET sudoku_solver PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
endif()

# Apply compile options based on compiler and build type
target_compile_options(sudoku_solver PRIVATE
    $<$<CXX_COMPILER_ID:GNU,Clang>:${COMMON_WARNING_FLAGS}>
    $<$<CXX_COMPILER_ID:MSVC>:/W4> # /W4 is roughly equivalent to -Wall -Wextra for MSVC
)

target_compile_options(sudoku_solver PRIVATE
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:GNU,Clang>>:${GCC_CLANG_RELEASE_FLAGS} ${GCC_CLANG_AGGRESSIVE_FLAGS}>
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:${MSVC_RELEASE_FLAGS}>
)

if(ENABLE_NATIVE_OPTIMIZATIONS)
  target_compile_options(sudoku_solver PRIVATE
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:GNU,Clang>>:-march=native>
    # MSVC equivalent for -march=native could be /arch:AVX2, but requires knowing CPU features.
    # For simplicity, we'll omit a direct MSVC equivalent here or it could be a separate option.
  )
endif()

if(ENABLE_FAST_MATH)
  target_compile_options(sudoku_solver PRIVATE
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:GNU,Clang>>:-ffast-math>
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:/fp:fast>
  )
endif()

# Apply PGO flags if enabled
if(ENABLE_PGO_GENERATE)
  message(STATUS "Configuring for PGO generation phase")
  target_compile_options(sudoku_solver PRIVATE -fprofile-generate)
  target_link_libraries(sudoku_solver PRIVATE -fprofile-generate) # For GCC/Clang, linker also needs this
  if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(sudoku_solver PRIVATE /GL)
    target_link_options(sudoku_solver PRIVATE /GENPROFILE)
  endif()
elseif(ENABLE_PGO_USE)
  message(STATUS "Configuring for PGO use phase")
  target_compile_options(sudoku_solver PRIVATE -fprofile-use -fprofile-correction)
  target_link_libraries(sudoku_solver PRIVATE -fprofile-use) # For GCC/Clang
  if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(sudoku_solver PRIVATE /GL)
    target_link_options(sudoku_solver PRIVATE /USEPROFILE)
  endif()
endif()

# Enable code coverage option
option(ENABLE_COVERAGE "Enable coverage reporting" OFF)

# Linker optimization flags
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  target_link_options(sudoku_solver PRIVATE "-Wl,--gc-sections")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # For MSVC, /OPT:REF (remove unreferenced functions/data) and /OPT:ICF (fold identical COMDATs)
  # are typically enabled with /O2 or when /GL (LTO) is used.
  # We can explicitly add them for Release builds if needed.
  target_link_options(sudoku_solver PRIVATE $<$<CONFIG:Release>:/OPT:REF /OPT:ICF>)
endif()

# Install target
install(TARGETS sudoku_solver DESTINATION bin)
