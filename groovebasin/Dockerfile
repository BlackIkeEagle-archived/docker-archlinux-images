FROM archlinux
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN sed -e '/\[core\]/ i[herecura-stable]' -e '/\[core\]/ iServer = http://repo.herecura.eu/$repo/$arch' -e '/\[core\]/ i\ ' -i /etc/pacman.conf
RUN pacman -Syu --noconfirm nodejs-groovebasin
RUN pacman -Scc --noconfirm
RUN groupadd -g 20001 groovebasin
RUN useradd -c 'groovebasin user' -u 20001 -g groovebasin -d /home/groovebasin -s /usr/sbin/nologin -m groovebasin
ADD ./groovebasin.ini /etc/supervisor.d/groovebasin.ini

VOLUME ["/music", "/var/log/supervisor"]

EXPOSE 16242 6600

CMD ["/usr/bin/supervisord"]
