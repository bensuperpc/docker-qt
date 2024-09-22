#!/bin/bash
cmake -B build -S tests -G Ninja -DQT_DEBUG_FIND_PACKAGE=ON

cmake --build build && ./build/my_small_app -cli
