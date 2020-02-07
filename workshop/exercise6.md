# Security

## mTLS

Kiali, Graph, Display: check Security

MeshPolicy 
DestinationRule w/ 

kubectl apply -f mtls.yaml

-> Kiali Padlock, Mesh-wide TLS is partially enabled
-> Padlock on all connections

----

## Access Control

kubectl create sa articles
kubectl create sa web-api

kubectl replace -f articles-sa.yaml
kubectl replacemp.yaml
 -f web-api-sa.yaml

kubectl apply -f authorization.yaml

Kiali 
![kiali auth pol](../images/kiali-auth-pol.png)

kubectl apply -f authorization-w-rule.yaml