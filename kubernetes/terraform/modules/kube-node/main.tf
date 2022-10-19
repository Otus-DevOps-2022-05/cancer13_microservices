terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
}
resource "yandex_compute_instance" "kube-node" {
  count = var.nodes_count
  name = "kube-node-${count.index}"
  labels = {
    tags = "kube-node"
    ansible-index = count.index
  } 
  resources {
    core_fraction = 20 # for economy
    cores         = 4
    memory        = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3" # образ от яндекса ubuntu 20.04
      size = "40"
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
}
