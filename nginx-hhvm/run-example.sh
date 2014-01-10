#!/bin/bash
(( EUID != 0 )) && die 'This script must be run as root.'

docker run -d -name nginx-hhvm ike/nginx-hhvm
