#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 安装应用 ####

cat kubernetes.yaml \
    | sed "s#/srv/myblog#$TYPECHO_STORAGE#g" \
    | sed "s#blog.example.com#$TYPECHO_DOMAIN#g" \
    | kubectl apply -f -
