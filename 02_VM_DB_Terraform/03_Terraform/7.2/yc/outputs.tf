output "cloud_id" {
  value = data.yandex_client_config.client.cloud_id
}

output "folder_id" {
  value = data.yandex_client_config.client.folder_id
}

output "zone" {
  value = data.yandex_client_config.client.zone
}

output "private_ip" {
  value = "${yandex_compute_instance.vm.network_interface.0.ip_address}"
}

output "vpc_id" {
  value = "${yandex_compute_instance.vm.network_interface.0.subnet_id}"
}
