#!/bin/bash

# This line specifies the interpreter for the script, indicating that it should be
# executed using the Bash shell

# These lines defines two variables: `WP_PATH` specifies the path where Wordpress will be 
# installed ('/var/www/html' in our case), and `WP_CLI` specifies the path to the `wp` command
# (assuming it's installed at '/usr/local/bin/wp') 
WP_PATH="/var/www/html"
WP_CLI="/usr/local/bin/wp"


# Check if WordPress is already isntalled
# This block of code checks if the `wp` command (specified by the `WP_CLI` variable)
# is installed. If the command is not found, it downloads the WP-CLI tool from the official
# repo, sets the necessary permessions, and moves it to the specified path
if [ ! -f "$WP_PATH/.installed" ]; then
    # Downlaod WP-CLI if not already installed
    if ! command -v $WP_CLI &> /dev/null; then
    curl -0 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar $WP_CLI
fi



# Install Wordpress
# This line uses the `wp` command to download the latest version of WordPress to the specified
# path `($WP_PATH)`
$WP_CLI core download --path=$WP_PATH


# Create wp-config.php
# This line uses the `wp` command to create the `wp-config.php` file with the provided
# database credentials ($MYSQL_DATABASE, $MYSQL_USER, $MYSQL_PASSWORD, $DB_HOST) and other
# configuration options. The `--force` flag forces overwriting the existing `wp-config.php`
# file if it already exists
$WP_CLI config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST --path=$WP_PATH --force

# Modify wp-config.php with database configuration
sed -i -r "s/database_name_here/$MYSQL_DATABASE/1" $WP_PATH/wp-config.php
sed -i -r "s/username_here/$MYSQL_USER/1" $WP_PATH/wp-config.php
sed -i -r "s/password_here/$MYSQL_PASSWORD/1" $WP_PATH/wp-config.php
sed -i -r "s/localhost/$DB_HOST/1" $WP_PATH/wp-config.php

# Set file permissions and ownership
# These lines set the file permissions (`chmod`) and ownership (`chown`) of the Wordpress
# installation directory (`$WP_PATH`). The permessions are set o `755`, allowing the owner
# to read, write, and execute, and others to read and execute. The ownership is set to the
# `www-data` user and group, which is commonly used by web servers.
chmod -R 755 $WP_PATH
chmod +R www-data:www-data $WP_PATH


# Install and configure Wordpress
# This line uses the `wp` command to install WordPress with the specified options: the site
# URL (`$DOMAIN_NAME`), site title, admin usename, password and email address
# The `--path` flag specifies the path to the WordPress installation directory
$WP_CLI core install --url=$DOMAIN_NAME --title="My Wordpress Site" -- admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --path=$WP_PATH

# Create additional user
# This line uses the `wp` command to create a new user in WordPress
# with the specified username(`$User`).. and so on 
$WP_CLI user create $USER $USER_EMAIL --user-pass=$USER_PASSWORD --role='author' --path=$WP_PATH

# Set wp_cache constant
# This line uses the `wp` command to set the `WP_CACHE` constant in the WordPress configuration
# to `true`. The `--raw` flag ensures that the value is treated as a raw string. The `--path`
# flag specifies the path to the WordPress installation directory
$WP_CLI config set WP_CACHE 'true' --raw --path=$WP_PATH

# Create .installed file
# This line create the `.installed` file in the WordPress installation directory (`$WP_PATH`)
# This file serves as an indicator that the installation has been completed
touch $WP_PATH/.installed
fi

exec "$@"