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

# Base image
BASE_IMAGE_REGISTRY ?= docker.io
BASE_IMAGE_PATH ?= 
BASE_IMAGE_NAME ?= archlinux
BASE_IMAGE_TAGS ?= base

# Output docker image
AUTHOR ?= bensuperpc
WEB_SITE ?= bensuperpc.org

OUTPUT_IMAGE_REGISTRY ?= docker.io
OUTPUT_IMAGE_PATH ?= bensuperpc
OUTPUT_IMAGE_NAME ?= qt
OUTPUT_IMAGE_VERSION ?= 6.8.3

WORKDIR ?= /work

# Max CPU and memory
CPUS ?= 8.0
CPU_SHARES ?= 1024
MEMORY ?= 16GB
MEMORY_RESERVATION ?= 2GB
TMPFS_SIZE ?= 4GB
BUILD_IMAGE_CPU_SHARES ?= 1024
BUILD_IMAGE_MEMORY ?= 16GB

# Default configuration (disable webengine, it's take a lot of time to build, even with high end CPU)
BUILD_IMAGE_ARGS ?= --build-arg QT_VERSION=$(IMAGE_VERSION) --build-arg QT_CONFIG_ARGS=-skip qtwebengine -nomake examples -nomake tests -opensource -confirm-license -release -shared

TEST_IMAGE_CMD ?= ls
TEST_IMAGE_ARGS ?=
RUN_IMAGE_CMD ?=
RUN_IMAGE_ARGS ?=

include ../template/DockerImage.mk
