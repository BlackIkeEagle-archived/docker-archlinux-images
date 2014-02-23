FROM archlinux
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm percona-server
RUN pacman -Scc --noconfirm
ADD ./percona.ini /etc/supervisor.d/percona.ini
ADD ./start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

EXPOSE 3306

CMD ["/opt/start.sh"]
