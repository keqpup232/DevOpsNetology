resource "null_resource" "supplementary_addresses" {
  provisioner "local-exec" {
    command = "echo 'supplementary_addresses_in_ssl_keys: [ ${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.nat_ip_address} ]' >> ../playbook/kuber/inventory/k8s-cluster.yml"
  }
  depends_on = [
    local_file.hosts1
  ]
}

resource "local_file" "script" {
  content = <<-DOC
    #!/bin/sh
    ansible-playbook -i ../playbook/kuber/inventory/prod.yml ../playbook/kuber/prepare.yml
    sleep 10
    ssh ubuntu@${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.nat_ip_address} 'export ANSIBLE_CONFIG=/home/ubuntu/kubespray/ansible.cfg; ansible-playbook -i /home/ubuntu/kubespray/inventory/mycluster/hosts.yaml /home/ubuntu/kubespray/cluster.yml -b -v'
    sleep 10
    ansible-playbook -i ../playbook/kuber/inventory/prod.yml ../playbook/kuber/get-kubeconfig.yml
    sleep 10
    sed -i -e 's,server: https://127.0.0.1:6443,server: https://${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.nat_ip_address}:6443,g'  ~/.kube/config
    sleep 10
    ansible-playbook -i ../playbook/jenkins/inventory/cicd/hosts.yml ../playbook/jenkins/site.yml
    DOC
  filename = "../playbook/kuber/inventory/install"

  depends_on = [
    null_resource.supplementary_addresses
  ]
}

resource "null_resource" "chmod" {
  provisioner "local-exec" {
    command = "chmod 755 ../playbook/kuber/inventory/install"
  }
  depends_on = [
    local_file.script
  ]
}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 100"
  }

  depends_on = [
    null_resource.chmod
  ]
}