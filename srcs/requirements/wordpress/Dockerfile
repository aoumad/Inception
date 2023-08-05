# Base image
FROM debian:10

RUN apt update && \
    apt install -y php php-mysql php-curl wget php7.3-fpm 


COPY ./conf/config.sh .

RUN chmod +x config.sh

CMD ["./config.sh"]