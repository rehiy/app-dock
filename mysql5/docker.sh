#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 安装应用 ####

docker run -d --name mysql5 \
  -p $MYSQL_PORT:3306 \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -v $STORAGE_PATH/etc:/etc/mysql/conf.d \
  -v $STORAGE_PATH/data:/var/lib/mysql \
  -v $STORAGE_PATH/log:/var/log/mysql \
  mysql:5.7
