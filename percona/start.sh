#!/bin/sh

if [[ ! -e "/var/lib/mysql/.installed" ]]; then
	/usr/bin/mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

	su - mysql -s /bin/bash -c '/usr/bin/mysqld --pid-file=/run/mysqld/mysqld.pid --bind-address=0.0.0.0 --skip-name-resolve --datadir=/var/lib/mysql' &
	sleep 5
	mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
	sleep 1
	killall mysqld
	sleep 5
	touch /var/lib/mysql/.installed
fi

su - mysql -s /bin/bash -c '/usr/bin/mysqld --pid-file=/run/mysqld/mysqld.pid --bind-address=0.0.0.0 --skip-name-resolve --datadir=/var/lib/mysql'
