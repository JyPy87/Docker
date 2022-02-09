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


#Dossier de travail pour les commandes suivantes
WORKDIR /var/www/html

#Installation initiale de modules apache et php
RUN docker-php-ext-install mysqli

#Redémarrage d'Apache pour prendre en compte ces modifications
RUN apachectl restart
