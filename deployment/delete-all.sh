#!/bin/bash

# Remove LogDNA Agent
kubectl delete ds logdna-agent --ignore-not-found
kubectl delete secret logdna-agent-key --ignore-not-found

# Disable mTLS
kubectl delete -f ../istio/mtls.yaml --ignore-not-found

# Delete Cloud Native Starter app
kubectl delete -f articles.yaml --ignore-not-found
kubectl delete -f authors.yaml --ignore-not-found
kubectl delete -f web-api.yaml --ignore-not-found
kubectl delete -f istio-ingress.yaml --ignore-not-found
