FROM ike/nginx-php
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm php-gd php-mcrypt php-sqlite php-apcu
RUN pacman -Scc --noconfirm
ADD ./enable_extensions.sh /tmp/enable_extensions.sh
RUN /bin/sh /tmp/enable_extensions.sh && rm /tmp/enable_extensions.sh
ADD ./apcu.ini /etc/php/conf.d/apcu.ini
RUN cd /srv/http/ && curl -o owncloud.tar.bz2 http://download.owncloud.org/community/owncloud-6.0.1.tar.bz2 && tar -jxf owncloud.tar.bz2
RUN rm /srv/http/owncloud.tar.bz2
RUN chown -R http:http /srv/http
ADD ./owncloud /etc/nginx/sites-available/owncloud
RUN rm /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/owncloud /etc/nginx/sites-enabled/default
ADD ./start.sh /opt/start.sh
RUN chmod +x /opt/start.sh
