#!/bin/bash

set -a
SERVICE_NAME=$(basename $(pwd ) )
ROOT_URL=$(kubectl cluster-info |sed -rn 's#^.*https://api.(.*):6443.*$#\1#p' )
ID_ENV=$(echo ${ROOT_URL} |sed -rn 's#^ocp4-([0-9]+)\..*$#\1#p' )

CLIENT_SECRET=$(kubectl get secret --namespace keycloak-system keycloak-client-secret-quay-client -o jsonpath="{.data.CLIENT_SECRET}" |base64 -d )
CONFIG_YAML=$(cat config.yaml.tpl |envsubst |base64 -w 0 )

set +a

echo "install ${SERVICE_NAME}"
cat service.yml.tpl |envsubst >k8s.yaml
kubectl apply -f k8s.yaml
