#!/bin/bash

# Set build type to Release if not already set
BUILD_TYPE=${CMAKE_BUILD_TYPE:-Release}

# Use native CPU optimizations if --native-opts flag is provided
if [[ "$*" == *"--native-opts"* ]]; then
  NATIVE_OPTS="-march=native"
fi

# Default CMake generator (you can change this as needed)
GENERATOR=""

# Handle custom build directory
BUILD_DIR="build"
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --build-dir)
      BUILD_DIR="$2"
      shift # past argument
      shift # past value
      ;;
    --generator)
      GENERATOR="-G \"$2\""
      shift
      shift
      ;;
    --native-opts)
      # consume the flag but don't do anything, already handled above
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Create build directory if it doesn't exist
mkdir -p "${BUILD_DIR}"

# Configure CMake
cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} ${NATIVE_OPTS} ${GENERATOR} -S . -B "${BUILD_DIR}"

# Build the project
cmake --build "${BUILD_DIR}" --config ${BUILD_TYPE}