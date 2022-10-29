resource "kubernetes_namespace" "app-stand" {
  metadata {
    name = "${var.namespace}"
    labels = {
      "terraform" = "true"
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.otus-kube,
    yandex_kubernetes_node_group.otus-kube-node
  ]
}