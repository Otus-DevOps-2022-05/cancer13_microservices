terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
}
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
module "kube-node" {
  source          = "./modules/kube-node"
  public_key_path = var.public_key_path
  private_key_path = var.private_key_path
  subnet_id       = yandex_vpc_subnet.kube-subnet.id
}

resource "yandex_vpc_network" "kube-network" {
  name = "kube-network"
}

resource "yandex_vpc_subnet" "kube-subnet" {
  name           = "kube-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.kube-network.id}"
  v4_cidr_blocks = ["10.244.0.0/16"]
}

# generate inventory file for Ansible
resource "local_file" "ansible_inventory" {
  depends_on = [
    module.kube-node
  ]
  content = templatefile("./templates/inventry.j2",
    {
      nodes = module.kube-node.external_ip_address_kube-node,
      ansible_index = module.kube-node.ansible_index_kube,
      hostname_nodes = module.kube-node.hostname_nodes_kube
    }
  )
  filename = "../ansible/inventory.yml"
}