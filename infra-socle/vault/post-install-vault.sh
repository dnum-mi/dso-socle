#!/bin/bash

export ROOT_URL=${SUBDOMAIN}.${DOMAIN_NAME}

export VAULT_URL_PREFIX=vault-ui-ingress-system.apps

cat vault-cluster-issuer.yaml.tpl | envsubst | kubectl apply -f -
cat vault-ingress.yaml.tpl | envsubst | kubectl apply -f -

