FROM archlinux
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm percona-server && rm -f /var/cache/pacman/pkg/*
ADD ./start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
