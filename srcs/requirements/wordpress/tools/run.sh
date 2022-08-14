#!/bin/sh

# wait for db
chown -R nginx:nginx .
while ! mariadb -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD &>/dev/null; do
	echo "waiting for $WORDPRESS_DB_HOST ..."
	sleep 2
done

if [ ! -f "/var/www/html/wordpress/index.php" ]; then
	su nginx -c sh -c ' \
	wp core download && \
	wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --dbcharset="utf8" && \
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email && \
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD && \
	wp theme install blocksy --activate && \
	wp plugin update --all'
fi

exec php-fpm7 -F
