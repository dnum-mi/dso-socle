#!/bin/bash

export ROOT_URL=${SUBDOMAIN}.${DOMAIN_NAME}

export GITLAB_URL_PREFIX=gitlab-op.apps
export ARGOCD_URL_PREFIX=openshift-gitops-server-gitops-system.apps
export PORTAIL_URL_PREFIX=gitlab-op.apps
export QUAY_URL_PREFIX=quay.apps
export SONAR_URL_PREFIX=sonar-system-ingress.apps

echo "Install operator group and subscription"
kubectl apply -f operator-group.yaml
kubectl apply -f operator-subscription.yaml

echo "wait a minute"
sleep 60

echo " install keycloak instance"
kubectl apply -f keycloak-instance.yaml


echo "wait a minute"
sleep 60

echo "install client"
cat keycloak-gitlab-client.yaml.tpl | envsubst | kubectl apply -f -
cat keycloak-argo-client.yaml.tpl | envsubst | kubectl apply -f -
cat keycloak-portail-client.yaml.tpl | envsubst | kubectl apply -f -
cat keycloak-quay-client.yaml.tpl | envsubst | kubectl apply -f -
cat keycloak-sonar-client.yaml.tpl | envsubst | kubectl apply -f -
kubectl apply -f keycloak-create-admin-user.yaml
