# 🧩 Sudoku Solver

<div align="center">
![Sudoku Grid](https://img.shields.io/badge/9x9-Sudoku%20Grid-blue)
![C++17](https://img.shields.io/badge/C%2B%2B-17-00599C?logo=c%2B%2B)
![License](https://img.shields.io/badge/License-GPLv3-blue)
![Build System](https://img.shields.io/badge/Build%20System-CMake-064F8C?logo=cmake)
</div>

**A lightning-fast Sudoku puzzle solver built with modern C++17**
*Because life's too short to solve Sudoku puzzles by hand!*

## ✨ Features

- 🚀 Solve any valid 9x9 Sudoku puzzle in milliseconds
- 💻 Comprehensive CLI interface for input/output
- 💾 File-based puzzle loading/saving capabilities
- 🧪 Implies Catch2 test framework integration
- ⚡ Advanced compiler optimizations for performance
- ✅ Robust input validation system
- 🔧 Modular codebase with clear separation of concerns

## 📋 Requirements

- 🔨 C++17 compatible compiler
- 🏗️ CMake (minimum version 4.0.1)
- 🧪 Optional: Catch2 for testing framework (automatically handled by CMake)

## 🗂️ Project Structure

```
├── .clang-format
├── .gitignore
├── CMakeLists.txt
├── LICENSE.txt
├── README.md
├── include/
│   └── sudokusolver.hpp
├── opt.sh
└── src/
    ├── main.cpp
    └── sudokusolver.cpp
```

## 📄 License

This project is licensed under the GPLv3.0. See `LICENSE.txt` for full details.

## 🛠️ Build Instructions

### Linux/macOS with Clang/GCC

```bash
# Clone & enter directory
git clone https://github.com/LulzSec6824/SudokuSolver.git
# Use forward slashes in PowerShell too
cd SudokuSolver

# Create build directory
mkdir -p build && cd build

# Configure with Clang
cmake -DCMAKE_BUILD_TYPE=Release ..
# Or specify compilers:
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release ..

# Build with current CPU optimizations
cmake --build .
# Or use opt.sh script:
../opt.sh --native-opts

# Run the solver
./sudoku_solver
```

### Windows with MinGW/MSVC/Clang

```powershell
# For MinGW:
cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release ..
mingw32-make

# For MSVC:
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ..
nmake

# For Clang on Windows:
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release

# Run the solver
.\sudoku_solver.exe
```

### 🦸 Using opt.sh Script

```bash
# Basic build:
./opt.sh

# Custom build with specific generator:
./opt.sh --build-dir my_build --generator "Ninja Multi-Config"
# Optimize for current CPU:
./opt.sh --native-opts
```

## 📄 Puzzle File Format Example

```txt
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

## 🧪 Testing & Troubleshooting

Ensure you have developer packages installed if facing build issues. See [Testing](#testing) section below:
- CMake minimum version requirement
- Compiler-specific installation instructions
- Script execution permissions


## 📜 Specific Error Solutions

1. "CMake not found": Install via apt `sudo apt install build-essential` or MSYS2 equivalent
2. "MinGW/GCC not found": Ensure PATH includes `C:\msys64\ucrt64\bin`
3. "Build fails with generator issues": Match generator to your compiler environment
4. "Missing libraries": Install development packages through your package manager

## 📋 Optimize with -march=native

When building on supported compilers, use the `opt.sh` script with `--native-opts` flag to enable architecture-specific optimizations. Building on Windows requires equivalent `/arch:AVX2` flags.

## 🧘 Advanced Options

For performance-tuning CMake, this project supports:
- Inter-Procedure Optimization (IPO)/Link Time Optimization (LTO)
- Release-specific compiler flags (-O3/NDEBUG)
- Profile-Guided Optimization (PGO) generation and usage
- Strict compiler warning flags for code quality

## 🧩 Build Errors?

Check:
1. Your environment's PATH for required tools
2. Correct CMake generator selection
3. Minimum required CMake version
4. Script execution permissions for opt.sh

## 📜 License

GPLv3.0 - See [LICENSE](LICENSE.txt) for full text

---
<div align="center">
  **Built with C++17 and recursive algorithms**
  <br>
  <b>High-performance binary with CMake optimizations</b>
</div>
