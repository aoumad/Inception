#!/bin/bash

    sleep 5

	mkdir -p /run/php/;
    # touch -p /usr/local/bin/wp;
    touch /usr/local/bin/wp;
	touch /run/php/php7.4-fpm.pid; #Store PID files for PHP processes managed by the PHP-FPM
	sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" "/etc/php/7.4/fpm/pool.d/www.conf"

    # mkdir -p /var/www/html
    WP_PATH="/var/www/html"
    WP_CLI="/usr/local/bin/wp"

if [ ! -f "$WP_PATH/.installed" ]; then
    # Download WP-CLI if not already installed
    if ! command -v $WP_CLI &> /dev/null; then
        wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        chmod +x wp-cli.phar
        mv wp-cli.phar $WP_CLI
    fi

 # set up wordpress using wp-cli

    cd $WP_PATH
    $WP_CLI core download --allow-root # Download the WordPress core files

    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php # Create a wp-config.php file
    sed -i "s/database_name_here/${DB_NAME}/g" "/var/www/html/wp-config.php"
    sed -i "s/username_here/${DB_USER}/g" "/var/www/html/wp-config.php"
    sed -i "s/password_here/${DB_ROOTPASSWORD}/g" "/var/www/html/wp-config.php"
    sed -i "s/localhost/${DB_HOST}/g" "/var/www/html/wp-config.php"

    chmod -R 755 $WP_PATH
    chown -R www-data:www-data $WP_PATH  # Fix the invalid chmod command

    $WP_CLI core install --allow-root --url=$DOMAIN_NAME --title="My Wordpress Site" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --path=$WP_PATH

    $WP_CLI user create --allow-root $USER $USER_EMAIL --user_pass=$USER_PASSWORD --role='author' --path=$WP_PATH

    touch $WP_PATH/.installed
fi
/usr/sbin/php-fpm7.4 --nodaemonize
# exec "$@"