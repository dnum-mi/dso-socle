#!/bin/bash

export KEYCLOAK_GITLAB_SECRET_KEY=`kubectl get secret keycloak-client-secret-gitlab-client -n keycloak-system -o yaml | yq '.data.CLIENT_SECRET'`
echo "Install operator group and subscription"
kubectl delete -f operator-group.yaml

echo "wait 30 seconds"
#sleep 30
kubectl delete -f gitlab/operator-subscription.yaml
echo "wait a minute"
#sleep 60
kubectl delete secret openid-connect -n gitlab-system

echo "install client"
cat gitlab/gitlab-instance.yaml.tpl | envsubst | kubectl delete -f -

