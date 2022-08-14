FROM alpine:3.15

# Update package list and upgrade out-dated packages
RUN apk update && apk upgrade && apk add --no-cache \
        wget tar \
        php7 php7-fpm php7-opcache php7-mysqli \
        php7-gd php7-zlib php7-curl php7-iconv \
	php7-mbstring php7-cli php7-json php7-phar \
	php7-common php7-session php7-xml php7-imap php7-cgi \
	fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc \
	php7-posix php7-mcrypt php7-gettext php7-ldap \
	php7-ctype php7-dom php7-simplexml php7-pecl-mailparse \
	mariadb-client

RUN adduser -D -g 'nginx' nginx && \ 
    mkdir -p /scripts
COPY tools/run.sh /scripts/run.sh
COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

EXPOSE 9000
ENTRYPOINT [ "sh", "/scripts/run.sh" ]
