# Base image
FROM debian:buster

# Set the working directory
WORKDIR /usr/src

# Install php, php-curl, php-mysql, curl, sendmail, and php7.3-fpm
RUN apt update && \
    apt install -y php php-curl php-mysql curl sendmail php7.3-fpm 


COPY ./conf/config.sh /usr/src/config.sh

# Make the config.sh executable
RUN chmod +x config.sh

# RUN the script
CMD ["./config.sh"]