#!/bin/bash

source local.env

echo ""
echo "-----------------------------------------------------------"
INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
echo "Access the application through the Istio Ingress Gateway:"
echo "http://$CLUSTERIP:$INGRESS_PORT"
echo "-----------------------------------------------------------"
KIALI_PORT=$(kubectl -n istio-system get service kiali -o jsonpath='{.spec.ports[?(@.name=="http-kiali")].nodePort}')
echo "Access Kiali:"
echo "http://$CLUSTERIP:$KIALI_PORT"
echo "-----------------------------------------------------------"
PROM_PORT=$(kubectl -n istio-system get service prometheus -o jsonpath='{.spec.ports[?(@.name=="http-prometheus")].nodePort}')
echo "Access Prometheus:"
echo "http://$CLUSTERIP:$PROM_PORT"
echo "-----------------------------------------------------------"
GRAF_PORT=$(kubectl -n istio-system get service grafana -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
echo "Access Grafana:"
echo "http://$CLUSTERIP:$GRAF_PORT"
echo "-----------------------------------------------------------"
echo ""
