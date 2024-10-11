# Base image
ARG DOCKER_IMAGE=fedora:latest
FROM ${DOCKER_IMAGE} AS base

# Install essential packages to build and link to right libraries
RUN dnf -y update && dnf -y install \
    glibc-locale-source glibc-langpack-en \
    @development-tools git cmake extra-cmake-modules ninja-build \
    autoconf automake libtool pkgconfig \
    mesa-libGL-devel vulkan-loader-devel openssl-devel glib2-devel \
    dbus-devel libxkbcommon-devel ccache bash glibc-langpack-en \
    && dnf clean all

# Set up locale
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Builder image
FROM base AS builder

# Install all necessary packages
RUN dnf -y update && dnf -y install \
    fedora-workstation-repositories mesa-libGL-devel meson clang-devel \
    fontconfig freetype-devel \
    libXext-devel libXfixes-devel libXi-devel libXrender-devel \
    freeglut-devel mesa-libGLU-devel vulkan-loader \
    at-spi2-core-devel wayland-devel \
    xorg-x11-server-Xorg xorg-x11-server-devel \
    mesa-libEGL-devel mesa-libGLES-devel \
    libX11-devel libxcb-devel \
    ffmpeg ffmpeg-free bluez \
    libwebp-devel bluez-libs-devel nodejs \
    python3-devel gperf \
    bison flex nss-devel cups-devel \
    pulseaudio-libs-devel alsa-lib-devel gstreamer1-devel \
    gstreamer1-plugins-base-devel libavcodec-free libvpx-devel \
    opus-devel lame-devel speex-devel openal-soft-devel \
    flac-devel libogg-devel opusfile-devel libmodplug-devel mpg123-devel wavpack-devel \
    gsm-devel libdv-devel krb5-devel icu libicu-devel zlib-devel \
    && dnf clean all

WORKDIR /qt5
RUN git clone https://github.com/qt/qt5.git

WORKDIR /qt5/qt5

ARG QT_VERSION=6.8.0
ENV QT_VERSION=${QT_VERSION}

RUN git switch $QT_VERSION && perl init-repository

# Default configuration (disable webengine to save build time)
ARG QT_CONFIG_ARGS="-skip qtwebengine -nomake examples -nomake tests -opensource -confirm-license -release"
ENV QT_CONFIG_ARGS=${QT_CONFIG_ARGS}
RUN ./configure -prefix /usr/local/Qt-$QT_VERSION $QT_CONFIG_ARGS

RUN cmake --build . --parallel
RUN cmake --install .

FROM base AS final

ARG QT_VERSION=6.8.0
ENV QT_VERSION=${QT_VERSION}

COPY --from=builder /usr/local/Qt-$QT_VERSION/ /usr/local/Qt-$QT_VERSION/
ENV QT_DIR="/usr/local/Qt-$QT_VERSION"
ENV Qt6_DIR="/usr/local/Qt-$QT_VERSION/lib/cmake/Qt6"
ENV CMAKE_PREFIX_PATH="/usr/local/Qt-$QT_VERSION/lib/cmake"
ENV PATH="/usr/local/Qt-$QT_VERSION/bin:$PATH"

ARG BUILD_DATE=""
ARG VCS_REF=""
ARG VCS_URL=""
ARG PROJECT_NAME=""
ARG AUTHOR=""
ARG URL=""

ARG IMAGE_VERSION="1.0.0"
ENV IMAGE_VERSION=${IMAGE_VERSION}

ARG CCACHE_MAXSIZE=16G
ENV CCACHE_MAXSIZE=${CCACHE_MAXSIZE}

ENV TERM=xterm-256color

LABEL maintainer="Bensuperpc"
LABEL author="Bensuperpc"
LABEL description="Docker image with qt"

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name=${PROJECT_NAME} \
      org.label-schema.description="qt" \
      org.label-schema.version=${IMAGE_VERSION} \
      org.label-schema.vendor=${AUTHOR} \
      org.label-schema.url=${URL} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.docker.cmd=""

VOLUME [ "/work" ]
WORKDIR /work

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/bin/bash" ]
