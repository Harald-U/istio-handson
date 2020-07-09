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
echo " "

