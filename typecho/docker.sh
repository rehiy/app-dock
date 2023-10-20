#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 安装应用 ####

docker run -d --name typecho \
  -p $HTTP_PORT:80 \
  -p $HTTPS_PORT:443 \
  -v $TYPECHO_STORAGE/usr:/var/www/default/usr \
  rehiy/typecho
