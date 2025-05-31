#!/bin/bash

# Sudoku Solver Build Script

# Stop on first error
set -e

# Create build directory if it doesn't exist
mkdir -p build
cd build

# Configure CMake
# Allow CMake to find the default C/C++ compilers
# If you want to specify Clang, ensure it's in your PATH or use CMake toolchain files
# export CC=clang
# export CXX=clang++
cmake -DCMAKE_BUILD_TYPE=Release ..

# Detect generator and build accordingly
GENERATOR=$(cmake -LA -N .. 2>/dev/null | grep CMAKE_GENERATOR: | cut -d'=' -f2)
if [[ "$GENERATOR" == *"Ninja"* || "$GENERATOR" == *"Makefiles"* ]]; then
    cmake --build . -- -j$(nproc)
else
    cmake --build .
fi

cd ..
echo "Build completed successfully!"
echo "To run the application: ./build/sudoku_solver"
echo ""
