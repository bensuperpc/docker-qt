#!/usr/bin/env bash

set -xeuo pipefail

rm -rf build || true

cmake -B build -S tests -G Ninja -DQT_DEBUG_FIND_PACKAGE=ON

cmake --build build

export QT_QPA_PLATFORM=offscreen
export QT_FORCE_STDERR_LOGGING=1

./build/my_small_app
