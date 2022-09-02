resource "null_resource" "config" {
  provisioner "local-exec" {
    command = "sed -i -e 's,server: https://127.0.0.1:6443,server: https://${yandex_compute_instance.vm_for_each["master01.kuber.netology.yc"].network_interface.0.nat_ip_address}:6443,g'  ~/.kube/config"
  }
  depends_on = [
    null_resource.cluster
  ]
}