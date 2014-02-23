FROM ike/nginx
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm php-fpm
RUN pacman -Scc --noconfirm
ADD ./default /etc/nginx/sites-available/default
ADD ./index.php /srv/http/index.php
ADD ./php-fpm.ini /etc/supervisor.d/php-fpm.ini

