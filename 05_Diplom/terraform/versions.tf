terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.83"

  cloud {
    organization = "keqpup232"

    workspaces {
      name = "prod"
    }
  }

}