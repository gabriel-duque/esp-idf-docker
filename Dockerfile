FROM ubuntu:latest

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

ENTRYPOINT ["/bash__wrapper"]
