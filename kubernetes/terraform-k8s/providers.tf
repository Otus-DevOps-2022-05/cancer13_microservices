terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.14.0"
    }
  }
//   backend "s3" {
//     bucket         = ""
//     key            = ""
//     dynamodb_table = ""
//   }
}

// data "terraform_remote_state" "previous" {
//   backend = "s3"

//   config = {
//     bucket         = ""
//     key            = ""
//     dynamodb_table = ""
//   }
// }

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
