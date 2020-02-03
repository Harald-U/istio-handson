#!/bin/bash

# Get clustername 

MYCLUSTER=$(ibmcloud ks cluster ls -s | awk '/classic/ { print $1 }')
echo "Cluster name: $MYCLUSTER"
echo "MYCLUSTER=$MYCLUSTER" > local.env

# Get Cluster External IP
CLUSTERIP=$(ibmcloud ks worker ls --cluster $MYCLUSTER -s | awk '/free/ { print $2 }')
echo "Cluster IP: $CLUSTERIP"
echo "CLUSTERIP=$CLUSTERIP" >> local.env

# Get kubeconfig
ibmcloud ks cluster config --cluster $MYCLUSTER -s 

CFG=$(ibmcloud ks cluster config --cluster $MYCLUSTER --export -s | awk '/export/ { print $2 }')
echo $CFG >> local.env
