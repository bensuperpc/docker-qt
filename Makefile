#//////////////////////////////////////////////////////////////
#//                                                          //
#//  docker-multimedia, 2024                                 //
#//  Created: 30, May, 2021                                  //
#//  Modified: 14 November, 2024                             //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:                                                 //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

SUBDIRS ?= debian ubuntu fedora archlinux

# Output docker image
PROJECT_NAME ?= qt
AUTHOR ?= bensuperpc
REGISTRY ?= docker.io
BASE_IMAGE_REGISTRY ?= docker.io
WEB_SITE ?= bensuperpc.org

IMAGE_VERSION ?= 6.8.3
IMAGE_NAME ?= $(PROJECT_NAME)

# Max CPU and memory
CPUS ?= 8.0
CPU_SHARES ?= 1024
MEMORY ?= 16GB
MEMORY_RESERVATION ?= 2GB
TMPFS_SIZE ?= 4GB
BUILD_IMAGE_CPU_SHARES ?= 1024
BUILD_IMAGE_MEMORY ?= 16GB

TEST_IMAGE_CMD ?= ./test/test.sh
RUN_IMAGE_CMD ?=

# Default configuration (disable webengine, it's take a lot of time to build, even with high end CPU)
BUILD_IMAGE_ARGS := --build-arg QT_VERSION=$(IMAGE_VERSION) --build-arg QT_CONFIG_ARGS='-skip qtwebengine -nomake examples -nomake tests -opensource -confirm-license -release -shared'

include template/DockerImages.mk
