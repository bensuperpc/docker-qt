#!/bin/bash
set -euo pipefail

rm -rf build

cmake -B build -S tests -G Ninja -DQT_DEBUG_FIND_PACKAGE=ON

cmake --build build && ./build/my_small_app -cli
