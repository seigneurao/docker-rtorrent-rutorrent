#!/bin/bash
rm /rtorrent/.session/*.lock
/usr/sbin/php-fpm7 -D -R &
nginx -g 'daemon off;' &
rtorrent
