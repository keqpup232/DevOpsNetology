resource "yandex_kubernetes_cluster" "regional_cluster_resource_name" {
  name        = "k8s-regional"
  network_id = "${yandex_vpc_network.net.id}"

  service_account_id      = "${yandex_iam_service_account.k8s_account.id}"
  node_service_account_id = "${yandex_iam_service_account.k8s_account.id}"

  master {
    version   = "1.22"
    public_ip = true
    regional {
      region = "ru-central1"

      location {
        zone      = "${yandex_vpc_subnet.subnet-public-a.zone}"
        subnet_id = "${yandex_vpc_subnet.subnet-public-a.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.subnet-public-b.zone}"
        subnet_id = "${yandex_vpc_subnet.subnet-public-b.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.subnet-public-c.zone}"
        subnet_id = "${yandex_vpc_subnet.subnet-public-c.id}"
      }
    }

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "monday"
        start_time = "15:00"
        duration   = "3h"
      }

      maintenance_window {
        day        = "friday"
        start_time = "10:00"
        duration   = "4h30m"
      }
    }
  }

  kms_provider {
    key_id = yandex_kms_symmetric_key.key-a.id
  }

  release_channel = "STABLE"

  depends_on = [
    yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}