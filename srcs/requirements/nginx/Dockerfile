# Base image
FROM debian:buster

# Install nginx and openssl
RUN apt-get update && apt-get -y install nginx openssl && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy custom configuration file
COPY ./conf/default /etc/nginx/sites-enabled/default

EXPOSE 3360

# Copy SSL script and set permissions
COPY ./tools/ssl_script.sh /var/www/
RUN chmod +x /var/www/ssl_script.sh

# Run the SSL script to generate the certificate and configure nginx
RUN /var/www/ssl_script.sh

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
