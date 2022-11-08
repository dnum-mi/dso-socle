#!/bin/bash
export ROOT_URL=${SUBDOMAIN}.${DOMAIN_NAME}
export SONAR_URL_PREFIX=sonar-system-ingress.apps

kubectl apply -f create-namespace-sonar.yaml
./secrets.sh
kubectl apply -f postgres-pv-claim.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml
kubectl apply -f sonar-pv-claim.yaml
cat sonar-cluster-issuer.yaml.tpl | envsubst | kubectl apply -f -
kubectl apply -f sonar-deployment.yaml
kubectl apply -f sonar-service.yaml
cat sonar-ingress.yaml.tpl | envsubst | kubectl apply -f -

