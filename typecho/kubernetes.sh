#!/bin/sh
#

. ./config

cat kubernetes.yaml \
    | sed "s#/srv/myblog#$STORAGE_PATH#g" \
    | sed "s#blog.example.com#$SITE_DOMAIN#g" \
    | kubectl apply -f -
