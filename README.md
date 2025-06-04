# 🧩 Sudoku Solver

<div align="center">

[![9x9 Sudoku Grid](https://img.shields.io/badge/9x9-Sudoku%20Grid-blue)]()
[![C++17](https://img.shields.io/badge/C%2B%2B-17-00599C?logo=c%2B%2B)]()
[![License](https://img.shields.io/badge/License-GPLv3-blue)]()
[![Build System](https://img.shields.io/badge/Build%20System-CMake-064F8C?logo=cmake)]()

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

### Cross-Platform with CMake (Linux/macOS/Windows)

```bash
# Clone & enter directory
git clone https://github.com/LulzSec6824/SudokuSolver.git
cd SudokuSolver

# Create build directory
mkdir -p build && cd build

# Configure CMake (defaults to Release build and prioritizes Clang/GCC)
# For Windows, CMake will automatically select an appropriate generator (e.g., Visual Studio, MinGW Makefiles)
cmake ..

# To explicitly specify a compiler (e.g., Clang on Windows):
# cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ ..

# To specify a generator (e.g., for MinGW on Windows):
# cmake -G "MinGW Makefiles" ..

# Build the project
cmake --build .

# Run the solver (adjust executable name for Windows: .\sudoku_solver.exe)
./sudoku_solver
```

### 🦸 Using opt.sh Script (Linux/macOS)

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

## 🧪 Troubleshooting & Advanced Options

This section covers common build issues and advanced optimization techniques.

### Common Issues & Solutions

1.  **"CMake not found"**: Ensure CMake is installed and added to your system's PATH. On Linux, use `sudo apt install cmake` or equivalent. On Windows, install from the official CMake website.
2.  **"Compiler not found"**: Verify your C++ compiler (Clang, GCC, or MSVC) is installed and accessible via your system's PATH. For MinGW on Windows, ensure `C:\msys64\ucrt64\bin` (or similar) is in your PATH.
3.  **"Build fails with generator issues"**: Ensure the CMake generator matches your compiler environment. For example, use `-G "MinGW Makefiles"` for MinGW or let CMake auto-detect for Visual Studio.
4.  **"Missing libraries"**: Install necessary development packages through your system's package manager (e.g., `build-essential` on Debian/Ubuntu).

### Advanced Optimization Techniques

This project's CMake configuration is set up for high performance. Key optimizations include:

-   **Inter-Procedural Optimization (IPO)/Link Time Optimization (LTO)**: Enabled for Release builds to allow the compiler to optimize across different compilation units.
-   **Release-specific compiler flags**: Aggressive optimization flags like `-O3` (GCC/Clang) or `/O2` (MSVC) and `-DNDEBUG` are applied for Release builds.
-   **Native CPU optimizations (`-march=native`)**: The `opt.sh` script supports this flag to optimize for your specific CPU architecture. Equivalent flags like `/arch:AVX2` might be needed for MSVC on Windows.
-   **Profile-Guided Optimization (PGO)**: While not enabled by default due to its complexity, the CMake setup supports PGO. This advanced technique involves building with instrumentation, running with typical workloads to collect data, and then rebuilding for highly specific optimizations.
-   **Strict compiler warning flags**: Configured to ensure high code quality.

---

<div align="center">

**Built with C++17 and recursive algorithms**

**High-performance binary with CMake optimizations**

</div>
