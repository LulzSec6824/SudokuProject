# Sudoku Solver Test Suite

This directory contains the test suite for the Sudoku Solver project. The tests use the [Catch2](https://github.com/catchorg/Catch2) testing framework.

## Structure

The test suite is organized as follows:

- `test_main.cpp` - Main test runner that initializes Catch2
- `test_sudoku_solver.cpp` - Tests for the core SudokuSolver class functionality
- `test_game_logic.cpp` - Tests related to game rules and user interactions
- `test_performance.cpp` - Performance tests measuring solving speed for different puzzles

## Building and Running Tests

### Prerequisites

- CMake 3.10 or higher
- C++17 compatible compiler
- Catch2 testing framework (either installed system-wide or using the single-header version)

### Build Instructions

1. Create a build directory:
   ```bash
   mkdir -p build
   cd build
   ```

2. Generate build files:
   ```bash
   cmake ..
   ```

3. Build the tests:
   ```bash
   make
   ```

4. Run the tests:
   ```bash
   ./sudoku_tests
   ```

### Running Specific Tests

You can run specific test cases or groups using Catch2's command line options:

- Run tests with specific tag:
  ```bash
  ./sudoku_tests "[solver]"
  ```

- Run tests with specific test name:
  ```bash
  ./sudoku_tests "SudokuSolver can solve puzzles"
  ```

- List all available tests:
  ```bash
  ./sudoku_tests --list-tests
  ```

## Adding New Tests

To add new tests:

1. Create a new test file or add test cases to existing files
2. Include the necessary header files:
   ```cpp
   #include "catch2/catch.hpp"
   #include "../include/SudokuSolver.hpp"
   ```
3. Write your tests using the `TEST_CASE` and `SECTION` macros
4. Add your test file to the `CMakeLists.txt` file

## Test Coverage

To generate test coverage reports, use a coverage tool like gcov/lcov with the test suite.