#!/bin/sh
#

. ./config

cat kubernetes.yaml \
    | sed "s#/srv/mysql5#$STORAGE_PATH#g" \
    | sed "s#passw0rd#$MYSQL_ROOT_PASSWORD#g" \
    | kubectl apply -f -
