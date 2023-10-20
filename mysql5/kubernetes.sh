#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 安装应用 ####

cat kubernetes.yaml \
    | sed "s#/srv/mysql5#$STORAGE_PATH#g" \
    | sed "s#passw0rd#$MYSQL_ROOT_PASSWORD#g" \
    | kubectl apply -f -
