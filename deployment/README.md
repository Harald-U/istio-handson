# Content

1. get-env.sh creates local.env with ClusterIP, ClusterName, Kubecfg, and alias kc for kubectl
1. install-istio.sh installs Istio Demo profile, details below
1. deploy-app.sh deploys the Cloud Native Starter sample
1. show-urls.sh displays relevant URLs for your environment
1. delete-all.sh is a cleanup script, deletes the sample and mTLS config 


# Installation of Istio Demo profile on IKS Lite Cluster

Config for demo setup created with

`istioctl manifest generate --set profile=demo > istio-demo.yaml`

istio-demo.yaml was split:

1. CRDs
2. Deployments

Changes to Deployments:

1. Deleted istio-egress-gateway definition
2. Configured NodePorts for Kiali, Jaeger, Prometheus, Grafana for external use

Installation of Istio takes less than 5 minutes.




