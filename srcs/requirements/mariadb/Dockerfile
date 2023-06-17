# Base image
From alpine:3.14

# Install mariadb server and client
RUN apt-get update && apt-get -y install mariadb-server mariadb-client

# Copy custom configuration file
Copy ./tools/script.sh /etc/mysql/conf.d/

RUN 777 /etc/mysql/conf.d/
# Expose the default mariadb port
EXPOSE 3306

# run the destination script
ENTRYPOINT [ "/etc/mysql/conf.d/" ]

# Start mariadb daemon service
CMD ["mysqld_serv"]