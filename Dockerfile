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


# Node js installation
# gpg keys listed at https://github.com/nodejs/node
RUN apt-get install -y xz-utils
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 4.4.4

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" 
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" 
RUN gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc 
RUN grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - 
RUN tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 


WORKDIR /var/www/html
