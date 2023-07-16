# Base image
FROM debian:buster

# Install nginx
RUN apt update && apt install nginx -y

# Copy custom configuration file
COPY ./conf/nginx.conf /etc/nginx/

# Start nginx server
CMD ["nginx", "-g", "daemon off"]