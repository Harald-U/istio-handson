#!/bin/bash

source local.env

echo ""
echo "----------------------------------------------------------------------"
INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
echo "Access the API Explorer for web-api through the Istio Ingress Gateway:"
echo "http://$CLUSTERIP:$INGRESS_PORT/openapi/ui in your browser"
echo "In the commandline enter:"
echo "curl http://$CLUSTERIP:$INGRESS_PORT/web-api/v1/getmultiple | jq ."
echo "----------------------------------------------------------------------"
KIALI_PORT=$(kubectl -n istio-system get service kiali -o jsonpath='{.spec.ports[?(@.name=="http-kiali")].nodePort}')
echo "Access Kiali:       http://$CLUSTERIP:$KIALI_PORT"
echo "Login with user: admin and password: admin"
echo "----------------------------------------------------------------------"
PROM_PORT=$(kubectl -n istio-system get service prometheus -o jsonpath='{.spec.ports[?(@.name=="http-prometheus")].nodePort}')
echo "Access Prometheus:  http://$CLUSTERIP:$PROM_PORT"
echo "----------------------------------------------------------------------"
GRAF_PORT=$(kubectl -n istio-system get service grafana -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
echo "Access Grafana:     http://$CLUSTERIP:$GRAF_PORT"
echo "----------------------------------------------------------------------"
JAEGER_PORT=$(kubectl -n istio-system get service jaeger-query -o jsonpath='{.spec.ports[?(@.name=="query-http")].nodePort}')
echo "Access Jaeger:      http://$CLUSTERIP:$JAEGER_PORT"
echo "----------------------------------------------------------------------"
echo ""
