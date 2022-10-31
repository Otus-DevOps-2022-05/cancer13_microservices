data "kubernetes_service" "k8s_dashboard_ingress" {
  metadata {
    name      = "k8s-dashboard"
    namespace = "dashboard"
    labels = {
      "terraform" = "true"
    }
  }

  depends_on = [
    helm_release.k8s_dashboard,
  ]
}
