FROM ike/nginx
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN sed -e '/\[core\]/ i[herecura-stable]' -e '/\[core\]/ iServer = http://repo.herecura.eu/$repo/$arch' -e '/\[core\]/ i\ ' -i /etc/pacman.conf
RUN pacman -Syu --noconfirm hhvm && rm -f /var/cache/pacman/pkg/*
ADD ./default /etc/nginx/sites-available/default
ADD ./index.php /srv/http/index.php
ADD ./start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
