# 🧩 Sudoku Solver

<div align="center">

![Sudoku Grid](https://img.shields.io/badge/9x9-Sudoku%20Grid-blue)
![C++17](https://img.shields.io/badge/C%2B%2B-17-00599C?logo=c%2B%2B)
![License](https://img.shields.io/badge/License-GPLv3-blue)
![Build System](https://img.shields.io/badge/Build%20System-CMake-064F8C?logo=cmake)

**A lightning-fast Sudoku puzzle solver built with modern C++**  
*Because life's too short to solve Sudoku puzzles by hand!*

</div>

## 🔍 Fun Facts

- The minimum number of starting clues needed for a unique Sudoku solution is 17
- There are approximately 6.67 × 10²¹ possible valid Sudoku grids
- The backtracking algorithm can solve most puzzles in milliseconds, but extremely difficult puzzles might take longer

## ✨ Features

- 🚀 Solve any valid 9x9 Sudoku puzzle in milliseconds
- 💻 Friendly interactive command-line interface
- 💾 Load and save puzzles from/to files
- 🧪 Comprehensive test suite with Catch2
- ⚡ Advanced compiler optimizations for maximum performance
- ✅ Robust input validation
- 🔧 Clean, modular architecture with proper separation of concerns

## 📋 Requirements

- 🔨 C++17 compatible compiler (Clang recommended)
- 🏗️ CMake (minimum version 3.10)
- 🧪 Catch2 (automatically downloaded by CMake)

## 📂 Project Structure

```
SudokuProject/
├── 📄 CMakeLists.txt         # CMake build configuration
├── 📄 build.sh               # Standard build script
├── 📄 optimize.sh            # Script for Profile-Guided Optimization
├── 📁 include/
│   └── 📄 SudokuSolver.hpp   # Header file with class declaration
├── 📁 src/
│   ├── 📄 main.cpp           # Main application entry point
│   └── 📄 SudokuSolver.cpp   # Implementation of the Sudoku solver
├── 📁 tests/
│   ├── 📄 test_game_logic.cpp    # Game logic tests
│   ├── 📄 test_main.cpp          # Test runner
│   ├── 📄 test_performance.cpp   # Performance tests
│   └── 📄 test_sudoku_solver.cpp # Solver tests
└── 📄 README.md              # You are here! 👋
```

## 🚀 Quick Start

### Standard Build

```bash
# Make the build script executable
chmod +x build.sh

# Build the project
./build.sh

# Run the application
./build/sudoku_solver
```

### Building with Tests

```bash
# Build with tests
./build.sh --test

# Run the tests
./build/sudoku_tests
```

### High-Performance Optimized Build

For maximum performance, use the Profile-Guided Optimization script:

```bash
# Make the script executable
chmod +x optimize.sh

# Build with PGO optimization
./optimize.sh

# Run the optimized version
./build_pgo/sudoku_solver
```

## 🛠️ Manual Build (For the DIY Enthusiasts)

```bash
# Create and enter build directory
mkdir -p build && cd build

# Configure with CMake using Clang
export CC=clang
export CXX=clang++
cmake -DCMAKE_BUILD_TYPE=Release ..

# Build the project
cmake --build . -- -j$(nproc)

# Run the solver
./sudoku_solver
```

### Manual Test Build

```bash
# Build with tests enabled
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON ..
cmake --build . -- -j$(nproc)

# Run the tests
./sudoku_tests
```

### Code Coverage Build

```bash
# Build with coverage enabled
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON -DENABLE_COVERAGE=ON ..
cmake --build . -- -j$(nproc)

# Run tests to generate coverage data
./sudoku_tests

# Generate coverage report (requires lcov)
lcov --capture --directory . --output-file coverage.info
genhtml coverage.info --output-directory coverage_report
```

## 🎮 Using the Solver

The application greets you with an intuitive menu offering these options:

1. **📋 Load sample puzzle**: Jump right in with our pre-loaded puzzle
2. **✏️ Enter puzzle manually**: Got a challenging puzzle from the newspaper? Enter it here!
3. **📂 Load puzzle from file**: Import a puzzle from a text file
4. **🧠 Solve current puzzle**: Watch the magic happen as our algorithm cracks the puzzle
5. **💾 Save puzzle to file**: Export your puzzle or solution
6. **👁️ Display current puzzle**: View the current state of the puzzle
7. **🗑️ Clear puzzle**: Start fresh with an empty grid
8. **🚪 Exit**: Thank you for playing!

## 📄 Puzzle File Format

When importing or exporting puzzles, use this simple format:
- 9 rows of 9 digits separated by spaces
- Use `0` for empty cells
- Use `1-9` for filled cells

### Example Puzzle:
```
5 3 0 0 7 0 0 0 0
6 0 0 1 9 5 0 0 0
0 9 8 0 0 0 0 6 0
8 0 0 0 6 0 0 0 3
4 0 0 8 0 3 0 0 1
7 0 0 0 2 0 0 0 6
0 6 0 0 0 0 2 8 0
0 0 0 4 1 9 0 0 5
0 0 0 0 8 0 0 7 9
```

## 🧠 How It Works

Our solver uses a recursive backtracking algorithm:

1. Find an empty cell
2. Try each digit (1-9) in that cell
3. Check if the digit is valid according to Sudoku rules
4. If valid, recursively try to solve the rest of the puzzle
5. If we hit a dead end, backtrack and try a different digit
6. Repeat until the puzzle is solved!

## 🔍 Implementation Details

- The `SudokuSolver` class provides the core functionality with methods for:
  - Loading and saving puzzles
  - Checking move validity
  - Solving algorithms
  - Grid manipulation and display
- Constants `GRID_SIZE` (9) and `BOX_SIZE` (3) define the puzzle dimensions
- Test suite includes:
  - Basic solver tests
  - Game logic tests
  - Performance tests for different difficulty levels

## ⚡ Performance Optimizations

The project includes several advanced performance optimizations:

- **Link-Time Optimization (LTO)**: Enables whole-program optimization
- **Profile-Guided Optimization (PGO)**: Optimizes based on real execution profiles
- **Advanced Compiler Flags**:
  - Fast math operations
  - Loop unrolling
  - Vector instructions (SIMD)
  - Frame pointer omission
  - Strict aliasing
- **Cache Optimizations**: Improves CPU cache utilization
- **Memory Optimizations**: Reduces memory footprint

To build with these optimizations, use the provided `optimize.sh` script which:
1. Builds an instrumented binary
2. Generates a performance profile
3. Rebuilds with optimizations based on the profile

## 🧪 Testing

The project uses Catch2 testing framework with several test categories:

- **Solver Tests**: Verify basic functionality of the Sudoku solver
- **Game Logic Tests**: Test user interactions and move validation
- **Performance Tests**: Ensure the solver performs efficiently on puzzles of different difficulties

Run tests with:
```bash
./build.sh --test
```

### Advanced Testing Options

Catch2 provides several useful command-line options for running tests:

```bash
# Run tests with a specific tag
./build/sudoku_tests "[solver]"

# Run a specific test case
./build/sudoku_tests "SudokuSolver can solve puzzles"

# List all available tests
./build/sudoku_tests --list-tests

# Run tests in random order
./build/sudoku_tests --order rand
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:
- Report bugs and suggest features by opening an issue
- Improve the code with pull requests
- Create more test cases or sample puzzles
- Enhance documentation

### Development Setup

1. Fork the repository
2. Clone your fork
3. Set up pre-commit hooks (optional but recommended)
4. Make your changes following our coding style
5. Add tests for your changes
6. Submit a pull request

## 📜 License

This project is licensed under the GPLv3.0. See the [LICENSE](LICENSE.txt) file for details.

---

<div align="center">
  <b>Happy Solving! 🎉</b>
  
  <br>
  <br>
  
  *Built with [ A cpp newbie brain ] and a bit of recursive magic*
</div>
