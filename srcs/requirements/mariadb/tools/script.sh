#!/bin/bash

# set -e

# Initialize MariaDB data directory
# mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Starting the MySQL service
# mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &

# Wait for the MariaDB service to start
# while ! mysqladmin ping --silent; do
#     sleep 1
# done
# # Mysql setup

MYSQL_USER=abdo
MYSQL_DATABASE=wokokoko
MYSQL_PASSWORD=1337
MYSQL_ROOTPASSWORD=1337

sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf
# Modify the bind address
# printf "bind-address = 0.0.0.0\n" | tee /tmp/my.cnf.tmp
# sed -i '/^bind-address/c\bind-address = 0.0.0.0' /etc/mysql/my.cnf
service mysql start
# Create the database if it doesn't exist
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
# Create the user if it doesn't exist
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# Grant all privileges on the database to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"

# Flush privileges
mysql -e "FLUSH PRIVILEGES;"
# Set the root password

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOTPASSWORD}';"

# Flush privileges
# mysql -e "FLUSH PRIVILEGES;"
mysql -u root -p${MYSQL_ROOTPASSWORD} -e "FLUSH PRIVILEGES;"

# Stop the MariaDB service
mysqladmin --user=root --password="${MYSQL_ROOTPASSWORD}" shutdown

# Wait for the MariaDB service to stop
# while mysqladmin --user=root --password="${MYSQL_ROOTPASSWORD}" ping --silent; do
#     sleep 1
# done
 mysqld


# exec "$@"