#!/bin/bash


echo "Install "
oc create sa ldap-sa -n openshift-operators
oc adm policy add-scc-to-user anyuid -z gitlab-runner-sa -n openshift-operators
kubectl apply -f ldap-pv-claim.yaml
kubectl apply -f ldap-deployement.yaml

