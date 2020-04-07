#!/bin/bash

# Install Script for Istio 1.4 up, does not always work

CFG_FILE=local.env
# Check if config file exists
if [ ! -f $CFG_FILE ]; then
     echo "-----------------------------------------------------------------"
     echo "Config file local.env is missing! Need to run ./get-env.sh first!"
     echo "-----------------------------------------------------------------"
     exit 1
fi  
source $CFG_FILE

# Check if istioctl is available. In Cloud Shell it is or should be!
if ! type istioctl; then 
   echo "-----------------------------------------------------------------"
   echo "This script requires the 'istioctl' CLI but it is missing!"
   echo "Check https://istio.io how to install it."
   echo "-----------------------------------------------------------------"
   exit 1  
fi

echo "------------------------------------------------------------------------"
echo "Install Istio demo profile"
echo "------------------------------------------------------------------------"
istioctl manifest apply --set profile=demo
echo "------------------------------------------------------------------------"
echo "Replace telemetry config to expose nodeports"
echo "------------------------------------------------------------------------"
kubectl delete svc grafana -n istio-system
kubectl delete svc kiali -n istio-system
kubectl delete svc prometheus -n istio-system
kubectl delete svc jaeger-query -n istio-system
kubectl apply -f istio-tele-services.yaml
echo "------------------------------------------------------------------------"
echo "Label namespace 'default' for auto injection"
kubectl label namespace default istio-injection=enabled
echo "------------------------------------------------------------------------"
echo "Istio installation complete, check that all pods are ready with:"
echo "    kubectl get pod -n istio-system --watch"
echo "(Terminate with Ctl-c)"
