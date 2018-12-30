FROM php:7.1-apache-stretch

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
#        libmcrypt-dev \
        libgmp-dev \
        libpng-dev \
        libgd3 \
        libgd-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gmp \
    && docker-php-ext-install -j$(nproc) mysqli gmp \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && apt-get clean

RUN a2enmod ssl rewrite headers expires;

ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/certs/cacert.pem
