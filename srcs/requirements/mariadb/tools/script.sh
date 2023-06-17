# #!/bin/bash

# # Start the MySQL service
# /etc/init.d/mysql start

# # Wait for MySQL service to be fully up and running
# while ! mysqladmin ping -h localhost --silent; do
#     sleep 1
# done

# # Change the bind address to accept connections from any IP address
# mysql -e "SET GLOBAL bind_address = '0.0.0.0'"

# # Create the database if it doesn't exist
# mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"


# # Stop the MySQL service
# /etc/init.d/mysql stop

# # Execute the command provided as arguments
# exec "$@"

# ------------------------------------------------- #

#!/bin/bash

# Initialize MariaDB data directory
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start the MariaDB service in the background
mysqld --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
pid="$!"

# Wait for the MariaDB service to start
while ! mysqladmin ping --silent; do
    sleep 1
done

# Set the root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOTPASSWORD}'"

# Create the database if it doesn't exist
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"

# Create the user if it doesn't exist
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'"

# Grant all privileges on the database to the user
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%'"

# Flush privileges
mysql -e "FLUSH PRIVILEGES"

# Stop the MariaDB service
mysqladmin --user=root --password="${MYSQL_ROOTPASSWORD}" shutdown

# Wait for the MariaDB service to stop
while mysqladmin --user=root --password="${MYSQL_ROOTPASSWORD}" ping --silent; do
    sleep 1
done