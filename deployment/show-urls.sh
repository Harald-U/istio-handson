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

echo ""
echo "-----------------------------------------------------------------------------"
echo "The following URLs work outside the IBM Cloud Shell, too"
echo "-----------------------------------------------------------------------------"
echo "Access the Web-API in a browser:"
echo "API Explorer   http://$CLUSTERIP:$INGRESSNP/openapi/ui"
echo "REST API       http://$CLUSTERIP:$INGRESSNP/web-api/v1/getmultiple"
echo "In the commandline:"
echo "curl http://$CLUSTERIP:$INGRESSNP/web-api/v1/getmultiple | jq ."
echo "'Exercise' in the commandline (endless loop):"
echo "watch -n 1 curl http://$CLUSTERIP:$INGRESSNP/web-api/v1/getmultiple"
echo "-----------------------------------------------------------------------------"
echo " "
echo "For the different telemetry services:"
echo " 1. Issue the specific 'kubectl port-forward' command" 
echo "    in a second Cloud Shell session" 
echo " 2. Then do a "port preview" (eye icon, upper right corner of Cloud Shell)"
echo "    on port 3000."
echo " "
echo "-----------------------------------------------------------------------------"
echo "Kiali:       kubectl port-forward svc/kiali 3000:20001 -n istio-system"
echo "             ->  Login with user: admin and password: admin"
echo "-----------------------------------------------------------------------------"
echo "Prometheus:  kubectl port-forward svc/prometheus 3000:9090 -n istio-system"
echo "-----------------------------------------------------------------------------"
echo "Grafana:     kubectl port-forward svc/grafana 3000:3000 -n istio-system"
echo "-----------------------------------------------------------------------------"
echo "Jaeger:      kubectl port-forward svc/jaeger-query 3000:16686 -n istio-system"
echo "-----------------------------------------------------------------------------"
echo ""
