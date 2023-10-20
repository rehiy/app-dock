#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 安装应用 ####

cat kubernetes.yaml \
    | sed "s#/srv/myblog#$STORAGE_PATH#g" \
    | sed "s#blog.example.com#$SITE_DOMAIN#g" \
    | kubectl apply -f -
