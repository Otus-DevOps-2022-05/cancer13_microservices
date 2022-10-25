terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
}
provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

data "yandex_iam_service_account" "msa" {
  name = "msa"
}

resource "yandex_kubernetes_cluster" "cluster_hw20_ach" {
  name        = "k8scluster"
  description = "create cluster with terraform"
  network_id = var.network_id

  master {
    version = "1.20"
    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "05:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = "${data.yandex_iam_service_account.msa.id}"
  node_service_account_id = "${data.yandex_iam_service_account.msa.id}"

  labels = {
    tags = "cluster"
  }

  release_channel = "RAPID"
  network_policy_provider = "CALICO"

}

resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id  = "${yandex_kubernetes_cluster.cluster_hw20_ach.id}"
  name        = "m-node-group"
  version     = "1.20"

  instance_template {
    platform_id = "standard-v2"
    network_interface {
      nat                = true
      subnet_ids         = [var.subnet_id]
    }

    resources {
      memory = 8
      cores  = 4
      core_fraction = 20
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

    scheduling_policy {
      preemptible = false
    }

  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }
  }
}
