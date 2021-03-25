#!/bin/bash

CFG_FILE=local.env
# Check if config file exists
if [ ! -f $CFG_FILE ]; then
     echo "-----------------------------------------------------------------"
     echo "Config file local.env is missing! Need to run ./get-env.sh first!"
     echo "-----------------------------------------------------------------"
     exit 1
fi  

# Get Istio Ingress External IP
INGRESSPORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
echo "Istio Ingress NodePort: $INGRESSPORT"
echo "INGRESSNP=$INGRESSPORT" >> local.env

source $CFG_FILE

echo "------------------------------------------------------------------------"
echo "Label namespace 'default' for auto injection"
kubectl label namespace default istio-injection=enabled
echo "------------------------------------------------------------------------"
echo ""
echo "Execute 'source local.env' to update the environment"
echo ""

