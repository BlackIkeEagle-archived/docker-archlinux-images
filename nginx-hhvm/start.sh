#!/bin/sh

(cd /srv/http && /usr/bin/hhvm --user http --mode daemon -vServer.Type=fastcgi -vServer.Port=9000)

/usr/bin/nginx -g 'pid /run/nginx.pid; daemon off; master_process on;'
