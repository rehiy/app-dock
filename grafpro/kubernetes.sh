#!/bin/sh
#

#### 导入变量 ####

. ./config

#### 创建配置 ###

mkdir -p $GRAFPRO_STORAGE/etc

cat <<EOF >$GRAFPRO_STORAGE/etc/prometheus.yml
global:
  scrape_interval: 5s
  scrape_timeout: 5s
  evaluation_interval: 15s

scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets:
          - 127.0.0.1:9090
EOF

#### 安装应用 ####

cat kubernetes.yaml \
    | sed "s#/srv/grafpro#$GRAFPRO_STORAGE#g" \
    | sed "s#grafana.example.com#$GRAFANA_DOMAIN#g" \
    | sed "s#prometheus.example.com#$PROMETHEUS_DOMAIN#g" \
    | kubectl apply -f -
