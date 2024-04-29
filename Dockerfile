ARG DOCKER_IMAGE=debian:bookworm
FROM ${DOCKER_IMAGE} as requirements

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.utf8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -y install \
# All needed packages
    build-essential debianutils mesa-common-dev \
    ninja-build cmake meson git \
    apt-transport-https ca-certificates gnupg2 \
    locales lsb-release libssl-dev \
    libfontconfig1-dev libfreetype6-dev \
    libxext-dev libxfixes-dev libxi-dev libxrender-dev \
    freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev \
    libvulkan-dev mesa-vulkan-drivers \
    libatspi2.0-dev libwayland-dev \
    xserver-xorg-dev xorg-dev \
    libegl1-mesa-dev libgles2-mesa-dev \
    libclang-dev libclang-cpp-dev \
    libx11-* libx11* libxcb-* libxcb* libxkb* \
    ffmpeg libavcodec-dev libavformat-dev libavutil-dev bluez \
    libwebp-dev libbluetooth-dev nodejs \
    python3-dev python3-html5lib gperf \
    bison flex libnss3* libxshmfence-dev libcups2-dev \
    ffmpeg libpulse-dev libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libavcodec-dev libavfilter-dev libvpx-dev \
    libopus-dev libx264-dev libx265-dev libmp3lame-dev libvorbis-dev libtheora-dev libspeex-dev libopenal-dev libsndfile1-dev \
    libflac-dev libogg-dev libopusfile-dev libmodplug-dev libmpg123-dev libsndio-dev libwavpack-dev libfaad-dev libgsm1-dev libdv4-dev \
    ccache distcc \
    && apt-get clean \
    && apt-get -y autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

FROM requirements as builder
ARG QT_VERSION=6.7.1
ENV QT_VERSION=${QT_VERSION}

WORKDIR /qt5

# Keep unoptimized for avoid redownload everything when build fail
RUN git clone --recurse-submodules --shallow-submodules --depth 1 --branch $QT_VERSION https://github.com/qt/qt5.git
WORKDIR /qt5/qt5
RUN ./configure -prefix /usr/local/Qt-$QT_VERSION -release -confirm-license
RUN cmake --build . --parallel
RUN cmake --install .

WORKDIR /work

FROM requirements as final
ARG QT_VERSION=6.7.0
ENV QT_VERSION=${QT_VERSION}

COPY --from=builder /usr/local/Qt-$QT_VERSION/ /usr/local/Qt-$QT_VERSION/
ENV PATH="${PATH}:/usr/local/Qt-$QT_VERSION/bin"

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL=""
ARG PROJECT_NAME=""
ARG AUTHOR=""
ARG URL=""

ARG IMAGE_VERSION="1.0.0"
ENV IMAGE_VERSION=${IMAGE_VERSION}

ARG CCACHE_MAXSIZE=16G
ENV CCACHE_MAXSIZE=${CCACHE_MAXSIZE}

ENV LANG en_US.utf8
ENV LC_ALL en_US.UTF-8
ENV TERM xterm-256color

LABEL maintainer="Bensuperpc"
LABEL author="Bensuperpc"
LABEL description=""

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name=${PROJECT_NAME} \
      org.label-schema.description="yocto" \
      org.label-schema.version=${IMAGE_VERSION} \
      org.label-schema.vendor=${AUTHOR} \
      org.label-schema.url=${URL} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.docker.cmd=""


ARG USER_NAME=bedem
ENV HOME=/home/$USER_NAME
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd -g $USER_GID -o $USER_NAME
RUN useradd -m -u $USER_UID -g $USER_GID -o -s /bin/bash $USER_NAME
USER $USER_NAME

WORKDIR /home/$USER_NAME

VOLUME ["/work"]
WORKDIR /work

CMD ["/bin/bash", "-l"]
