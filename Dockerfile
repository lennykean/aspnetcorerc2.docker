FROM ubuntu:14.04

ENV DNX_VERSION 1.0.0-rc2-16357
ENV DNX_USER_HOME /opt/dnx

RUN apt-get update \
    && apt-get -y install unzip curl libicu-dev libunwind8 gettext libssl-dev libcurl3-gnutls zlib1g autoconf automake build-essential libtool \
    && curl -sSL https://github.com/libuv/libuv/archive/v1.8.0.tar.gz | tar zxfv - -C /usr/local/src \
    && cd /usr/local/src/libuv-1.8.0 \
    && sh autogen.sh && ./configure && make && make install \
    && rm -rf /usr/local/src/libuv-1.8.0 \
    && ldconfig \
    && apt-get -y purge autoconf automake build-essential libtool \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
    
RUN curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_USER_HOME=$DNX_USER_HOME sh \
    && bash -c "source $DNX_USER_HOME/dnvm/dnvm.sh \
    && dnvm install -u $DNX_VERSION -alias default -r coreclr \
    && dnvm alias default | xargs -i ln -s $DNX_USER_HOME/runtimes/{} $DNX_USER_HOME/runtimes/default"
