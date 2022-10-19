output "external_ip_address_kube-node" {
  value = yandex_compute_instance.kube-node[*].network_interface[0].nat_ip_address
}
output "ansible_index_kube" {
  value = yandex_compute_instance.kube-node[*].labels.ansible-index
}
output "hostname_nodes_kube" {
  value = yandex_compute_instance.kube-node.*.name
}
