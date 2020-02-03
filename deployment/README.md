# Install Istio on IKS Lite Cluster

Config for demo setup created with

`istioctl manifest generate --set profile=demo > istio-demo.yaml`

istio-demo.yaml was split:

1. CRDs
2. Deployments

Changes to Deployments:

1. Deleted istio-egress-gateway definition
2. NodePorts for Kiali, Jaeger, Prometheus, Grafana

Installation of Istio takes less than 5 minutes.

3 Scripte:
1. get-env.sh erzeugt local.env mit ClusterIP, ClusterName und Kubecfg
2. install-istio.sh
3. show-urls.sh

