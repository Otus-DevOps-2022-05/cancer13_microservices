#!/bin/bash
yc managed-kubernetes cluster get-credentials $(terraform output -raw kube_id) --external

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml

yc compute disk create \
 --name k8s \
 --size 4 \
 --description "disk for k8s"