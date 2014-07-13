FROM archlinux
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm percona-server
RUN pacman -Scc --noconfirm
ADD ./percona.ini /etc/supervisor.d/percona.ini
ADD ./create-mysql-structure.sh /opt/create-mysql-structure.sh
RUN chmod +x /opt/create-mysql-structure.sh
RUN /opt/create-mysql-structure.sh

EXPOSE 3306

VOLUME ["/etc/mysql", "/var/lib/mysql", "/var/log/supervisor"]

CMD ["/usr/bin/supervisord"]
