# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: nkuipers <nkuipers@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2020/01/16 16:13:10 by nkuipers       #+#    #+#                 #
#    Updated: 2020/01/17 15:06:10 by nkuipers      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

FROM    debian:buster

# Setup and install nginx and other packages
RUN     apt update && \
        apt -y upgrade && \
        apt install -y nginx mariadb-server php7.3-fpm php-mysql php-common php-mbstring php-zip vim unzip wget sendmail sudo

RUN     rm -rf /usr/share/nginx/www

# Initialize Nginx
RUN     mkdir -p /var/www/localhost
COPY    srcs/nginx-host-conf /etc/nginx/sites-available/localhost
RUN     ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled
RUN     mkdir -p /var/www/localhost/index/
COPY    srcs/index.html /var/www/localhost/index/

# Creating the mysql database
RUN     service mysql start; \
        echo "CREATE DATABASE wordpress;" | mysql -u root; \
        echo "GRANT ALL PRIVILEGES ON *.* TO 'nkuipers'@'localhost' IDENTIFIED BY 'password';" | mysql -u root; \
        echo "FLUSH PRIVILEGES" | mysql -u root

# Make folder for ssl
RUN     mkdir ssl-cert
COPY    srcs/46387415_localhost.cert /ssl-cert
COPY    srcs/46387415_localhost.key /ssl-cert

# Downloading the latest version of phpMyAdmin
RUN     wget  -c https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-english.tar.gz && \
        tar -xzvf phpMyAdmin-4.9.4-english.tar.gz && \
        mkdir -p /var/www/localhost/wordpress/phpmyadmin && \
        mv -v phpMyAdmin-4.9.4-english/* /var/www/localhost/wordpress/phpmyadmin && \
        chmod -R 755 /var/www/localhost/wordpress/phpmyadmin && \
        rm phpMyAdmin-4.9.4-english.tar.gz && \
        rm -rf phpMyAdmin-4.9.4-english

# Copying the wordpress configuration to the container
COPY    srcs/config.inc.php /var/www/localhost/wordpress/phpmyadmin
COPY    srcs/php.ini /etc/php/7.3/fpm/php.ini

# Downloading and installing WP-CLI
COPY    srcs/my.cnf /etc/my.cnf
RUN     chmod -R 755 /var/run/mysqld
RUN     wget -c https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp
RUN     wp cli update
RUN     mkdir -p /var/www/localhost/wordpress

# Changing the accessibility of files
RUN		chown -R www-data:www-data /var/www/localhost/* && \
    	chmod -R 755 /var/www/localhost/*

# Setup wordpress page, and change the theme
RUN     service mysql start && \
        wp core download --path=/var/www/localhost/wordpress --allow-root && \
        wp config create --path=/var/www/localhost/wordpress --dbname=wordpress --dbuser=nkuipers --dbpass=password --allow-root && \
        wp core install --path=/var/www/localhost/wordpress --url=localhost --title="nkuipers_ft_server" --admin_name=nkuipers --admin_password=password --admin_email=nkuipers@student.codam.nl --allow-root && \
        chmod 644 /var/www/localhost/wordpress/wp-config.php && \
        wp theme install https://downloads.wordpress.org/theme/shapely.1.2.8.zip --path=/var/www/localhost/wordpress --activate --allow-root

# expose ports for default http, default https, and sendmail, respectively.
EXPOSE 80 443 110

# Commands for starting the container
CMD     service mysql start && \
        service php7.3-fpm start && \
        service nginx start && \
        bash
