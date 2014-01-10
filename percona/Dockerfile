FROM ike/archbase
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm percona-server && rm -f /var/cache/pacman/pkg/*
ADD ./start.sh /opt/start.sh

CMD ["/bin/sh", "/opt/start.sh"]
