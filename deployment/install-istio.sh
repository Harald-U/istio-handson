#!/bin/bash

# Install Script for Istio 1.3

CFG_FILE=local.env
# Check if config file exists
if [ ! -f $CFG_FILE ]; then
     echo "-----------------------------------------------------------------"
     echo "Config file local.env is missing! Need to run ./get-env.sh first!"
     echo "-----------------------------------------------------------------"
     exit 1
fi  
source $CFG_FILE

echo "Install Istio CRDs"
echo "------------------------------------------------------------------------"
kubectl apply -f istio-demo-crds.yaml
echo "------------------------------------------------------------------------"
echo "Wait 10 seconds"
echo "------------------------------------------------------------------------"
sleep 10
echo "Install Istio deployment"
echo "------------------------------------------------------------------------"
kubectl apply -f istio-demo-deployment.yaml
echo "------------------------------------------------------------------------"
echo "Label namespace 'default' for auto injection"
kubectl label namespace default istio-injection=enabled
echo "------------------------------------------------------------------------"
echo "Istio installation complete, check that all pods are ready with:"
echo "    kubectl get pod -n istio-system --watch"
echo "(Terminate with Ctl-c)"