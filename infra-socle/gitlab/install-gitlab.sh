#!/bin/bash

export KEYCLOAK_GITLAB_SECRET_KEY=`kubectl get secret keycloak-client-secret-gitlab-client -n keycloak-system -o yaml | yq '.data.CLIENT_SECRET' | base64 -d`
echo "Install operator group and subscription"
kubectl apply -f operator-group.yaml

echo "wait 30 seconds"
#sleep 30
kubectl apply -f gitlab/operator-subscription.yaml
echo "wait a minute"
#sleep 60
cat gitlab/provider.yaml.tpl | envsubst > gitlab/provider.yaml
kubectl delete secret openid-connect -n gitlab-system
kubectl create secret generic -n gitlab-system openid-connect --from-file=provider=gitlab/provider.yaml

echo "install client"
cat gitlab/gitlab-instance.yaml.tpl | envsubst > gitlab/gitlab-instance-generated.yaml

kubectl apply -f gitlab/gitlab-instance-generated.yaml

