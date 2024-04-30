# Dockerfile
FROM php:8.1-apache

ENV COMPOSER_ALLOW_SUPERUSER=1

EXPOSE 80

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -qy \
    libicu-dev \
    libzip-dev \
    zlib1g-dev \
    git \
    gnupg \
    net-tools \
    unzip \
    zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install -j$(nproc) opcache pdo_mysql bcmath zip
COPY docker/conf/php.ini /usr/local/etc/php/conf.d/app.ini

COPY docker/errors /errors
COPY docker/conf/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY docker/conf/apache.conf /etc/apache2/conf-available/z-app.conf
COPY docker/conf/remoteip.conf /etc/apache2/conf-available/remoteip.conf
RUN a2enmod rewrite remoteip && \
    a2enconf z-app && \
    a2enconf remoteip

VOLUME /app

RUN chmod -R 755 /app
RUN chown -R www-data:www-data /app

HEALTHCHECK CMD netstat -lnt | grep :80 || exit 1

