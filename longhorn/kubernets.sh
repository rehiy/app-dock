#!/bin/sh
#

. ./config

# 安装环境

kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.5.1/deploy/prerequisite/longhorn-iscsi-installation.yaml
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.5.1/deploy/prerequisite/longhorn-nfs-installation.yaml

kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.5.1/deploy/longhorn.yaml

# 配置面板

export LONGHORN_SECRET=`echo $LONGHORN_USERNAME:$(echo $LONGHORN_PASSWORD | openssl passwd -stdin -apr1) | base64`

cat <<EOF | kubectl apply -f -
kind: Secret
apiVersion: v1
metadata:
  name: basic-auth
  namespace: longhorn-system
data:
  auth: $LONGHORN_SECRET
---
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: longhorn-basic-auth
  namespace: longhorn-system
spec:
  basicAuth:
    secret: basic-auth
---
kind: IngressRoute
apiVersion: traefik.containo.us/v1alpha1
metadata:
  name: longhorn-dashboard
  namespace: longhorn-system
spec:
  entryPoints:
    - websecure
  routes:
    - kind: Rule
      match: Host(\`$LONGHORN_DOMAIN\`)
      middlewares:
        - name: longhorn-basic-auth
      services:
        - kind: Service
          name: longhorn-frontend
          namespace: longhorn-system
          port: 80
  tls:
    certResolver: default
EOF
