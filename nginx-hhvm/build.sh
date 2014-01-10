#!/bin/bash
(( EUID != 0 )) && die 'This script must be run as root.'

docker build -t ike/nginx-hhvm .
