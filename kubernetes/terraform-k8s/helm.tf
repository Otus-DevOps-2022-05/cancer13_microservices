resource "helm_release" "k8s_dashboard" {
  name             = "k8s-dashboard"
  chart            = "kubernetes-dashboard"
  namespace        = "dashboard"
  repository       = var.helm_repo_k8s_dashboard
  timeout          = var.helm_timeout
  version          = var.helm_k8s_dashboard_version
  create_namespace = true
  reset_values     = false

  set {
    name  = "labels.terraform"
    value = "true"
  }

  // set {
  //   name  = "serviceAccount"
  //   value = "true"
  // }

  set {
    name  = "settings.itemsPerPage"
    value = 30
  }

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  depends_on = [
    yandex_kubernetes_cluster.otus-kube,
    yandex_kubernetes_node_group.otus-kube-node
  ]
}

resource "helm_release" "ingress-controller" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = var.ingress_controller
  timeout          = var.helm_timeout
  version          = "4.3.0"
  create_namespace = true
  reset_values     = false

  set {
    name  = "controller.ingressClassResource.name"
    value = "insecure"
  }

  depends_on = [
    yandex_kubernetes_cluster.otus-kube,
    yandex_kubernetes_node_group.otus-kube-node
  ]
}