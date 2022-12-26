resource "yandex_iam_service_account" "sa-bucket" {
  name = "user-bucket"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor-bucket" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key-bucket" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
  description        = "static access key for object storage"
}
resource "yandex_storage_bucket" "bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key-bucket.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key-bucket.secret_key
  bucket     = "keqpup232"
  acl    = "public-read"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "cat-picture" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key-bucket.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key-bucket.secret_key
  bucket = yandex_storage_bucket.bucket.bucket
  key    = "cat"
  source = "images/cat.jpeg"
  depends_on = [yandex_storage_bucket.bucket]
}