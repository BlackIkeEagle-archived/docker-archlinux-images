#!/bin/bash
(( EUID != 0 )) && echo 'This script must be run as root.' && exit 1

if [[ ! -d "/var/lib/ike/docker/percona/mysql" ]]; then
	mkdir -p /var/lib/ike/docker/percona/mysql
fi
docker run -v /var/lib/ike/docker/percona/mysql:/var/lib/mysql -d ike/percona
