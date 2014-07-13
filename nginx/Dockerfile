FROM archlinux
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm nginx
RUN pacman -Scc --noconfirm
RUN mkdir -p /etc/nginx/conf.d
RUN mkdir -p /etc/nginx/sites-available
RUN mkdir -p /etc/nginx/sites-enabled
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
ADD ./nginx.ini /etc/supervisor.d/nginx.ini

EXPOSE 80

VOLUME ["/etc/nginx", "/srv/http", "/var/log/supervisor"]

CMD ["/usr/bin/supervisord"]
