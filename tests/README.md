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
- C++17 compatible compiler (Clang recommended)
- Catch2 testing framework (automatically downloaded during CMake configuration)

### Quick Build Method

The easiest way to build and run tests is to use the build script:

```bash
# Make the script executable
chmod +x ../build.sh

# Build with tests enabled
../build.sh --test

# Run the tests
../build/sudoku_tests
```

### Manual Build Instructions

1. Create a build directory:
   ```bash
   mkdir -p ../build
   cd ../build
   ```

2. Generate build files with tests enabled:
   ```bash
   cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON ..
   ```

3. Build the tests:
   ```bash
   cmake --build . -- -j$(nproc)
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

- Run tests in verbose mode:
  ```bash
  ./sudoku_tests -v
  ```

- Generate JUnit XML report:
  ```bash
  ./sudoku_tests -r junit -o test_report.xml
  ```

## Adding New Tests

To add new tests:

1. Create a new test file or add test cases to existing files
2. Include the necessary header files:
   ```cpp
   #include <catch2/catch.hpp>
   #include "../include/SudokuSolver.hpp"
   ```
3. Write your tests using the `TEST_CASE` and `SECTION` macros
4. Add your test file to the `CMakeLists.txt` file

## Test Coverage

To generate test coverage reports:

1. Build with coverage enabled:
   ```bash
   mkdir -p ../build && cd ../build
   cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON -DENABLE_COVERAGE=ON ..
   cmake --build . -- -j$(nproc)
   ```

2. Run the tests to generate coverage data:
   ```bash
   ./sudoku_tests
   ```

3. Generate the coverage report (requires lcov):
   ```bash
   lcov --capture --directory . --output-file coverage.info
   genhtml coverage.info --output-directory coverage_report
   ```

4. View the coverage report:
   ```bash
   xdg-open coverage_report/index.html  # On Linux
   # Or open the file manually in your browser
   ```

## Useful Tips

- Run tests frequently during development
- Start with small, focused test cases
- Use Catch2's `SECTION` feature to test multiple scenarios within a single test case
- Use the BDD-style syntax (`GIVEN`, `WHEN`, `THEN`) for more readable tests
- Test both normal usage and edge cases
