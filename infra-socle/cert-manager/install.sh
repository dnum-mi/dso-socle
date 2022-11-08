#!/bin/bash

export PROXY_DSO=http://${PROXY_SERVICE}/
export NO_PROXY_DSO=${SERVICE_CIDR_SUB},localhost,${LAN_CIDR_SUB}.0.0/16,*.${SUBDOMAIN}.${DOMAIN_NAME},*.apps.${SUBDOMAIN}.${DOMAIN_NAME}

cat cert-manager.yaml.tpl | envsubst | kubectl apply -f -

