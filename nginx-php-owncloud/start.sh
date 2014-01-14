#!/bin/sh

# option defaults
mysql_ip=''

# process options
while getopts ":m:" arg; do
	case "$arg" in
		m) mysql_ip=$OPTARG ;;
		:) "Option -$OPTARG requires an argument."
	esac
done

if [[ "$mysql_ip" != "" ]]; then
	sed "s/\('dbhost' => \).*/\1 '$mysql_ip',/" -i /srv/http/owncloud/config/config.php
fi

chown http:http -R /srv/http/owncloud

/usr/bin/php-fpm --daemonize --pid /run/php-fpm/php-fpm.pid

/usr/bin/nginx -g 'pid /run/nginx.pid; daemon off; master_process on;'
