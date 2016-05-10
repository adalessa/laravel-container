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
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"\
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"\
    && php composer-setup.php\
    && php -r "unlink('composer-setup.php');"\
	&& mv composer.phar /usr/bin/composer
RUN echo 'export PHP=/usr/bin/php' >> /etc/bash.bashrc
RUN a2enmod rewrite
ADD site-default.conf /etc/apache2/sites-available
RUN a2dissite 000-default.conf
RUN a2ensite site-default.conf
RUN service apache2 restart

WORKDIR /var/www/html
