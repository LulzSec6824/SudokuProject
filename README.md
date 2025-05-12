# 🧩 Sudoku Solver

<div align="center">

![Sudoku Grid](https://img.shields.io/badge/9x9-Sudoku%20Grid-blue)
![C++17](https://img.shields.io/badge/C%2B%2B-17-00599C?logo=c%2B%2B)
![License](https://img.shields.io/badge/License-MIT-green)
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
- 🧪 Comprehensive test suite with Google Test
- ✅ Robust input validation
- 🔧 Clean, modular architecture with proper separation of concerns

## 📋 Requirements

- 🔨 C++17 compatible compiler (Clang recommended)
- 🏗️ CMake (minimum version 3.10)
- 🧪 Google Test (automatically downloaded by CMake)

## 📂 Project Structure

```
SudokuProject/
├── 📄 CMakeLists.txt         # CMake build configuration
├── 📄 build.sh               # Build script for easy compilation
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

### One-Click Build

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

### Running Tests

```bash
# Build with tests enabled
mkdir -p build && cd build
cmake -DBUILD_TESTS=ON ..
cmake --build .

# Run the tests
./tests/sudoku_tests
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

## 🧪 Testing

The project uses Google Test (automatically downloaded during CMake configuration) with several test categories:

- **Solver Tests**: Verify basic functionality of the Sudoku solver
- **Game Logic Tests**: Test user interactions and move validation
- **Performance Tests**: Ensure the solver performs efficiently on puzzles of different difficulties

Run tests with:
```bash
./build.sh --test
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:
- Report bugs and suggest features by opening an issue
- Improve the code with pull requests
- Create more test cases or sample puzzles
- Enhance documentation

## 📜 License

This project is licensed under the MIT License.

---

<div align="center">
  <b>Happy Solving! 🎉</b>
  
  <br>
  <br>
  
  *Built with [LOVE_FOR_SHONNA] and a bit of recursive magic*
</div>
