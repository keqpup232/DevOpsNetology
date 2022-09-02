output "external_ip_address_service" {
  value = [for name in yandex_compute_instance.vm_for_each : "${name.name} is ${name.network_interface.0.nat_ip_address}"]
}

output "external_ip_address_minikube" {
  value = [for name in yandex_compute_instance.vm_for_each : "${name.name} is ${name.network_interface.0.nat_ip_address}"]
}