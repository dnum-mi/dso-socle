#!/bin/bash

if [ "$#" !=  3  ];then
	echo "Invalid parameters : INGRESS_NAME INGRESS_NAMESPACE INGRESS_HOSTNAME"
	exit 0
fi

INGRESS_NAME=$1
INGRESS_NAMESPACE=$2
INGRESS_HOSTNAME=$3

#envsubst < generate-ingress-tmpl.yml

eval "echo \"$(cat generate-ingress-tmpl.yml)\"" > output/ingress-${INGRESS_NAME}.yaml

