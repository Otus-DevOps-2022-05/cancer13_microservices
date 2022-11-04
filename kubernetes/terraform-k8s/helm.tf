resource "helm_release" "k8s_dashboard" {
  name             = "k8s-dashboard"
  chart            = "kubernetes-dashboard"
  namespace        = "dashboard"
  repository       = var.helm_repo_k8s_dashboard
  timeout          = var.helm_timeout
  create_namespace = true
  reset_values     = false

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
  name             = var.ingress_controller
  namespace        = var.ingress_controller
  chart            = var.ingress_controller
  repository       = var.ingress_controller_repo
  timeout          = var.helm_timeout
  create_namespace = true
  reset_values     = false

  depends_on = [
    yandex_kubernetes_cluster.otus-kube,
    yandex_kubernetes_node_group.otus-kube-node
  ]
}
