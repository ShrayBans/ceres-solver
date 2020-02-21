#!/bin/bash

set -e

export OPTIMIZE="-Os"
export LDFLAGS="${OPTIMIZE}"
export CFLAGS="${OPTIMIZE}"
export CXXFLAGS="${OPTIMIZE}"

echo "============================================="
echo "Compiling wasm bindings"
echo "============================================="
(
    # Compile C/C++ code
    emcc \
    ${OPTIMIZE} \
    --bind \
    -s STRICT=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s MALLOC=emmalloc \
    -s MODULARIZE=1 \
    -s EXPORT_ES6=1 \
    -s ERROR_ON_UNDEFINED_SYMBOLS=0 \
    -o ./curve-fit.js \
    -Iinclude \
    -Iconfig \
    -Iinternal \
    examples/curve_fitting.c
    
    # Create output folder
    mkdir -p dist
    # Move artifacts
    mv curve-fit.{js,wasm} dist
)
echo "============================================="
echo "Compiling wasm bindings done"
echo "============================================="

# docker run --rm  -v $(pwd):/src trzeci/emscripten ./build.sh