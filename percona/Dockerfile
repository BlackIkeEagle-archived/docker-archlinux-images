FROM ike/archbase
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm percona-server && pacman -Scc --noconfirm
ADD ./start.sh /opt/start.sh

CMD ["/bin/sh", "/opt/start.sh"]
