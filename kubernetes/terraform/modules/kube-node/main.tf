terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
}
data "yandex_compute_image" "ubuntu-image" {
  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "kube-node" {
  count = var.nodes_count
  name = "kube-node-${count.index}"
  labels = {
    tags = "kube-node"
    ansible-index = count.index
  } 
  resources {
    # core_fraction = 20 # for economy
    cores         = 4
    memory        = 4
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-image.image_id
      size = "40"
      type = "network-ssd"
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
