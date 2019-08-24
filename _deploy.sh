#!/usr/bin/env bash

ENVIRONMENT=production
NAMESPACE=glanz-production
BASE_NAME=load-balancer


LAST_COMMIT=`git rev-parse --short HEAD`
NGINX_IMAGE=gcr.io/glanz-250816/${NAMESPACE}-${BASE_NAME}:cmt${LAST_COMMIT}

NGINX_IF=./image/nginx-${ENVIRONMENT}.conf
NGINX_OF=./image/nginx-ready.conf
eval "cat ${NGINX_IF} > ${NGINX_OF}"
docker build -t ${NGINX_IMAGE} ./image/
gcloud docker -- push ${NGINX_IMAGE}
rm ${NGINX_OF}

IF=./kube/nginx.yaml
OF=./kube/nginx-ready.yaml
eval "echo \"$(cat ${IF})\" > ${OF}"
kubectl apply --record --namespace=${NAMESPACE} -f ${OF}
rm ${OF}
