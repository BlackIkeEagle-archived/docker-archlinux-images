#!/bin/bash
(( EUID != 0 )) && die 'This script must be run as root.'

mysql_folder=/var/lib/ike/docker/nginx-php-owncloud/mysql
owncloud_config_folder=/var/lib/ike/docker/nginx-php-owncloud/config
owncloud_data_folder=/var/lib/ike/docker/nginx-php-owncloud/data
container_ids_folder=/var/lib/ike/docker/nginx-php-owncloud/cntid

# mysql folder
if [[ ! -d "$mysql_folder" ]]; then
	mkdir -p "$mysql_folder"
fi

# config folder
if [[ ! -d "$owncloud_config_folder" ]]; then
	mkdir -p "$owncloud_config_folder"
fi

# data folder
if [[ ! -d "$owncloud_data_folder" ]]; then
	mkdir -p "$owncloud_data_folder"
fi

# running docker containter hashes (like pid :p)
if [[ ! -d "$container_ids_folder" ]]; then
	mkdir -p "$container_ids_folder"
fi

case "$1" in
	'start')
			mysql_container=$(docker run \
				-v $mysql_folder:/var/lib/mysql \
				-d -t ike/percona
			)
			mysql_container_ip=$(docker inspect $mysql_container \
				| grep '"IPAddress":' \
				| sed 's/.*"IPAddress":.*"\([0-9:\.]*\)".*/\1/'
			)

			echo "$mysql_container" > "$container_ids_folder/mysql.cnt"

			owncloud_container=$(docker run \
				-v $owncloud_config_folder:/srv/http/owncloud/config \
				-v $owncloud_data_folder:/srv/http/owncloud/data \
				-p 8000:8000 \
				-d -t ike/nginx-php-owncloud -m $mysql_container_ip)

			echo "$owncloud_container" > "$container_ids_folder/owncloud.cnt"
		;;
	'stop')
		for container in "$container_ids_folder"/*.cnt; do
			docker stop $(cat $container)
			rm $container;
		done
		;;
	'status')
		for container in "$container_ids_folder"/*.cnt; do
			echo "--------------------"
			echo "$container"
			echo "--------------------"
			docker inspect $(cat $container)
			echo ""
		done
		;;
	'restart')
		$0 stop
		sleep 1
		$0 start
		;;
esac

