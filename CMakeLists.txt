cmake_minimum_required(VERSION 3.16)

find_program(CLANG_COMPILER clang++)
find_program(GCC_COMPILER g++)
find_program(MSVC_COMPILER cl.exe)

if (CLANG_COMPILER)
    set(CMAKE_CXX_COMPILER ${CLANG_COMPILER})
    message(STATUS "Using Clang compiler: ${CLANG_COMPILER}")
elseif (GCC_COMPILER)
    set(CMAKE_CXX_COMPILER ${GCC_COMPILER})
    message(STATUS "Using GCC compiler: ${GCC_COMPILER}")
elseif (MSVC_COMPILER)
    set(CMAKE_CXX_COMPILER ${MSVC_COMPILER})
    message(STATUS "Using MSVC compiler: ${MSVC_COMPILER}")
else()
    message(FATAL_ERROR "No suitable C++ compiler found (Clang, GCC, or MSVC).")
endif()

project(SudokuSolver VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_EXTENSIONS OFF)

file(GLOB SOURCES "src/*.cpp")
add_executable(sudoku_solver ${SOURCES})

target_include_directories(sudoku_solver PUBLIC include)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
endif()

if (CMAKE_BUILD_TYPE STREQUAL "Release")
    if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        target_compile_options(sudoku_solver PRIVATE /O2 /Ob2 /Oi /Ot /Oy /GS-)
        target_link_options(sudoku_solver PRIVATE /LTCG /OPT:REF,ICF)
    else()
        target_compile_options(sudoku_solver PRIVATE -O3 -DNDEBUG -funroll-loops -march=native -fno-exceptions -fno-rtti)
    endif()
endif()

if (CMAKE_BUILD_TYPE STREQUAL "Release")
    if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")

    else()
        include(CheckIPOSupported)
        check_ipo_supported(RESULT ipo_supported)
        if (ipo_supported)
            set_property(TARGET sudoku_solver PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
            target_link_options(sudoku_solver PRIVATE -flto)
        endif()
    endif()
endif()

# Explanation of CMakeLists.txt Configuration
# This section provides a detailed explanation of the settings and optimizations applied in this CMakeLists.txt file.

# 1. CMake Minimum Required Version:
#    cmake_minimum_required(VERSION 3.16)
#    Specifies the minimum version of CMake required to configure and build the project. Version 3.16 or newer is needed for features used here.

# 2. Compiler Selection Priority:
#    This block ensures that the project is built with a preferred C++ compiler in the following order:
#    - Clang (clang++)
#    - GCC (g++)
#    - MSVC (cl.exe)
#    If none of these compilers are found, CMake will issue a fatal error, preventing the build.
#    find_program(CLANG_COMPILER clang++)
#    find_program(GCC_COMPILER g++)
#    find_program(MSVC_COMPILER cl.exe)
#    if (CLANG_COMPILER) ... elseif (GCC_COMPILER) ... elseif (MSVC_COMPILER) ... else() ... endif()
#    The selected compiler is then set as CMAKE_CXX_COMPILER.

# 3. Project Definition:
#    project(SudokuSolver VERSION 1.0 LANGUAGES CXX)
#    Defines the project name as "SudokuSolver", sets its version to 1.0, and specifies that it uses the C++ language.

# 4. C++ Standard:
#    set(CMAKE_CXX_STANDARD 17)
#    set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
#    set(CMAKE_CXX_EXTENSIONS OFF)
#    Enforces the use of the C++17 standard. CMAKE_CXX_STANDARD_REQUIRED TRUE ensures that the build fails if C++17 is not supported.
#    CMAKE_CXX_EXTENSIONS OFF disables compiler-specific extensions to ensure strict standard compliance and better portability.

# 5. Source Files and Executable:
#    file(GLOB SOURCES "src/*.cpp")
#    add_executable(sudoku_solver ${SOURCES})
#    Collects all .cpp files in the 'src' directory into the SOURCES variable and creates an executable named 'sudoku_solver' from them.

# 6. Include Directories:
#    target_include_directories(sudoku_solver PUBLIC include)
#    Adds the 'include' directory to the list of directories where the compiler searches for header files. PUBLIC means it's also exposed to targets that link against 'sudoku_solver'.

# 7. Default Build Type:
#    if (NOT CMAKE_BUILD_TYPE)
#        set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
#    endif()
#    If CMAKE_BUILD_TYPE is not explicitly set (e.g., via -DCMAKE_BUILD_TYPE=Debug), it defaults to "Release". This ensures that optimized builds are the default.

# 8. Optimization Flags for Release Builds:
#    This block applies aggressive optimization flags specifically for "Release" builds.
#    if (CMAKE_BUILD_TYPE STREQUAL "Release")
#        if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
#            target_compile_options(sudoku_solver PRIVATE /O2 /Ob2 /Oi /Ot /Oy /GS-)
#            target_link_options(sudoku_solver PRIVATE /LTCG /OPT:REF,ICF)
#            For MSVC, /O2 enables full optimization. Other flags like /Ob2 (inline expansion), /Oi (intrinsic functions), /Ot (favor fast code), /Oy (omit frame pointers), and /GS- (disable security checks for performance) are used.
#            /LTCG (Link-Time Code Generation) and /OPT:REF,ICF (optimizations for redundant functions and identical COMDATs) are linking optimizations.
#        else()
#            target_compile_options(sudoku_solver PRIVATE -O3 -DNDEBUG -funroll-loops -march=native -fno-exceptions -fno-rtti)
#            For GCC/Clang, -O3 enables aggressive optimizations. -DNDEBUG disables assertions. -funroll-loops unrolls loops for performance. -march=native optimizes for the host CPU architecture. -fno-exceptions and -fno-rtti disable exceptions and RTTI for smaller code size and potentially faster execution, assuming they are not used by the application.
#        endif()
#    endif()

# 9. Link Time Optimization (LTO)/Interprocedural Optimization (IPO):
#    This section enables LTO, which performs whole-program optimization by allowing the linker to optimize across different compilation units.
#    if (CMAKE_BUILD_TYPE STREQUAL "Release")
#        if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
#            MSVC's LTO is primarily handled by the /LTCG flag, which is already included in the compile and link options for MSVC.
#        else()
#            include(CheckIPOSupported)
#            check_ipo_supported(RESULT ipo_supported)
#            if (ipo_supported)
#                set_property(TARGET sudoku_solver PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
#                target_link_options(sudoku_solver PRIVATE -flto)
#                For GCC/Clang, -flto enables LTO. CheckIPOSupported is used to verify if the compiler and linker support LTO.
#            endif()
#        endif()
#    endif()

# 10. Advanced Optimization: Profile-Guided Optimization (PGO) (Commented Out):
#     This section provides information on PGO, an advanced optimization technique that can yield significant performance improvements.
#     PGO involves building the code with instrumentation, running it with typical workloads to collect profile data, and then rebuilding it using that data for highly specific optimizations.
#     It is more complex to set up and manage but can offer superior performance for critical applications.

# 11. Optional: Precompiled Headers (PCH) (Commented Out):
#     This section provides an example of how to enable Precompiled Headers. PCH can significantly speed up compilation times for large projects by pre-compiling frequently used headers.
#     To use this, you would uncomment the relevant lines and specify your common header file (e.g., "stdafx.h" or "pch.h").