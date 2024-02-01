ARG DOCKER_IMAGE=debian:bookworm
FROM ${DOCKER_IMAGE} as requirements

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.utf8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -y install \
# All needed packages
	build-essential debianutils mesa-common-dev \
    ccache ninja-build cmake distcc icecc meson \
	apt-transport-https ca-certificates gnupg2 \
	locales lsb-release openssl git \
# Qt dependencies
    libfontconfig1-dev libfreetype6-dev libx11-dev \
    libxext-dev libxfixes-dev libxi-dev libxrender-dev \
    libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev \
    libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev \
    libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev \
    libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev \
    libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev \
    libxkbcommon-x11-dev libxcb-render0-dev libatspi2.0-dev \
    freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev \
    xorg-dev xserver-xorg-dev \
    libwayland-dev \
# Other packages
	bash-completion \
	&& apt-get clean \
	&& apt-get -y autoremove --purge \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

FROM requirements as builder

ARG QT_VERSION="6.6.2"
ENV QT_VERSION=${QT_VERSION}

WORKDIR /Qt

RUN git clone --recurse-submodules --shallow-submodules --depth 1 --branch ${QT_VERSION} https://github.com/qt/qt5.git \
    && cd qt5 && ./configure -prefix /usr/local/Qt-${QT_VERSION} -release \
    && cmake --build . && cmake --install . \
    && rm -rf /Qt

WORKDIR /work

FROM requirements as final

ARG QT_VERSION="6.6.2"
COPY --from=builder /usr/local/Qt-${QT_VERSION}/ /usr/local/Qt-${QT_VERSION}/

ARG BUILD_DATE=""
ARG VCS_REF=""
ARG VCS_URL=""
ARG PROJECT_NAME=""
ARG AUTHOR=""
ARG URL=""

ARG CCACHE_MAXSIZE="16G"
ENV CCACHE_MAXSIZE=${CCACHE_MAXSIZE}

ARG IMAGE_VERSION="1.0.0"
ENV IMAGE_VERSION=${IMAGE_VERSION}

ENV LANG en_US.utf8
ENV LC_ALL en_US.UTF-8
ENV TERM xterm-256color
ENV PATH="${PATH}:/usr/local/Qt-${QT_VERSION}/bin"

LABEL maintainer="Bensuperpc"
LABEL author="Bensuperpc"
LABEL description=""

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
