FROM adalessa/laravel-container:5.6

RUN apt-get update && apt-get install -y \	
    libz-dev \
    libmemcached-dev
RUN pecl install memcached
RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
