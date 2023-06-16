# Base image
From ubuntu:20.04

# Install mariadb server and client
RUN apt update && apt -y install mariadb-server

# Copy custom configuration file

# Expose the default mariadb port
EXPOSE 3306

# Start mariadb daemon service
CMD ["mysqld"]