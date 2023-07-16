# Base image
FROM debian:10

# Set the working directory
# WORKDIR /usr/src

# Install php, php-curl, php-mysql, curl, sendmail, and php7.3-fpm
RUN apt update && \
    apt install -y php php-curl php-mysql wget php7.3-fpm 


COPY ./conf/config.sh .

# Make the config.sh executable
RUN chmod +x config.sh

# RUN the script
CMD ["./config.sh"]