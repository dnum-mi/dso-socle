#!/bin/bash

export ROOT_URL=${SUBDOMAIN}.${DOMAIN_NAME}

export SONAR_URL_PREFIX=sonar-system-ingress.apps

oc create namespace nexus-system > /dev/null

oc create sa nexus-sa -n nexus-system

oc policy add-role-to-user edit system:serviceaccount:nexus-system:nexus-sa

oc adm policy add-scc-to-user allow-nexus-userid-200 -z nexus-sa

echo "install sonar"
cat nexus.yml.tpl | envsubst | kubectl apply -f -

