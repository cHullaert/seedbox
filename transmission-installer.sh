#!/bin/bash

OPTIND=1
password="transmission"

while getopts "p:" opt; do
    case "$opt" in
    p)  password=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

apt update -y
apt upgrade -y
apt install transmission-daemon -y
service transmission-daemon stop

service transmission-daemon start

apt install nginx -y

service nginx restart
