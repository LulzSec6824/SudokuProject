#!/bin/bash

# Script to build Sudoku Solver with Profile-Guided Optimization (PGO)
# PGO provides superior optimization by using real execution data

set -e  # Exit on error

# Create build directory
mkdir -p build_pgo
cd build_pgo

# Step 1: Configure for profile generation
echo "===== STEP 1: Configuring for profile generation ====="
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DENABLE_PGO_GENERATE=ON

# Step 2: Build instrumented binary
echo "===== STEP 2: Building instrumented binary ====="
make -j$(nproc) sudoku_solver

# Step 3: Generate profile data
echo "===== STEP 3: Generating profile data ====="
# Run the program with representative input to generate profile
./sudoku_solver &
sleep 1  # Give it time to start
# Send some input commands: load sample puzzle and solve it
echo -e "1\n4\n8\n" | ./sudoku_solver

# Step 4: Build optimized binary using the profile data
echo "===== STEP 4: Configuring for optimized build with profile data ====="
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DENABLE_PGO_USE=ON

# Step 5: Build final optimized binary
echo "===== STEP 5: Building optimized binary ====="
make -j$(nproc) sudoku_solver

echo "===== PGO optimization complete! ====="
echo "The optimized binary is at: $(pwd)/sudoku_solver"