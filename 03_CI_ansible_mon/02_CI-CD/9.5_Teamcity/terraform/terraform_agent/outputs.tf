output "external_ip_agent" {
  value = "agent externa ip is ${yandex_compute_instance.agent.network_interface.0.nat_ip_address}"
}