resource "yandex_iam_service_account" "k8s_account" {
  name        = "k8ssa"
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  # editor
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  ]
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.key-a.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_account.id}",
  ]
}