output "external_ip_address_service" {
  value = [for name in yandex_compute_instance.vm_for_each : "${name.name} service http://${name.network_interface.0.nat_ip_address}:8082"]
}

output "external_ip_address_minikube" {
  value = [for name in yandex_compute_instance.vm_for_each : "${name.name} minikube http://${name.network_interface.0.nat_ip_address}:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/"]
}