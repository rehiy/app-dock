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

docker run -d --name grafana \
  -p 3000:3000 \
  -v $GRAFPRO_STORAGE/grafana:/var/lib/grafana \
  grafana/grafana

docker run -d --name prometheus \
  -p 9090:9090 \
  -v $GRAFPRO_STORAGE/etc:/etc/prometheus \
  -v $GRAFPRO_STORAGE/prometheus:/prometheus \
  prom/prometheus
