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
    access_key = "YCAJEksfRdBhSHk4rfMey7qpy"
    secret_key = "YCMjtIkcy5333HmMjRCBTOp8FpqHHXoDcqIIK6i6"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

resource "yandex_storage_bucket" "log_bucket" {
  bucket = "keqpup232"
}

resource "yandex_storage_bucket" "version" {
  bucket = "keqpup232_version"
  acl    = "private"

  logging {
    target_bucket = yandex_storage_bucket.log_bucket.id
    target_prefix = "log/"
  }

  versioning {
    enabled = true
  }
}