resource "local_file" "inventory" {
  content = <<-DOC
    ---
    kuber:
      hosts:
        master:
          ansible_host: ${yandex_compute_instance.vm_for_each["master.kuber.netology.yc"].network_interface.0.nat_ip_address}
        client:
          ansible_host: ${yandex_compute_instance.vm_for_each["client.kuber.netology.yc"].network_interface.0.nat_ip_address}
    DOC
  filename = "../playbook/inventory/prod.yml"

  depends_on = [
    yandex_compute_instance.vm_for_each
  ]
}