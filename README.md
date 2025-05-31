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
- 🏗️ CMake (minimum version 4.0.1 recommended, 3.10 might work but newer is better for modern features)
- 🧪 Catch2 (automatically downloaded by CMake if tests are enabled, though current CMakeLists.txt does not show test-specific targets like `sudoku_tests` or options like `BUILD_TESTS` being actively used beyond PGO script disabling it. This might need review if tests are a core feature to be documented here.)

## Project Structure

The project is organized as follows:

```
├── .clang-format
├── .gitignore
├── CMakeLists.txt
├── LICENSE.txt
├── README.md
├── include\
│   └── sudokusolver.hpp
├── opt.sh
└── src\
    ├── main.cpp
    └── sudokusolver.cpp
```

## Building the Project

To build the project, you can use the provided `opt.sh` script for optimized builds or configure manually using CMake.

### Using `opt.sh`

Run the following command to build with optimizations:

```bash
./opt.sh
```

### Manual Build

1. Create a build directory:

   ```bash
   mkdir build && cd build
   ```

2. Configure the project:

   ```bash
   cmake ..
   ```

3. Build the project:

   ```bash
   cmake --build .
   ```

## Running the Solver

After building, you can run the Sudoku solver executable located in the `build` directory.

```bash
./SudokuSolver
```

## License

This project is licensed under the MIT License. See the `LICENSE.txt` file for details.

(If you have a `build.sh` script, its usage would be documented here. The example above shows direct CMake usage.)

### High-Performance Optimized Build (using opt.sh)

For maximum performance, use the Profile-Guided Optimization (PGO) script `opt.sh`. This script also allows enabling other compiler optimizations.

```bash
# Make the script executable
chmod +x opt.sh

# Build with PGO and other default optimizations
./opt.sh

# Run the optimized version (default build directory: build_pgo_optimized)
./build_pgo_optimized/sudoku_solver 
# Or on Windows: ./build_pgo_optimized/Release/sudoku_solver.exe
```

**Customizing the optimized build:**

The `opt.sh` script supports several options:

-   `--no-native-opts`: Disable architecture-specific optimizations (like `-march=native`).
-   `--no-fast-math`: Disable aggressive floating-point optimizations (like `-ffast-math`).
-   `--build-dir <name>`: Specify a custom build directory name.
-   `--generator <CMake Generator>`: Specify a CMake generator (e.g., "Unix Makefiles", "Ninja Multi-Config").

Example:
```bash
./opt.sh --no-native-opts --build-dir my_custom_build --generator "Unix Makefiles"
```
This will build in `my_custom_build` without native CPU optimizations, using Unix Makefiles.
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
