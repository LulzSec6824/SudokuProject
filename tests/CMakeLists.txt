# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

# Set project name
project(SudokuSolverTests)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include directories
include_directories(../include)

# Find or configure Catch2 - you may need to adjust this based on your setup
# If you have Catch2 installed system-wide:
# find_package(Catch2 REQUIRED)

# If you want to use a downloaded version of Catch2 (single header):
# No additional commands needed as we're using the include in the test files

# Create executable
add_executable(sudoku_tests
    test_main.cpp
    test_sudoku_solver.cpp
    test_game_logic.cpp
    test_performance.cpp
)

# Link source files from main project
target_sources(sudoku_tests PRIVATE
    ../src/SudokuSolver.cpp
    # Add other source files from the main project as needed
)

# Add the include directory to include path
target_include_directories(sudoku_tests PRIVATE ../include)

# If using system-wide Catch2:
# target_link_libraries(sudoku_tests PRIVATE Catch2::Catch2)

# Enable testing functionality from CMake
enable_testing()

# Register Catch tests with CTest
# add_test(NAME sudoku_tests COMMAND sudoku_tests)