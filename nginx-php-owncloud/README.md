owncloud nginx php
=================

mysql
-----

create database:

```
CREATE DATABASE owncloud DEFAULT CHARSET utf8;
```

add owncloud user:

```
CREATE USER 'owncloud'@'%' IDENTIFIED BY 'owncloud'; GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;
```

nginx
-----

WARNING: nginx is configured on port 8000 for this

owncloud
--------

NOTE: every time you install an app you better commit this

```
sudo docker commit -m="installed some app" -run='{"Entrypoint": ["/opt/start.sh"]}' <containerid> ike/nginx-php-owncloud
```
