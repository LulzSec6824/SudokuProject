#!/bin/bash

# Standard build script for Sudoku Solver

# Exit on error
set -e

# Parse command-line arguments
BUILD_TESTS=false
USE_PGO=false

for arg in "$@"; do
  case $arg in
    --test)
      BUILD_TESTS=true
      shift
      ;;
    --pgo)
      USE_PGO=true
      shift
      ;;
    *)
      # Unknown option
      ;;
  esac
done

if [ "$USE_PGO" = true ]; then
  # PGO build process
  echo "Building with Profile-Guided Optimization (PGO)..."
  
  # Create build directory
  mkdir -p build_pgo
  cd build_pgo

  # Step 1: Configure for profile generation
  echo "===== STEP 1: Configuring for profile generation ====="
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=$BUILD_TESTS -DENABLE_PGO_GENERATE=ON

  # Step 2: Build instrumented binary
  echo "===== STEP 2: Building instrumented binary ====="
  make -j$(nproc)

  # Step 3: Generate profile data
  echo "===== STEP 3: Generating profile data ====="
  # Run the program with representative input to generate profile
  ./sudoku_solver &
  sleep 1  # Give it time to start
  # Send some input commands: load sample puzzle and solve it
  echo -e "1\n4\n8\n" | ./sudoku_solver

  # Step 4: Build optimized binary using the profile data
  echo "===== STEP 4: Configuring for optimized build with profile data ====="
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=$BUILD_TESTS -DENABLE_PGO_USE=ON

  # Step 5: Build final optimized binary
  echo "===== STEP 5: Building optimized binary ====="
  make -j$(nproc)

  echo "===== PGO optimization complete! ====="
  echo "The optimized binary is at: $(pwd)/sudoku_solver"
  
else
  # Standard build process
  # Create build directory
  mkdir -p build
  cd build

  # Configure with CMake
  if [ "$BUILD_TESTS" = true ]; then
    echo "Configuring with tests enabled..."
    cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON
  else
    echo "Configuring standard build..."
    cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF
  fi

  # Build using all available cores
  echo "Building Sudoku Solver..."
  make -j$(nproc)

  echo "Build complete!"
  
  if [ "$BUILD_TESTS" = true ]; then
    echo "Run tests with: ./sudoku_tests"
  else
    echo "Run solver with: ./sudoku_solver"
  fi
fi

cd ..
