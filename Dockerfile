FROM ubuntu:14.04

RUN apt-get update && apt-get -y install unzip curl libunwind8 gettext libssl-dev libcurl4-openssl-dev zlib1g libicu-dev uuid-dev make automake libtool \
    && curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_BRANCH=dev sh \
    && bash -c "source ~/.dnx/dnvm/dnvm.sh && dnvm upgrade -u -r coreclr" \
    && curl -sSL https://github.com/libuv/libuv/archive/v1.8.0.tar.gz | tar zxfv - -C /usr/local/src \
    && cd /usr/local/src/libuv-1.8.0 \
    && sh autogen.sh && ./configure && make && make install \
    && rm -rf /usr/local/src/libuv-1.8.0 \
    && ldconfig \
    && apt-get -y purge autoconf automake build-essential libtool \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
    