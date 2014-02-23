#!/bin/bash
(( EUID != 0 )) && die 'This script must be run as root.'

while getopts ":u:p:c:d:" opt; do
	case $opt in
		u)
			db_user="$OPTARG"
			;;
		p)
			db_pass="$OPTARG"
			;;
		c)
			mysql_container_name="$OPTARG"
			;;
		d)
			owncloud_data_folder="$OPTARG"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
		:)
			echo "Option -$OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done

if [[ -z $db_user ]] || [[ -z $db_pass ]] || [[ -z $mysql_container_name ]] || [[ -z $owncloud_data_folder ]]; then
	echo "please pass -u <db_user> -p <db_pass> -c <mysql_container_name> -d <owncloud_data_folder>" >&2
	exit 1
fi

# data folder
if [[ ! -d "$owncloud_data_folder" ]]; then
	mkdir -p "$owncloud_data_folder"
fi
chown -R 33:33 "$owncloud_data_folder"

docker run \
	-e "DB_USER=$db_user" \
	-e "DB_PASS=$db_pass" \
	-link ${mysql_container_name}:db \
	-v $owncloud_data_folder:/srv/http/owncloud/data \
	-p 80:80 \
	-i -t ike/nginx-php-owncloud /bin/bash
