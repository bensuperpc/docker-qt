#!/bin/bash
set -euo pipefail

# Run the docker container

docker run --rm \
        --security-opt no-new-privileges --read-only --cap-drop SYS_ADMIN --user 1000:1000 \
        --mount type=bind,source=$(pwd),target=/work --workdir /work \
        --mount type=tmpfs,target=/tmp,tmpfs-mode=1777,tmpfs-size=4GB \
        --platform linux/amd64 \
        --cpus 8.0 --cpu-shares 1024 --memory 16GB --memory-reservation 2GB \
        --name qt-debian-bookworm \
        docker.io/bensuperpc/qt:debian-bookworm-6.8.1 \
        bash -c "cmake -B build -S . -G Ninja -DQT_DEBUG_FIND_PACKAGE=ON && cmake --build build"
