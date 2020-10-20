FROM ubuntu:latest

LABEL maintainer="Gabriel Duque <gabriel@zuh0.com> (zuh0)"

LABEL org.label-schema.build-date="$BUILD_DATE"

LABEL org.label-schema.name="esp-idf-docker"

LABEL org.label-schema.description="Docker image to build and flash ESP32 boards using esp-idf"

LABEL org.label-schema.usage="https://github.com/zuh0/esp-idf-docker/blob/master/README.md"

LABEL org.label-schema.url="https://hub.docker.com/r/zuh0/esp-idf"

LABEL org.label-schema.vcs-url="https://github.com/zuh0/esp-idf"

LABEL org.label-schema.vcs-ref="$VCS_REF"

LABEL org.label-schema.version="$VERSION"

LABEL org.label-schema.schema-version="1.0"

LABEL org.label-schema.docker.cmd="docker run --device=/dev/ttyUSB0 -v $PWD:/root/esp/project zuh0/esp-idf-docker"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
                           git \
                           wget \
                           flex \
                           bison \
                           gperf \
                           python3 \
                           python3-pip \
                           python3-setuptools \
                           cmake \
                           ninja-build \
                           ccache \
                           libffi-dev \
                           libssl-dev \
                           dfu-util \
                           bash \
    && update-alternatives --install \
                                     /usr/bin/python \
                                     python \
                                     /usr/bin/python3 \
                                     10 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p $HOME/esp \
    && cd $HOME/esp \
    && git clone --recursive https://github.com/espressif/esp-idf.git \
    && cd $HOME/esp/esp-idf \
    && ./install.sh \
    && echo '. $HOME/esp/esp-idf/export.sh' >> $HOME/.bashrc \
    && mkdir $HOME/esp/project

COPY bash_wrapper /bash_wrapper

WORKDIR /root/esp/project

VOLUME /root/esp/project

ENTRYPOINT ["/bash_wrapper"]
