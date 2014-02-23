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

owncloud
--------

1. install on first run

```
sudo ./run-install.sh
```

You will land in a bash shell, there run:

```
/opt/start.sh &
```

Now nginx and php-fpm are started an you can do the initial install of owncloud.
After doing your default configuration leave and commit your setup.

```
sudo docker commit -m="initial configuration done" -run='{"Cmd": ["/opt/start.sh"]}' <containerid> ike/nginx-php-owncloud
```

2. install apps in owncloud

NOTE: every time you install an app you better commit this

```
sudo docker commit -m="installed some app" -run='{"Cmd": ["/opt/start.sh"]}' <containerid> ike/nginx-php-owncloud
```
