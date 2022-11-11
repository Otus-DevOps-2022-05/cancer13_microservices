#!/bin/zsh
#helm repo add gitlab https://charts.gitlab.io/
#helm repo update
helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  --set global.hosts.domain=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o yaml | yq '.status.loadBalancer.ingress.[0].ip').sslip.io \
  --set certmanager-issuer.email=kuznivan@gmail.com \
  --set postgresql.image.tag=13.6.0 \
  --set gitlab-runner.runners.privileged=true \
  --set gitlab-runner.rbac.create=true \
  --set gitlab-runner.rbac.serviceAccountName=gitlab-admin \
  --set gitlab-runner.rbac.clusterWideAccess=true \
  -n gitlab --create-namespace

# Полученик адреса gitlab
kubectl get ingress -n gitlab

# предоставление прав для docker in docker
kubectl create clusterrolebinding gitlab-admin --clusterrole=cluster-admin --serviceaccount=gitlab:default
# получение пароля от gitlab (пользователь root)
base64 -d <<< $(kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' -n gitlab)

