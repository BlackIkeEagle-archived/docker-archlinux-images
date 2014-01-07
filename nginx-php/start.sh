#!/bin/sh

/usr/bin/php-fpm --daemonize --pid /run/php-fpm/php-fpm.pid

/usr/bin/nginx -g 'pid /run/nginx.pid; daemon off; master_process on;'
