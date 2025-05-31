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

- 🔨 C++17 compatible compiler (Clang recommended, MSVC or MinGW supported on Windows)
- 🏗️ CMake (minimum version 3.10)
<<<<<<< HEAD
=======
- 🧪 Catch2 (automatically downloaded by CMake)
>>>>>>> f6eb4e2173144acf5b784b14a4cdd56c0e2bd0a9

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

<<<<<<< HEAD
=======
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

>>>>>>> f6eb4e2173144acf5b784b14a4cdd56c0e2bd0a9
## 🛠️ Manual Build (For the DIY Enthusiasts)

### 🪟 Windows 11 with MinGW GCC

#### Prerequisites

1. **Install MSYS2**:
   - Download and install MSYS2 from [https://www.msys2.org/](https://www.msys2.org/)
   - Follow the installation instructions on the website

2. **Install MinGW GCC and required tools**:
   - Open MSYS2 UCRT64 terminal
   - Run the following commands:

```bash
# Update package database and core packages
pacman -Syu

# Install MinGW GCC, CMake, and Make
pacman -S mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-make
```

3. **Add MinGW to your PATH**:
   - Add `C:\msys64\ucrt64\bin` to your Windows PATH environment variable
   - You can verify the installation by opening a new Command Prompt and typing:
     ```
g++ --version
cmake --version
```

#### Building the Project

Open Command Prompt or PowerShell, then:

```powershell
# Clone the repository (if you haven't already)
# git clone https://github.com/LulzSec6824/SudokuSolver.git
# cd SudokuSolver

# Create build directory
mkdir build
cd build

# Configure with CMake using MinGW
cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release ..

# Build the project
mingw32-make

# Run the solver
.\sudoku_solver.exe
```

### 🪟 Windows 10 / Windows 11 with MSVC or Clang

Alternatively, you can use MSVC (Visual Studio) or Clang on Windows:

```powershell
mkdir build
cd build

# For MSVC (default on Windows):
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ..
nmake

# For Clang (if installed):
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release

# Run the solver
.\sudoku_solver.exe
```

### 🐧 Linux with Clang

#### Prerequisites

1. **Install required packages**:
   ```bash
   # For Ubuntu/Debian-based distributions
   sudo apt update
   sudo apt install clang cmake build-essential git
   
   # For Fedora
   sudo dnf install clang cmake make gcc-c++ git
   
   # For Arch Linux
   sudo pacman -S clang cmake make gcc git
   ```

2. **Verify installation**:
   ```bash
   clang++ --version
   cmake --version
   ```

#### Building the Project

```bash
# Clone the repository (if you haven't already)
# git clone https://github.com/LulzSec6824/SudokuSolver.git
# cd SudokuSolver

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

<<<<<<< HEAD
=======
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
>>>>>>> f6eb4e2173144acf5b784b14a4cdd56c0e2bd0a9

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
## 🔧 Troubleshooting

<<<<<<< HEAD
### Common Build Issues

#### Windows
=======
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
>>>>>>> f6eb4e2173144acf5b784b14a4cdd56c0e2bd0a9

1. **CMake not found**
   - Ensure CMake is properly installed and added to your PATH
   - Verify with `cmake --version` in Command Prompt

2. **MinGW/GCC not found**
   - Check that MinGW is installed correctly via MSYS2
   - Verify PATH includes `C:\msys64\ucrt64\bin`
   - Test with `g++ --version`

3. **Build fails with "The C compiler identification is unknown"**
   - Make sure you're using the correct generator for your compiler
   - For MinGW: Use `-G "MinGW Makefiles"`
   - For MSVC: Use default or `-G "NMake Makefiles"`

4. **Missing libraries or headers**
   - Install required development packages via MSYS2 pacman

#### Linux

1. **Clang not found**
   - Install with `sudo apt install clang` (Ubuntu/Debian)
   - Verify with `clang++ --version`

2. **CMake errors**
   - Ensure you have the minimum required version (4.0.1)
   - Update with `sudo apt install cmake` or equivalent

3. **Permission denied when running build.sh**
   - Make the script executable: `chmod +x build.sh`

4. **Missing development libraries**
   - Install build essentials: `sudo apt install build-essential`

### Getting Help

If you encounter issues not covered here, please:
1. Check the error messages carefully
2. Search online for specific error codes
3. Open an issue in the project repository with detailed information about your environment and the error

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
- Create more sample puzzles
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
  <b>** Built with [ Cpp newbie brain ] and a bit of recursive magic **</b>
</div>
