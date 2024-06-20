#!/bin/bash
cmake -B build -S tests -G Ninja && cmake --build build && ./build/my_small_app -cli
