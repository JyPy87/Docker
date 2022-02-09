#image de base
FROM php:7.4-apache
#Port ouvert (web = 80)
EXPOSE 8000:80
#Dossier de travail pour les commandes suivanes
WORKDIR /var/www/html

#Installation initiale de modules apache et php
RUN a2enmod headers deflate expires rewrite
RUN docker-php-ext-install mysqli

#Redémarrage d'Apache pour prendre en compte ces modifications
RUN apachectl restart
