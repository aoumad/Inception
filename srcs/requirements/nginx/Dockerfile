# # Base image
# FROM debian:buster

# # Set environment variables
# ENV private_key=/etc/ssl/private/nginx.key
# ENV certs_crt=/etc/ssl/certs/nginx.crt
# ENV DOMAINE_NAME=yismaili.42.fr

# # Install nginx and openssl
# RUN apt-get update && apt-get -y install nginx openssl && rm -rf /var/lib/apt/lists/* \
#     rm -rf /var/lib/apt/lists/*

# # Copy custom configuration file
# COPY ./conf/default /etc/nginx/sites-enabled/default

# COPY ./tools/ssl_script.sh /var/www/

# # Start nginx server
# CMD ["nginx", "-g", "daemon off;"]


# Base image
FROM debian:buster

# Set environment variables
ENV private_key=/etc/ssl/private/nginx.key
ENV certs_crt=/etc/ssl/certs/nginx.crt
ENV DOMAINE_NAME=yismaili.42.fr

# Install nginx and openssl
RUN apt-get update && apt-get -y install nginx openssl && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy custom configuration file
COPY ./conf/default /etc/nginx/sites-enabled/default

# Copy SSL script and set permissions
COPY ./tools/ssl_script.sh /var/www/
RUN chmod +x /var/www/ssl_script.sh

# Run the SSL script to generate the certificate and configure nginx
RUN /var/www/ssl_script.sh

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
