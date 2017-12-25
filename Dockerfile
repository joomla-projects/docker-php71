FROM ubuntu:16.04

LABEL authors="Yves Hoppe, Robert Deutz"

# Install
RUN apt-get update \
  && DEBIAN_FRONTEND='noninteractive' apt-get -y install software-properties-common apt-transport-https language-pack-en-base \
  && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
  && apt-get update \
	&& DEBIAN_FRONTEND='noninteractive' apt-get install -y --allow-unauthenticated php7.1 php-memcache php-memcached php-redis php-xdebug wget \
	  curl composer php-gd php-gettext php-mbstring php-mcrypt php-mysql php-phpseclib php-sqlite3 mysql-client postgresql-client php-pgsql php-curl php-ldap php-zip\
		&& sed -i 's/memory_limit\s*=.*/memory_limit=-1/g' /etc/php/7.1/cli/php.ini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && cd /usr/local/bin