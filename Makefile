#//////////////////////////////////////////////////////////////
#//                                                          //
#//  docker-qt, 2023                                         //
#//  Created: 04 February, 2023                              //
#//  Modified: 05 October, 2024                              //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:                                                 //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

SUBDIRS := debian ubuntu fedora

# Output docker image
PROJECT_NAME := qt
AUTHOR := bensuperpc
REGISTRY := docker.io

IMAGE_VERSION := 6.8.0
# linux/amd64,linux/amd64/v3, linux/arm64, linux/riscv64, linux/ppc64
ARCH_LIST := linux/amd64
comma:= ,
PLATFORMS := $(subst $() $(),$(comma),$(ARCH_LIST))

# Max CPU and memory
CPUS := 8.0
CPU_SHARES := 1024
MEMORY := 16GB
MEMORY_RESERVATION := 2GB
TMPFS_SIZE := 4GB
BUILD_CPU_SHARES := 1024
BUILD_MEMORY := 16GB

# Qt config
QT_VERSION := $(IMAGE_VERSION)
# Default configuration (disable webengine, it's take a lot of time to build, even with high end CPU)
QT_CONFIG_ARGS := -skip qtwebengine -nomake examples -nomake tests \
	-opensource -confirm-license -release -shared

# Custom targets
CUSTOM_TARGETS := help

# Merge all variables
MAKEFILE_VARS := PROJECT_NAME=$(PROJECT_NAME) AUTHOR=$(AUTHOR) REGISTRY=$(REGISTRY) \
	IMAGE_VERSION=$(IMAGE_VERSION) PLATFORMS="$(PLATFORMS)" \
	CPUS=$(CPUS) CPU_SHARES=$(CPU_SHARES) MEMORY=$(MEMORY) MEMORY_RESERVATION=$(MEMORY_RESERVATION) \
	QT_VERSION=$(QT_VERSION) QT_CONFIG_ARGS="$(QT_CONFIG_ARGS)"

.PHONY: all clean build test purge update push pull $(SUBDIRS) $(CUSTOM_TARGETS)

default: all

$(SUBDIRS):
	$(MAKE) $(MAKEFILE_VARS) -C $@ all

all: $(addsuffix -all, $(SUBDIRS))

%.all:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.all,%,$@) all

build: $(addsuffix .build, $(SUBDIRS))

%.build:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.build,%,$@) build

test: $(addsuffix .test, $(SUBDIRS))

%.test:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.test,%,$@) test

clean: $(addsuffix .clean, $(SUBDIRS))

%.clean:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.clean,%,$@) clean

purge: $(addsuffix .purge, $(SUBDIRS))

%.purge:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.purge,%,$@) purge

update: $(addsuffix .update, $(SUBDIRS))

%.update:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.update,%,$@) update

push: $(addsuffix .push, $(SUBDIRS))

%.push:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.push,%,$@) push

pull: $(addsuffix .pull, $(SUBDIRS))

%.pull:
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.pull,%,$@) pull

$(CUSTOM_TARGETS): $(addsuffix .$(CUSTOM_TARGETS), $(SUBDIRS))

%.$(CUSTOM_TARGETS):
	$(MAKE) $(MAKEFILE_VARS) -C $(patsubst %.$(CUSTOM_TARGETS),%,$@) $(CUSTOM_TARGETS)
