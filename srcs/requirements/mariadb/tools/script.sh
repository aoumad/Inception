#!/bin/bash

sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start


mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"

mysql -e "FLUSH PRIVILEGES;"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASSWORD}';"

mysql -u root -p${DB_ROOTPASSWORD} -e "FLUSH PRIVILEGES;"

mysqladmin --user=root --password="${DB_ROOTPASSWORD}" shutdown

mysqld_safe