Content:
[Exercise 1: Create your Cloud environment](exercise1.md) ##
[Exercise 2: Setup your work environment](exercise2.md) ##
[Exercise 3: Install the Cloud Native Starter sample app](exercise3.md) ##
[Exercise 4: Telemetry](exercise4.md) ##
[Exercise 5: Traffic Management](exercise5.md) ##
**Exercise 6: Secure your services**

---

# Exercise 6: Secure your services 

## Mutual authentication with Transport Layer Security (mTLS)

Istio can secure the communication between microservices without requiring application code changes. Security is provided by authenticating and encrypting communication paths within the cluster. This is becoming a common security and compliance requirement. Delegating communication security to Istio (as opposed to implementing TLS in each microservice), ensures that your application will be deployed with consistent and manageable security policies.

Istio Citadel is an optional part of Istio's control plane components. When enabled, it provides each Envoy sidecar proxy with a strong (cryptographic) identity, in the form of a certificate.
Identity is based on the microservice's service account and is independent of its specific network location, such as cluster or current IP address.
Envoys then use the certificates to identify each other and establish an authenticated and encrypted communication channel between them.

Citadel is responsible for:

* Providing each service with an identity representing its role.

* Providing a common trust root to allow Envoys to validate and authenticate each other.

* Providing a key management system, automating generation, distribution, and rotation of certificates and keys.

When an application microservice connects to another microservice, the communication is redirected through the client side and server side Envoys. The end-to-end communication path is:

* Local TCP connection (i.e., `localhost`, not reaching the "wire") between the application and Envoy (client- and server-side);

* Mutually authenticated and encrypted connection between Envoy proxies.

When Envoy proxies establish a connection, they exchange and validate certificates to confirm that each is indeed connected to a valid and expected peer. The established identities can later be used as basis for policy checks (e.g., access authorization).

## Enforce mTLS between all Istio services

1. 'Exercise' the application. Open Kiali, select 'Graph', Namespace: default, and in the Display pulldown check Security. The display should not change.

1. Next we create a MeshPolicy for configuring the receiving end to use mTLS. We also change the existing destination rules to configure the client side to use mTLS.

    Run the following command to enable mTLS across your cluster:

    ```
    kubectl apply -f mtls.yaml
    ```
1. Check Kiali again: 

    - In the Titlebar in the upper right corner you'll see a padlock.When you hover with your mouse pointer over it, it will say "Mesh-wide TLS is partially enabled". This is the result of the MeshPolicy.
    - You will also see padlocks on all connections, the result of the modified DestinationRules

**Note:** If you restart the Articles or the Web-API service now, they won't come up again. Kubernetes Dashboard would show that the Readiness Probe failed. The reason for this is: 
*"If your health check is on the same port as your main application's serving port, and you have Istio Auth enabled (i.e. you have mTLS enabled between services in your mesh) then health checking will not work. This is because Envoy can't tell the difference between a health check and regular old un-encrypted traffic, and the API server performing health checking doesn't run with a sidecar that can perform mTLS for it."*
[https://github.com/istio/istio/issues/2628#issuecomment-358117764](https://github.com/istio/istio/issues/2628#issuecomment-358117764) 

This is the case in our example for the Articles and Web-API service: the liveness/readiness probes are on the same port as the service API itself. The Github issue posted above has instructions to remedy this situation which would require changing the application. For simplicity, in the next section we will simply disable the Readiness and Liveness Probes.


## Control Access to the Articles Service

Istio supports Role Based Access Control(RBAC) for HTTP services in the service mesh.  Let's leverage this to configure access between Web-API and Articles services.

1. Create service accounts for the Articles and Web-API services:

    ```
    kubectl create sa articles
    kubectl create sa web-api
    ```

1. Replace the deployment of Articles and Web-API, this removes the Readiness and Liveness Probes (as mentioned above) and adds the service accounts:

    ```
    kubectl replace -f articles-sa.yaml
    kubectl replace -f web-api-sa.yaml
    ```

1. Apply an AuthorizationPolicy:

    ```
    kubectl apply -f authorization.yaml
    ```

    The policy looks like this:

    ```
    apiVersion: security.istio.io/v1beta1
    kind: AuthorizationPolicy
    metadata:
    name: articlesaccess
    spec:
    selector:
        matchLabels:
        app: articles
    ```

    If you check the application in Kiali you will see errors:

     ![kiali auth pol](../images/kiali-auth-pol.png)

    This AuthorizationPolicy effectively disables all access to Articles.  

1. Now allow access to the Authors service from Web-API:

    ```
    kubectl apply -f authorization-w-rule.yaml
    ```

    The modified policy looks like this:

    ```
    apiVersion: security.istio.io/v1beta1
    kind: AuthorizationPolicy
    metadata:
    name: articlesaccess
    spec:
    selector:
        matchLabels:
        app: articles
    rules:
    - from:
        - source:
            principals: ["cluster.local/ns/default/sa/web-api"]
        to:
        - operation:
            methods: ["GET", "POST"]    
    ```

    This allows 'GET' and 'POST' operations for the ServiceAccount (sa) web-api which is assigned to the Web-API service in the default namespace.

    You need to wait a while to see the results in Kiali but eventually everything is 'green' again:

    ![kiali auth pol](../images/kiali-auth-pol-w-sa.png)

---

## Congratulations!

You have completed this workshop!    