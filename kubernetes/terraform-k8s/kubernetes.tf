resource "kubernetes_namespace" "stand-namespace" {
  metadata {
    name = var.namespace
    labels = {
      "terraform" = "true"
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.otus-kube,
    yandex_kubernetes_node_group.otus-kube-node
  ]
}