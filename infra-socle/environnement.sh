#!/bin/bash


export PROXY_DSO=http://${PROXY_SERVICE}/
export NO_PROXY_DSO=${SERVICE_CIDR_SUB},localhost,${LAN_CIDR_SUB}.0.0/16,svc,*.svc.cluster.local,svc.cluter.local

export ROOT_URL=${SUBDOMAIN}.${DOMAIN_NAME}
export SUBDOM_URL=.apps

export KEYCLOAK_URL_PREFIX=keycloak-keycloak-system${SUBDOM_URL}
export GITLAB_URL_PREFIX=gitlab-op${SUBDOM_URL}
export ARGOCD_URL_PREFIX=openshift-gitops-server-gitops-system${SUBDOM_URL}
export PORTAIL_URL_PREFIX=gitlab-op${SUBDOM_URL}
export QUAY_URL_PREFIX=quay${SUBDOM_URL}
export SONAR_URL_PREFIX=sonar-system-ingress${SUBDOM_URL}

export KEYCLOAK_GITLAB_SECRET_KEY=

