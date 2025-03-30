ARG BASE_IMAGE=archlinux:base
FROM ${BASE_IMAGE} AS base

RUN pacman-key --init && pacman -Sy archlinux-keyring --noconfirm && pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
#   ffmpeg and video tools
RUN pacman -Syu --noconfirm && pacman -S --noconfirm \
    # Essential packages
    base-devel git cmake extra-cmake-modules ninja automake autoconf \
    libtool pkgconf mesa vulkan-devel vulkan-headers vulkan-icd-loader \ 
    openssl glib2 dbus libxkbcommon-x11 libxkbcommon ccache bash \
    && pacman -Scc --noconfirm

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 \
    localectl set-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Buider image
FROM base AS builder

RUN pacman -Syu --noconfirm && pacman -S --noconfirm \
# All needed packages
    util-linux mesa meson clang llvm ca-certificates gnupg fontconfig freetype2 \
    libxext libxfixes libxi libxrender freeglut mesa glu vulkan-radeon lsb-release \
    at-spi2-core wayland xorg-server-devel xorg-server xorg-apps libx11 libxcb \
    xkeyboard-config libxkbcommon ffmpeg bluez libwebp bluez-libs nodejs python \
    python-html5lib gperf bison flex nss libxshmfence cups libpulse alsa-lib \
    gstreamer gst-plugins-base ffmpeg opus x264 x265 lame libvorbis libtheora \
    speex openal libsndfile flac libogg opusfile libmodplug mpg123 sndio wavpack \
    faad2 gsm libdv libproxy krb5 icu zlib \
    && pacman -Scc --noconfirm

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

ARG BUILD_DATE=${BUILD_DATE}
ARG QT_VERSION=6.8.3
ENV QT_VERSION=${QT_VERSION}

COPY --from=builder /usr/local/Qt-$QT_VERSION/ /usr/local/Qt-$QT_VERSION/
ENV QT_DIR="/usr/local/Qt-$QT_VERSION"
ENV Qt6_DIR="/usr/local/Qt-$QT_VERSION/lib/cmake/Qt6"
ENV CMAKE_PREFIX_PATH="/usr/local/Qt-$QT_VERSION/lib/cmake"
ENV PATH="/usr/local/Qt-$QT_VERSION/bin:$PATH"
ARG VCS_REF=""
ARG VCS_URL="https://github.com/bensuperpc/docker-qt"
ARG OUTPUT_IMAGE_NAME=${OUTPUT_IMAGE_NAME}
ARG AUTHOR="Bensuperpc"
ARG URL="https://github.com/bensuperpc"

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
      org.label-schema.name=${OUTPUT_IMAGE_NAME} \
      org.label-schema.description="qt tools" \
      org.label-schema.version=${IMAGE_VERSION} \
      org.label-schema.vendor=${AUTHOR} \
      org.label-schema.url=${URL} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.docker.cmd=""

VOLUME [ "/work" ]
WORKDIR /work

COPY --from=root-project common/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh && chown root:root /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash", "-l"]
