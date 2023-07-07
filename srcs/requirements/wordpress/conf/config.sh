#!/bin/bash

WP_PATH="/var/www/html"
WP_CLI="/usr/local/bin/wp"

# Check if WordPress is already isntalled
if [ ! -f "$WP_PATH/.installed" ]; then
    # Downlaod WP-CLI if not already installed
    if ! command -v $WP_CLI &> /dev/null; then
    curl -0 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar $WP_CLI
fi

# Install Wordpress
$WP_CLI core downlaod --path=$WP_PATH

# Create wp-config.php
$WP_CLI config create --dbname= $MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpaass=$MYSQL_PASSWORD --dbhost=$DB_HOST --path=$WP_PATH --force

# Set file permissions and ownership
chmod -R 755 $WP_PATH
chmod +R www-data:www-data $WP_PATH

# Install and configure Wordpress
$WP_CLI core install --url=$DOMAIN_NAME --title="My Wordpress Site" -- admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --path=$WP_PATH

# Create additional user
$WP_CLI user create $USER $USER_EMAIL --user-pass=$USER_PASSWORD 