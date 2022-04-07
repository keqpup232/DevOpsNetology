terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "keqpup232"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = env
    secret_key = env

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}