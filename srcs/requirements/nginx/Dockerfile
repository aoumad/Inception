# Base image
FROM debian:buster

RUN apt-get update && apt-get -y install nginx openssl && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/default /etc/nginx/sites-enabled/default

EXPOSE 443

COPY ./tools/ssl_script.sh /var/www/
RUN chmod +x /var/www/ssl_script.sh

RUN /var/www/ssl_script.sh

CMD ["nginx", "-g", "daemon off;"]
