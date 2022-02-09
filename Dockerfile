#TUTO ALSACREATION 
#https://www.alsacreations.com/tuto/lire/1838-Docker-compose.html
#PHP
FROM php:7.4-apache

#Modules apache
RUN a2enmod headers deflate expires rewrite
EXPOSE 80:80

#Composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Paquet supplementaire:
RUN apt-get update && apt-get install -y zip unzip vim

# Extensions MySQL pour PHP/WordPress
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Imagick pour WordPress (https://webapplicationconsultant.com/docker/how-to-install-imagick-in-php-docker/)
RUN apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick

# Virtualhost
COPY Docker-vhost.conf /etc/apache2/sites-enabled/docker-vhost-wp.conf

#Dossier de travail pour les commandes suivantes
WORKDIR /var/www/html/app

#Redémarrage d'Apache pour prendre en compte ces modifications
RUN apachectl restart
