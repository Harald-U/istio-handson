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
echo "----------------------------------------------------------------------"
echo "The following URLs work outside the IBM Cloud Shell, too"
echo "----------------------------------------------------------------------"
echo "Access the Web-API in a browser:"
echo "API Explorer   http://$INGRESSIP/openapi/ui"
echo "REST API       http://$INGRESSIP/web-api/v1/getmultiple"
echo "In the commandline:"
echo "curl http://$INGRESSIP/web-api/v1/getmultiple | jq ."
echo "'Exercise' in the commandline (endless loop):"
echo "watch -n 1 curl http://$INGRESSIP/web-api/v1/getmultiple"
echo "----------------------------------------------------------------------"
KIALI_PORT=$(kubectl -n istio-system get service kiali -o jsonpath='{.spec.ports[?(@.name=="http-kiali")].nodePort}')
echo "Kiali:       http://$CLUSTERIP:$KIALI_PORT"
echo "Login with user: admin and password: admin"
echo "----------------------------------------------------------------------"
PROM_PORT=$(kubectl -n istio-system get service prometheus -o jsonpath='{.spec.ports[?(@.name=="http-prometheus")].nodePort}')
echo "Prometheus:  http://$CLUSTERIP:$PROM_PORT"
echo "----------------------------------------------------------------------"
GRAF_PORT=$(kubectl -n istio-system get service grafana -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
echo "Grafana:     http://$CLUSTERIP:$GRAF_PORT"
echo "----------------------------------------------------------------------"
JAEGER_PORT=$(kubectl -n istio-system get service jaeger-query -o jsonpath='{.spec.ports[?(@.name=="query-http")].nodePort}')
echo "Jaeger:      http://$CLUSTERIP:$JAEGER_PORT"
echo "----------------------------------------------------------------------"
echo ""
