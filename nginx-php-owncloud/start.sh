#!/bin/sh

if [[ -e /srv/http/owncloud/config/config.php ]]; then
	if [[ "$DB_PORT_3306_TCP_ADDR" != "" ]]; then
		sed "s/\('dbhost' => \).*/\1 '$DB_PORT_3306_TCP_ADDR',/" -i /srv/http/owncloud/config/config.php
	fi

	if [[ "$DB_USER" != "" ]]; then
		sed "s/\('dbuser' => \).*/\1 '$DB_USER',/" -i /srv/http/owncloud/config/config.php
	fi

	if [[ "$DB_PASS" != "" ]]; then
		sed "s/\('dbpassword' => \).*/\1 '$DB_PASS',/" -i /srv/http/owncloud/config/config.php
	fi
fi

/usr/bin/supervisord

