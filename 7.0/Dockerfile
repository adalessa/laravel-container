FROM php:7.0-apache

RUN apt-get update && apt-get install -y \
	libmcrypt-dev \
	curl \
	git \
	zlib1g-dev \
	mysql-client \
	&& docker-php-ext-install mcrypt \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install zip \
	&& docker-php-ext-install pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/bin/composer
RUN a2enmod rewrite
ADD site-default.conf /etc/apache2/sites-available
RUN a2dissite 000-default.conf
RUN a2ensite site-default.conf
RUN service apache2 restart

WORKDIR /var/www/html
