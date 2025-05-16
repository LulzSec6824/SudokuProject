#!/bin/bash

# Script to build Sudoku Solver with Profile-Guided Optimization (PGO)
# PGO provides superior optimization by using real execution data

set -e  # Exit on error

# Create build directory
mkdir -p build_pgo
cd build_pgo

# Cleanup function for graceful termination
cleanup() {
  echo "Cleaning up processes..."
  # Kill any running solver instances
  pkill -f sudoku_solver || true
  exit 1
}

# Set trap to catch ctrl+c and other termination signals
trap cleanup INT TERM

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
SOLVER_PID=$!
sleep 1  # Give it time to start

# Send some input commands: load sample puzzle and solve it
# 1 = load sample puzzle, 4 = solve puzzle, 8 = exit
echo -e "1\n4\n8\n" | timeout 10s cat > /proc/$SOLVER_PID/fd/0 || true

# Wait for process to exit
wait $SOLVER_PID || true

# Step 4: Build optimized binary using the profile data
echo "===== STEP 4: Configuring for optimized build with profile data ====="
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DENABLE_PGO_USE=ON

# Step 5: Build final optimized binary
echo "===== STEP 5: Building optimized binary ====="
make -j$(nproc) sudoku_solver

echo "===== PGO optimization complete! ====="
echo "The optimized binary is at: $(pwd)/sudoku_solver"
cd ..