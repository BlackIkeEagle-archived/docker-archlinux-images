FROM ike/nginx
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm php-fpm && rm -f /var/cache/pacman/pkg/*
ADD ./default /etc/nginx/sites-available/default
ADD ./index.php /srv/http/index.php
ADD ./start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
