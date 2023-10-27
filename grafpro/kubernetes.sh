#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 安装应用 ####

cat kubernetes.yaml \
    | sed "s#/srv/grafpro#$GRAFPRO_STORAGE#g" \
    | sed "s#grafana.example.com#$GRAFANA_DOMAIN#g" \
    | sed "s#prometheus.example.com#$PROMETHEUS_DOMAIN#g" \
    | kubectl apply -f -
