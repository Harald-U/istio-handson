---
title: 2. Setup your work environment
layout: default
---

# Exercise 2: Setup your work environment



## IBM Cloud Shell

You will use the IBM Cloud Shell to continue with the workshop. It is a web based Linux shell that has all the required tools installed and has you already logged into your IBM Cloud account. 

1. In the menu bar of the IBM Cloud dashboard click on the "terminal" icon:
    ![access clsh](../images/access_cloudshell.png)

1. Wait a moment for the environment being created:

    ![cloudshell](../images/cloudshell.png)

    Read the **Note** displayed in the shell about limits and timeouts!

    Your IBM Cloud Shell did time out? [Check here how to continue.](miscellaneous.md)

1. The screenshot above shows how to check connection with the IBM Cloud:

    ```
    ibmcloud target
    ```

1. Now get **the code for the rest of the workshop.** In the shell type:

    ```
    git clone https://github.com/Harald-U/istio-handson
    cd istio-handson/deployment/
    ```

---

## "Get" the environment

For the rest of the lab we need some parameters that are specific to your environment:

- Cluster name
- IP address of the worker node
- Kube config

1. Execute this command:

    ```
    ./get-env.sh
    ```

    This creates a file local.env, have a look at it:

    ```
    cat local.env
    ```

1. The content of this file is "sourced" in the other script files and you must do that in the Cloud Shell, too, otherwise you can't use `kubectl` later on:

    ```
    source local.env
    ```

    Note: This command also creates an alias 'kc' for 'kubectl' ... less typing :-)
    
---

## Install Istio

Normally in a production size Kubernetes cluster on IBM Cloud we would install Istio as an Add-On. There are 5 Kubernetes add-ons available: Istio, Knative, Kubernetes Terminal, Diagnostic and Debug Tools, and Static Route. Istio installed via the add-on is a managed service and it creates a production grade Istio instance and it requires a cluster with at least 3 worker nodes with 4 CPUs and 16 GB of memory which our lab Kubernetes cluster doesn't have.

Instead, in this lab we will install Istio manually using `istioctl` and its standalone operator. `istioctl` is available in IBM Cloud Shell, when I wrote these instructions it was at version 1.5.4 which means we will install Istio 1.5.4.

1. Execute the following commands:

    ```
    istioctl operator init
    kubectl create ns istio-system
    kubectl apply -f istio.yaml
    ```

    These commands install the Istio operator, create a namespace for the Istio backplane, and start to install the Istio backplane. The installation uses the Istio "demo" profile. This profile installs almost everything that makes up Istio, no high availability, logging and tracing rate is set to 100 % of all events. The "demo" profile is not suitable for production!
    
1. Check the status of Istio:

    ```
    kubectl get pod -n istio-system
    ```

    The result should look like this:

    ```
    NAME                                    READY   STATUS    RESTARTS   AGE
    grafana-5cc7f86765-65fc6                1/1     Running   0          3m28s
    istio-egressgateway-5c8f9897f7-s8tfq    1/1     Running   0          3m32s
    istio-ingressgateway-65dd885d75-vrcg8   1/1     Running   0          3m29s
    istio-tracing-8584b4d7f9-7krd2          1/1     Running   0          3m13s
    istiod-7d6dff85dd-29mjb                 1/1     Running   0          3m29s
    kiali-696bb665-8rrhr                    1/1     Running   0          3m12s
    prometheus-564768879c-2r87j             2/2     Running   0          3m12s
    ```

1. We will be using the Istio telemetry services Jaeger, Grafana, Prometheus and the Kiali dashboard in a later exercise. 

    Istio Version 1.5.4 used in this example installs all of them, the Jaeger pod is called "istio-tracing". 
    
    Later versions of Istio may not install some or any of them. Istio Docs provides [instructions to install](https://istio.io/latest/docs/ops/integrations/) the so called "Integrations". If one or more of them are missing, use one of the following commands to install them. 

    **Jaeger:** 

    ```
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.8/samples/addons/jaeger.yaml
    ```

    **Grafana:**

    ```
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.8/samples/addons/grafana.yaml
    ```

    **Prometheus:**

    ```
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.8/samples/addons/prometheus.yaml
    ```

    **Kiali:**

    ```
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.8/samples/addons/kiali.yaml
    ```


1. Finalize the installation:

    ```
    ./finalize.sh
    ```

    This command enables [sidecar auto-injection](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/) for the 'default' namespace.
    It also retrieves the NodePort number of the Istio Ingress and stores it in local.env for later use.

---

## >> [Continue with Exercise 3](exercise3.md)
