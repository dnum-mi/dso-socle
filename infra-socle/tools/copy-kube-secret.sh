#!/bin/bash

if [ "$#" !=  3  ];then
	echo "Invalid parameters : input_secret_name input_secret_namespace"
	exit 0
fi

INPUT_SECRET_NAME=$1
INPUT_SECRET_NAMESPACE=$2
OUTPUT_SECRET_NAMESPACE=$3

kubectl get secret $INPUT_SECRET_NAME --namespace=$INPUT_SECRET_NAMESPACE -o yaml |  yq 'del(.metadata.ownerReferences, .metadata.uid, .metadata.resourceVersion, .metadata.namespace, .metadata.creationTimestamp)' | kubectl apply -n $OUTPUT_SECRET_NAMESPACE -f -




