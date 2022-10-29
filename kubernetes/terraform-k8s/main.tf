resource "yandex_iam_service_account" "kuba" {
 name        = "kuba"
 description = "sa для kuber'а"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  # Сервисному аккаунту назначается роль "editor".
  folder_id = var.folder_id
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.kuba.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  members   = [
    "serviceAccount:${yandex_iam_service_account.kuba.id}"
  ]
}

resource "yandex_vpc_network" "kube-network" {
  name = "kube-network"
}

resource "yandex_vpc_subnet" "kube-subnet" {
  name           = "kube-subnet"
  zone           = var.zone
  network_id     = "${yandex_vpc_network.kube-network.id}"
  v4_cidr_blocks = ["10.244.0.0/16"]
}

resource "yandex_kubernetes_cluster" "otus-kube" {
  name        = "k8scluster"
  description = "create cluster with terraform"
  network_id     = "${yandex_vpc_network.kube-network.id}"

  master {
    version = "1.22"
    zonal {
      zone      = var.zone
      subnet_id       = yandex_vpc_subnet.kube-subnet.id
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

  service_account_id      = "${yandex_iam_service_account.kuba.id}"
  node_service_account_id = "${yandex_iam_service_account.kuba.id}"

  labels = {
    tags = "cluster"
  }

  release_channel = "STABLE"
  network_policy_provider = "CALICO"

  provisioner "local-exec" {
    command = "yc managed-kubernetes cluster get-credentials ${yandex_kubernetes_cluster.otus-kube.id} --external --force"
  }
}

resource "yandex_kubernetes_node_group" "otus-kube-node" {
  cluster_id  = "${yandex_kubernetes_cluster.otus-kube.id}"
  name        = "kube-node-group"
  version     = "1.22"

  instance_template {
    platform_id = "standard-v2"
    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.kube-subnet.id]
    }

    resources {
      memory = 8
      cores  = 4
      // core_fraction = 20
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }
    metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
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
  depends_on = [
    yandex_kubernetes_cluster.otus-kube
  ]
}
