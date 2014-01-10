FROM ike/archbase
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN sed -e '/\[core\]/ i[herecura-stable]' -e '/\[core\]/ iServer = http://repo.herecura.eu/$repo/$arch' -e '/\[core\]/ i\ ' -i /etc/pacman.conf
RUN pacman -Syu --noconfirm nginx hhvm && rm -f /var/cache/pacman/pkg/*
RUN mkdir -p /etc/nginx/conf.d
RUN mkdir -p /etc/nginx/sites-available
RUN mkdir -p /etc/nginx/sites-enabled
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
ADD ./index.php /srv/http/index.php
ADD ./start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
