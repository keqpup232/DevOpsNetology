resource "null_resource" "supplementary_addresses" {
  provisioner "local-exec" {
    command = "echo 'supplementary_addresses_in_ssl_keys: [ ${yandex_compute_instance.vm_for_each["master01.kuber.netology.yc"].network_interface.0.nat_ip_address} ]' >> ../playbook/inventory/k8s-cluster.yml"
  }
  depends_on = [
    local_file.hosts
  ]
}

resource "null_resource" "sed_docker" {
  provisioner "local-exec" {
    command = "sed -i -e 's/container_manager: containerd/container_manager: docker/g' ../playbook/inventory/k8s-cluster.yml"
  }
  depends_on = [
    null_resource.supplementary_addresses
  ]
}



