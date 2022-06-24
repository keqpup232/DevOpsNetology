resource "local_file" "inventory" {
  content = <<-DOC
    ---
    all:
      hosts:
        nexus-01:
          ansible_host: ${yandex_compute_instance.nexus.network_interface.0.nat_ip_address}
      children:
        nexus:
          hosts:
            nexus-01:
      vars:
        ansible_connection_type: paramiko
        ansible_user: centos
    DOC
  filename = "../infrastructure/inventory/cicd/hosts.yml"

  depends_on = [
    yandex_compute_instance.vm_for_each
  ]
}