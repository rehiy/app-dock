#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 安装应用 ####

docker run -d --name mysql5 \
  -p $MYSQL_PORT:3306 \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -v $MYSQL_STORAGE/etc:/etc/mysql/conf.d \
  -v $MYSQL_STORAGE/data:/var/lib/mysql \
  -v $MYSQL_STORAGE/log:/var/log/mysql \
  mysql:5
