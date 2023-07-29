#!/bin/bash

sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start

# Create the database if it doesn't exist
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
# Create the user if it doesn't exist
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
# Grant all privileges on the database to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
# Flush privileges
mysql -e "FLUSH PRIVILEGES;"
# Set the root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASSWORD}';"
# Flush privileges
# mysql -e "FLUSH PRIVILEGES;"
mysql -u root -p${DB_ROOTPASSWORD} -e "FLUSH PRIVILEGES;"

# Stop the MariaDB service
mysqladmin --user=root --password="${DB_ROOTPASSWORD}" shutdown

mysqld_safe