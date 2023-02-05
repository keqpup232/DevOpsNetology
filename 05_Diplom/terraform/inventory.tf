resource "local_file" "inventory" {
  content = <<-DOC
    ---
    kuber:
      hosts:
        master_01:
          ansible_host: ${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.nat_ip_address}
    DOC
  filename = "../playbook/kuber/inventory/prod.yml"

  depends_on = [
    yandex_compute_instance.vm_for_each
  ]
}