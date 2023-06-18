#!/bin/bash

set -e

# Initialize MariaDB data directory
sudo mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Starting the MySQL service using systemctl in a non-root user context
systemctl --user start mariadb

# Wait for the MariaDB service to start
while ! mysqladmin ping --silent; do
    sleep 1
done

# Modify the bind address
printf "bind-address = 0.0.0.0\n" | sudo tee /tmp/my.cnf.tmp
sudo sed -i '/^bind-address/c\bind-address = 0.0.0.0' /etc/mysql/my.cnf

# Set the root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOTPASSWORD}'"

# Create the database if it doesn't exist
mysql -e "CREATE DATABASE IF NOT EXISTS '${MYSQL_DATABASE}'"

# Create the user if it doesn't exist
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant all privileges on the database to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"

# Flush privileges
mysql -e "FLUSH PRIVILEGES;"

# Stop the MariaDB service
mysqladmin --user=root --password="${MYSQL_ROOTPASSWORD}" shutdown

# Wait for the MariaDB service to stop
while mysqladmin --user=root --password="${MYSQL_ROOTPASSWORD}" ping --silent; do
    sleep 1
done

exec "$@"