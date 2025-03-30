# Base image
ARG DOCKER_IMAGE=debian:bookworm
FROM ${DOCKER_IMAGE} AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install \
# Essential packages to build and link to right libraries
    build-essential git cmake extra-cmake-modules ninja-build \
    automake autoconf libtool pkg-config \
    libgl1-mesa-dev libvulkan-dev libssl-dev libglib2.0-dev \
    libdbus-1-dev libxkbcommon-x11-dev ccache bash locales \
    && apt-get clean \
    && apt-get -y autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Buider image
FROM base AS builder

RUN apt-get update && apt-get -y install \
# All needed packages
    debianutils mesa-common-dev meson libclang-dev \
    apt-transport-https ca-certificates gnupg2 \
    libfontconfig1-dev libfreetype6-dev \
    libxext-dev libxfixes-dev libxi-dev libxrender-dev \
    freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev \
    mesa-vulkan-drivers lsb-release \
    libatspi2.0-dev libwayland-dev \
    xserver-xorg-dev xorg-dev \
    libegl1-mesa-dev libgles2-mesa-dev \
    libx11-* libx11* libxcb-* libxcb* libxkb* \
    ffmpeg libavcodec-dev libavformat-dev libavutil-dev bluez \
    libwebp-dev libbluetooth-dev nodejs \
    python3-dev python3-html5lib gperf \
    bison flex libnss3* libxshmfence-dev libcups2-dev \
    ffmpeg libpulse-dev libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libavcodec-dev libavfilter-dev libvpx-dev \
    libopus-dev libx264-dev libx265-dev libmp3lame-dev libvorbis-dev libtheora-dev libspeex-dev libopenal-dev libsndfile1-dev \
    libflac-dev libogg-dev libopusfile-dev libmodplug-dev libmpg123-dev libsndio-dev libwavpack-dev libfaad-dev libgsm1-dev libdv4-dev \
    libproxy-dev libkrb5-dev libicu-dev zlib1g-dev \
    && apt-get clean \
    && apt-get -y autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /qt5
RUN git clone https://github.com/qt/qt5.git

WORKDIR /qt5/qt5

ARG QT_VERSION=6.8.3
ENV QT_VERSION=${QT_VERSION}

RUN git switch $QT_VERSION && perl init-repository

# Default configuration (disable webengine, it's take a lot of time to build, even with high end CPU)
ARG QT_CONFIG_ARGS="-skip qtwebengine -nomake examples -nomake tests -opensource -confirm-license -release"
ENV QT_CONFIG_ARGS=${QT_CONFIG_ARGS}
RUN ./configure -prefix /usr/local/Qt-$QT_VERSION $QT_CONFIG_ARGS

RUN cmake --build . --parallel
RUN cmake --install .

FROM base AS final

ARG QT_VERSION=6.8.3
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
