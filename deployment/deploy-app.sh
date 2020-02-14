#!/bin/bash

CFG_FILE=local.env
# Check if config file exists
if [ ! -f $CFG_FILE ]; then
     echo "-----------------------------------------------------------------"
     echo "Config file local.env is missing! Need to run ./get-env.sh first!"
     echo "-----------------------------------------------------------------"
     exit 1
fi  
source $CFG_FILE

echo "Deploy articles service:"
kubectl apply -f articles.yaml

echo "Deploy authors service:"
kubectl apply -f authors.yaml

echo "Deploy web-api service (v1 and v2):"
kubectl apply -f web-api.yaml

echo "Deploy initial Istio config:"
kubectl apply -f istio-ingress.yaml

echo "-------------------------------------------------------------------------"
echo "Run 'kubectl get pod' to display the status of the deployed pods"
echo "Run './show-urls.sh' to display the addresses (URLs) for your environment"