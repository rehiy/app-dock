#!/bin/sh
#

. ./config

docker run -d --name typecho \
  -p $HTTP_PORT:80 \
  -p $HTTPS_PORT:443 \
  -v $STORAGE_PATH/usr:/var/www/default/usr \
  rehiy/typecho
