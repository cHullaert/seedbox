#!/bin/bash

OPTIND=1
password="transmission"

while getopts "p:" opt; do
    case "$opt" in
    p)  password=$OPTARG
        ;;
    esac
done

echo login
scw login

echo create server
SERVER=$(scw --region ams1 create --name seedbox --commercial-type=ARM64-2GB xenial)
echo server $SERVER has been created
echo start server
scw --region ams1 start $SERVER
scw --region ams1 exec --wait $SERVER /bin/bash
scw --region ams1 exec --wait $SERVER wget https://raw.githubusercontent.com/cHullaert/seedbox/master/transmission-installer.sh -P /tmp
scw --region ams1 exec --wait $SERVER chmod +x /tmp/transmission-installer.sh
scw --region ams1 exec --wait $SERVER /tmp/transmission-installer.sh $password

echo logout
scw logout

#./transmission.installer.sh