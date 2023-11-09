# Base image
FROM debian:bullseye

RUN apt update && \
    apt install -y php php-mysql php-curl wget php7.4-fpm 


COPY ./conf/config.sh .

RUN chmod +x config.sh

CMD ["./config.sh"]