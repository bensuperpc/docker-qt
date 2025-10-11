#//////////////////////////////////////////////////////////////
#//                                                          //
#//  docker-multimedia, 2025                                 //
#//  Created: 30, May, 2021                                  //
#//  Modified: 30 March, 2025                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:                                                 //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

SUBDIRS ?= archlinux debian ubuntu alpine debian-qt5

DOCKER_COMPOSITE_SOURCES = common.label-and-env common.entrypoint common.user \
    common.debian.qt6 common.ubuntu.qt6 common.gosu common.archlinux.qt6 common.alpine common.locales \
    common.base.debian common.debian.qt5

# Output docker image
PROJECT_NAME ?= qt
AUTHOR ?= bensuperpc
BASE_IMAGE_REGISTRY ?= docker.io

OUTPUT_IMAGE_REGISTRY ?= docker.io
OUTPUT_IMAGE_PATH ?= bensuperpc
OUTPUT_IMAGE_NAME ?= qt
OUTPUT_IMAGE_VERSION ?= 1.0.0

TAG_WITH_BASE_IMAGE_NAME ?= yes

WEB_SITE ?= bensuperpc.org

# Max CPU and memory
CPUS ?= 8.0
CPU_SHARES ?= 1024
MEMORY ?= 16GB
MEMORY_RESERVATION ?= 2GB
TMPFS_SIZE ?= 4gb
BUILD_IMAGE_CPU_SHARES ?= 1024
BUILD_IMAGE_MEMORY ?= 16GB

TEST_IMAGE_CMD ?= ./tests/tests.sh
RUN_IMAGE_CMD ?=

include template/DockerImages.mk
