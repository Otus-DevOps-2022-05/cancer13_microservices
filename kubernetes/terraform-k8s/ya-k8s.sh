#!/bin/bash
yc managed-kubernetes cluster get-credentials $(terraform output -raw kube_id) --external

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml

yc compute disk create \
 --name k8s \
 --size 4 \
 --description "disk for k8s"




kubectl get svc -n dashboard -o yaml | yq '.items.[0].status.loadBalancer.ingress.[0].ip'
kubectl get secrets $(kubectl get serviceaccounts/k8s-dashboard-kubernetes-dashboard -n dashboard -o yaml | yq ".secrets.[0].name") -n dashboard -o yaml | yq '.data.token' | base64 --decode



kubectl get svc -n dashboard
kubectl get serviceaccounts/k8s-dashboard-kubernetes-dashboard -n dashboard -o yaml | yq '.secrets.[0].name'