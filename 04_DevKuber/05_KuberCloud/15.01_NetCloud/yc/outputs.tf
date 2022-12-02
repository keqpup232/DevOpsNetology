output "internal_ip_address_vm-public" {
  value = "${yandex_compute_instance.vm-public.network_interface.0.ip_address}"
}

output "external_ip_address_vm-public" {
  value = "${yandex_compute_instance.vm-public.network_interface.0.nat_ip_address}"
}

output "external_ip_address_nat-instance" {
  value = "${yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_vm-private" {
  value = "${yandex_compute_instance.vm-private.network_interface.0.ip_address}"
}

output "external_ip_address_vm-private" {
  value = "${yandex_compute_instance.vm-private.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_nat-instance" {
  value = "${yandex_compute_instance.nat-instance.network_interface.0.ip_address}"
}
