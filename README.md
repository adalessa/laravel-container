#A container for Laravel

This container has the basic extensions and configuration to run a laravel application. Base on the php official containers I create my own ones.

The latest containers also includes support for memcached. Composer and node js are installed.

    docker pull adalessa/php-apache-laravel

To run a single container you only need to run

    docker run --name myApp -p 8080:80 -v "$PWD":/var/www/html adalessa/php-apache-laravel
 


 This will start a new container and it will expose the port 8080 in your local machine.

If you already have your laravel application you only need to run this command from the root directory of your application

You can create an application from scratch with this container, since composer it is installed in the container you can run

    docker exec myApp composer create-project --prefer-dist laravel/laravel .

 This will create all the application for you.
 if you already have your application you can only run 

    docker exec myApp composer install
 If you are using laravel elixir or gulp or anything with node js you can install your dependencies

    docker exec myApp npm install
 
 If your application is bigger and you need may want to use docker-composer to have all your containers related.
 docker-composer.yml 

    web:
      image: adalessa/php-apache-laravel
      ports:
        - "5000:80"
      volumes:
        - ./code:/var/www/html
      links:
        - mysql
    mysql:
      image: mysql:5.6
      env_file: mysql.env
      ports:
       - "4306:3306"
Also have this mysql.env file that will container the root password for your database

    MYSQL_ROOT_PASSWORD=root


Having this link you only need to set as your mysql server in the config as "mysql", docker composer will automatically generate the link and the name resolution

To run the command from the container you can use docker-composer instead of docker, this will give you an easy to execute code in the container. 

    docker-composer exec web composer install

  
Github: https://github.com/adalessa/DockerLaravel

