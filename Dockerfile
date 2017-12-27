FROM ubuntu:16.04

LABEL authors="Yves Hoppe, Robert Deutz"

# Install
RUN apt-get update \
  && DEBIAN_FRONTEND='noninteractive' apt-get -y install software-properties-common apt-transport-https language-pack-en-base \
  && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
  && apt-get update \
	&& DEBIAN_FRONTEND='noninteractive' apt-get install -y --allow-unauthenticated \
    git curl mysql-client wget postgresql-client \
    php7.1 php7.1-common php7.1-xdebug  \
	  php7.1-gd php7.1-gettext php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-sqlite3 \
    php7.1-pgsql php7.1-curl php7.1-ldap php7.1-zip php7.1-xml \
		&& sed -i 's/memory_limit\s*=.*/memory_limit=-1/g' /etc/php/7.1/cli/php.ini \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && apt-get install -y --allow-unauthenticated php-memcached php-memcache php-redis\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && cd /usr/local/bin