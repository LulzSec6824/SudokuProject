#!/bin/bash

# Script to build Sudoku Solver with Profile-Guided Optimization (PGO)
# and other production-level optimizations.

set -e  # Exit immediately if a command exits with a non-zero status.

# --- Configuration Variables ---
BUILD_DIR="build_pgo_optimized"
CMAKE_GENERATOR="Ninja" # Or "Unix Makefiles", or leave empty for CMake default
NUM_JOBS=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 1) # Get number of processors

# Options for CMake (can be overridden by command line arguments)
ENABLE_NATIVE_OPTIMIZATIONS_SCRIPT_DEFAULT="ON"
ENABLE_FAST_MATH_SCRIPT_DEFAULT="ON"

# --- Helper Functions ---
info() {
    echo -e "\033[1;34m[INFO] $1\033[0m"
}

error() {
    echo -e "\033[1;31m[ERROR] $1\033[0m" >&2
    exit 1
}

# --- Argument Parsing ---
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --no-native-opts)
            ENABLE_NATIVE_OPTIMIZATIONS_SCRIPT_DEFAULT="OFF"
            shift # past argument
            ;;
        --no-fast-math)
            ENABLE_FAST_MATH_SCRIPT_DEFAULT="OFF"
            shift # past argument
            ;;
        --build-dir)
            BUILD_DIR="$2"
            shift # past argument
            shift # past value
            ;;
        --generator)
            CMAKE_GENERATOR="$2"
            shift # past argument
            shift # past value
            ;;
        *)
            error "Unknown option: $1"
            ;;
    esac
done

# --- Main Script ---
info "Starting optimized build process..."
info "Build directory: ${BUILD_DIR}"
info "CMake generator: ${CMAKE_GENERATOR:-Default}"
info "Number of parallel jobs: ${NUM_JOBS}"
info "Native Optimizations: ${ENABLE_NATIVE_OPTIMIZATIONS_SCRIPT_DEFAULT}"
info "Fast Math: ${ENABLE_FAST_MATH_SCRIPT_DEFAULT}"

# Create and navigate to build directory
rm -rf "${BUILD_DIR}" # Clean previous build
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

# Cleanup function for graceful termination
SOLVER_PID_FILE=".solver_pid"
cleanup() {
  info "Cleaning up..."
  if [ -f "${SOLVER_PID_FILE}" ]; then
    SAVED_PID=$(cat "${SOLVER_PID_FILE}")
    if ps -p "${SAVED_PID}" > /dev/null; then
      info "Terminating Sudoku Solver (PID: ${SAVED_PID})..."
      kill "${SAVED_PID}" || true
      sleep 1 # Give it a moment to terminate
      if ps -p "${SAVED_PID}" > /dev/null; then
          info "Force terminating Sudoku Solver (PID: ${SAVED_PID})..."
          kill -9 "${SAVED_PID}" || true
      fi
    fi
    rm -f "${SOLVER_PID_FILE}"
  fi
  cd ..
  exit 1
}

# Set trap to catch ctrl+c and other termination signals
trap cleanup INT TERM

# Common CMake options
COMMON_CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DENABLE_NATIVE_OPTIMIZATIONS=${ENABLE_NATIVE_OPTIMIZATIONS_SCRIPT_DEFAULT}"
    "-DENABLE_FAST_MATH=${ENABLE_FAST_MATH_SCRIPT_DEFAULT}"
)
if [ -n "${CMAKE_GENERATOR}" ]; then
    COMMON_CMAKE_ARGS+=("-G" "${CMAKE_GENERATOR}")
fi

# Step 1: Configure for profile generation
info "===== STEP 1: Configuring for PGO profile generation ====="
cmake .. "${COMMON_CMAKE_ARGS[@]}" -DENABLE_PGO_GENERATE=ON

# Step 2: Build instrumented binary
info "===== STEP 2: Building instrumented binary ====="
cmake --build . --target sudoku_solver --config Release -- -j"${NUM_JOBS}"

# Step 3: Generate profile data
info "===== STEP 3: Generating PGO profile data ====="
info "Running instrumented binary to generate profile data..."
# Ensure the executable is found (CMake places it in different locations based on generator)
EXECUTABLE_PATH="./sudoku_solver"
if [ ! -f "${EXECUTABLE_PATH}" ] && [ -f "./Release/sudoku_solver.exe" ]; then # MSBuild default
    EXECUTABLE_PATH="./Release/sudoku_solver.exe"
elif [ ! -f "${EXECUTABLE_PATH}" ] && [ -f "./bin/sudoku_solver" ]; then # Some generators
    EXECUTABLE_PATH="./bin/sudoku_solver"
fi

if [ ! -f "${EXECUTABLE_PATH}" ]; then
    error "Instrumented executable not found. Searched: ./sudoku_solver, ./Release/sudoku_solver.exe, ./bin/sudoku_solver"
fi

info "Using executable: ${EXECUTABLE_PATH}"

# Run the program with representative input to generate profile
# The input should cover typical use cases of the application.
# Example: load a sample puzzle, solve it, and exit.
# Input: 1 (load sample), 4 (solve), 8 (exit)
INPUT_SEQUENCE="1\n4\n8\n"

# Run in background and save PID
"${EXECUTABLE_PATH}" & echo $! > "${SOLVER_PID_FILE}"
SOLVER_PID=$(cat "${SOLVER_PID_FILE}")
info "Sudoku Solver started with PID: ${SOLVER_PID}"

# Wait a moment for the application to initialize
sleep 2

info "Sending input sequence to Sudoku Solver..."
# Try to send input. This might fail if the process terminates quickly or doesn't read stdin as expected.
# Using a timeout for the input feeding process.
if ps -p "${SOLVER_PID}" > /dev/null; then
    # Check if /proc/$SOLVER_PID/fd/0 exists and is writable (Linux specific)
    # For cross-platform, a named pipe or temporary file might be more robust if the application supports it.
    # For this example, we'll stick to the /proc method for Linux and hope for the best on other systems
    # or assume the application reads from a file specified by an argument for profiling runs.
    if [ -w "/proc/${SOLVER_PID}/fd/0" ]; then
        echo -e "${INPUT_SEQUENCE}" | timeout 10s cat > "/proc/${SOLVER_PID}/fd/0" || info "Input sending might have been interrupted or timed out."
    else
        info "Cannot write to /proc/${SOLVER_PID}/fd/0. Input not sent. The application might need to be modified to accept input for profiling via a file."
    fi
else
    info "Solver process ${SOLVER_PID} not running before sending input."
fi 

info "Waiting for Sudoku Solver (PID: ${SOLVER_PID}) to complete profile generation..."
# Wait for the process to finish. Add a timeout to prevent indefinite blocking.
# The 'wait' command might not work if the process was backgrounded in a subshell that exited.
# A more robust way is to poll the process status.
PROFILE_TIMEOUT=30 # seconds
ELAPSED_TIME=0
while ps -p "${SOLVER_PID}" > /dev/null && [ "${ELAPSED_TIME}" -lt "${PROFILE_TIMEOUT}" ]; do
    sleep 1
    ELAPSED_TIME=$((ELAPSED_TIME + 1))
done

if ps -p "${SOLVER_PID}" > /dev/null; then
    info "Solver (PID: ${SOLVER_PID}) still running after ${PROFILE_TIMEOUT}s. Terminating."
    kill "${SOLVER_PID}" || true
    sleep 1
    kill -9 "${SOLVER_PID}" || true
else
    info "Solver (PID: ${SOLVER_PID}) finished or was terminated."
fi
rm -f "${SOLVER_PID_FILE}"

# Check if profile data was generated (e.g., .gcda files for GCC/Clang)
# This is a basic check; specific file names/locations depend on the compiler.
if ! ls *.gcda 1> /dev/null 2>&1 && ! ls *.pgd 1> /dev/null 2>&1; then # .pgd for MSVC
    info "Warning: No PGO data files (.gcda or .pgd) found. Profile generation might have failed."
    info "Ensure the application ran and exited cleanly after performing representative tasks."
fi

# Step 4: Configure for optimized build using the profile data
info "===== STEP 4: Configuring for PGO optimized build ====="
cmake .. "${COMMON_CMAKE_ARGS[@]}" -DENABLE_PGO_USE=ON -DENABLE_PGO_GENERATE=OFF

# Step 5: Build final optimized binary
info "===== STEP 5: Building final PGO optimized binary ====="
cmake --build . --target sudoku_solver --config Release -- -j"${NUM_JOBS}"

info "===== PGO optimization complete! ====="
OPTIMIZED_BINARY_PATH="$(pwd)/sudoku_solver"
if [ ! -f "${OPTIMIZED_BINARY_PATH}" ] && [ -f "$(pwd)/Release/sudoku_solver.exe" ]; then
    OPTIMIZED_BINARY_PATH="$(pwd)/Release/sudoku_solver.exe"
elif [ ! -f "${OPTIMIZED_BINARY_PATH}" ] && [ -f "$(pwd)/bin/sudoku_solver" ]; then
    OPTIMIZED_BINARY_PATH="$(pwd)/bin/sudoku_solver"
fi

if [ -f "${OPTIMIZED_BINARY_PATH}" ]; then
    info "The optimized binary is at: ${OPTIMIZED_BINARY_PATH}"
else
    error "Optimized binary not found!"
fi

cd ..
info "Build script finished."