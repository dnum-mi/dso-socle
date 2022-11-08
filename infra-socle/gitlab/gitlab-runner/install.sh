#!/bin/bash

export GITLAB_REGISTRATION_TOKEN=${GITLAB_REGISTRATION_TOKEN}

kubectl apply -f operator-subscription.yaml

echo "wait for one minute"
#sleep 20

kubectl apply -f custom-env.yaml
kubectl apply -f gitlab-runner-auth.yaml


cat gitlab-runner-secret.yaml.tpl | envsubst | kubectl apply -f -
cat gitlab-runner-instance.yaml.tpl | envsubst | kubectl apply -f -

oc adm policy add-scc-to-user anyuid -z gitlab-runner-sa -n gitlab-system

