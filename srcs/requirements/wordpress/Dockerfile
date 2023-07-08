# Base image
FROM debian:buster

# install php and php-curl and php-mysql and curl and sendmail and php7.3-fpm
RUN apt update &&  apt install -y php php-curl php-mysql && apt install -y curl \
    && apt install -y sendmail && apt install -y php7.3-fpm

# Set environment variables
ENV MYSQL_DATABASE=mydatabase
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword
ENV DB_HOST=dbhost
ENV DOMAIN_NAME=mydomain.com
ENV TITLE="My Wordpress Site"
ENV ADMIN_USER=admin
ENV ADMIN_PASSWORD=adminpassword
ENV ADMIN_EMAIL=admin@example.com
ENV USER=myuser
ENV USER_EMAIL=user@example.com
ENV USER_PASSWORD=userpassword

