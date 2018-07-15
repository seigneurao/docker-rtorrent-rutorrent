FROM alpine:latest
USER root
RUN apk add --update rtorrent git nginx php7 php7-fpm php7-json curl unrar ffmpeg mediainfo bash sox && \
    mkdir -p ~/torrent/session && \
    mkdir -p /run/nginx && \
    mkdir -p /var/www && cd /var/www && \
    git clone https://github.com/Novik/ruTorrent.git rutorrent && \
    rm -rf ./rutorrent/.git* && \
    sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = root|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|;listen.group\s*=\s*nobody|listen.group = root|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|user\s*=\s*nobody|user = root|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|group\s*=\s*nobody|group = root|g" /etc/php7/php-fpm.d/www.conf
RUN chmod 775 -R /var/www
COPY ./rtorrent.rc /root/.rtorrent.rc
COPY ./config.php /var/www/rutorrent/conf/config.php
COPY ./htpasswd /etc/nginx/.htpasswd
COPY ./rutorrent.nginx /etc/nginx/conf.d/default.conf
COPY ./startup.sh /root/startup.sh
