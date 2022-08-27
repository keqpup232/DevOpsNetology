resource "local_file" "kubectl_conf" {
  content = <<-DOC
    apiVersion: v1
    clusters:
    - cluster:
        server: http://${yandex_compute_instance.vm_for_each["master.kuber.netology.yc"].network_interface.0.nat_ip_address}:8001
    contexts: null
    current-context: ""
    kind: Config
    preferences: {}
    users: null
    DOC
  filename = "../playbook/kubectl/config"

  depends_on = [
    local_file.inventory
  ]
}