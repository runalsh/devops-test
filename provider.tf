terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.az_zone
  service_account_key_file="key.json"
  folder_id = "b1gc7ib0c849c2havu62"
}

variable "az_zone" {
  type    = string
  default = "ru-central1-a"
}

locals {
  common_labels = {
    managed_by = "terraform"
  }
}

# resource "yandex_iam_service_account" "sa" {
#   name        = "new_service_account"
#   description = "for terraform management"
#   folder_id   = "b1gc7ib0c849c2havu62"
# }

# resource "yandex_resourcemanager_folder_iam_member" "sa-iam-editor" {
#   folder_id   = "b1gc7ib0c849c2havu62"
#   role        = "editor"
#   member      = "serviceAccount:${yandex_iam_service_account.sa.name}"
# }



























