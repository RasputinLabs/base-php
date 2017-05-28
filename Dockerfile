FROM php:7.1-fpm
MAINTAINER David Ramsington <grokbot.dwr@gmail.com>

WORKDIR /tmp
COPY ./sources/* /etc/apt/sources.list.d/
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    curl --silent https://packagecloud.io/gpg.key | apt-key add - && \
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 5072E1F5 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    unzip \
    lsof \
    procps \
    wget \
    bzip2 \
    gettext-base \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev && \
    docker-php-ext-install -j$(nproc) iconv mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    wget https://www.dotdeb.org/dotdeb.gpg && \
    apt-key add dotdeb.gpg && \
    curl --silent https://deb.nodesource.com/setup_7.x | bash -
