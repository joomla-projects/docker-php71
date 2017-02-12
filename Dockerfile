FROM ubuntu:16.04

LABEL authors="Yves Hoppe, Robert Deutz"

# Install
RUN apt-get update \
  && DEBIAN_FRONTEND='noninteractive' apt-get -y install software-properties-common apt-https-transport \
  && add-apt-repository ppa:ondrej/php \
  && apt-get update \
	&& DEBIAN_FRONTEND='noninteractive' apt-get install -y --allow-unauthenticated php php-memcache php-memcached php-redis php-xdebug wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && cd /usr/local/bin \
    && wget -O phpunit --no-check-certificate https://phar.phpunit.de/phpunit-4.8.27.phar \
    && chmod +x phpunit
