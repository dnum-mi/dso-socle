#!/bin/bash

SERVICE_NAME=$(basename $(pwd ) )

echo "uninstall ${SERVICE_NAME}"
kubectl delete -f k8s.yaml
