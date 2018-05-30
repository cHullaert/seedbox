#!/bin/bash

OPTIND=1
password="transmission"

while getopts "p:" opt; do
    case "$opt" in
    p)  password=$OPTARG
        ;;
    esac
done

echo "password used: $password"

shift $((OPTIND-1))

echo "launch system update"
apt update -y
#apt upgrade -y

echo "install server"
apt install transmission-daemon -y
apt install nginx -y

echo "stop services"
service transmission-daemon stop
service nginx stop

echo "download configurations"
wget -q https://raw.githubusercontent.com/cHullaert/seedbox/master/settings.json -O /etc/transmission-daemon/settings.json
wget -q https://raw.githubusercontent.com/cHullaert/seedbox/master/default -O /etc/nginx/sites-available/default

sed -i -e "s/\${PASSWORD}/$password/g" /etc/transmission-daemon/settings.json

echo "start service"
service transmission-daemon start
service nginx start
