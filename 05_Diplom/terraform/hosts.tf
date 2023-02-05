resource "local_file" "hosts" {
  content = <<-DOC
    all:
      hosts:
        master01:
          ansible_host: ${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.ip_address}
          ip: ${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.ip_address}
          access_ip: ${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.ip_address}
        worker01:
          ansible_host: ${yandex_compute_instance.vm_for_each["kuber-worker01.netology.yc"].network_interface.0.ip_address}
          ip: ${yandex_compute_instance.vm_for_each["kuber-worker01.netology.yc"].network_interface.0.ip_address}
          access_ip: ${yandex_compute_instance.vm_for_each["kuber-worker01.netology.yc"].network_interface.0.ip_address}
        worker02:
          ansible_host: ${yandex_compute_instance.vm_for_each["kuber-worker02.netology.yc"].network_interface.0.ip_address}
          ip: ${yandex_compute_instance.vm_for_each["kuber-worker02.netology.yc"].network_interface.0.ip_address}
          access_ip: ${yandex_compute_instance.vm_for_each["kuber-worker02.netology.yc"].network_interface.0.ip_address}
      children:
        kube_control_plane:
          hosts:
            master01:
        kube_node:
          hosts:
            worker01:
            worker02:
        etcd:
          hosts:
            master01:
        k8s_cluster:
          children:
            kube_control_plane:
            kube_node:
        calico_rr:
          hosts: {}
    DOC
  filename = "../playbook/kuber/inventory/hosts.yaml"

  depends_on = [
    local_file.inventory
  ]
}

resource "local_file" "hosts1" {
  content = <<-DOC
    ---
    all:
      hosts:
        jenkins-master-01:
          ansible_host: ${yandex_compute_instance.vm_for_each["jenkins-master.netology.yc"].network_interface.0.nat_ip_address}
        jenkins-agent-01:
          ansible_host: ${yandex_compute_instance.vm_for_each["jenkins-agent.netology.yc"].network_interface.0.nat_ip_address}
      children:
        jenkins:
          children:
            jenkins_masters:
              hosts:
                jenkins-master-01:
            jenkins_agents:
              hosts:
                jenkins-agent-01:
      vars:
        ansible_connection_type: paramiko
        ansible_user: cloud-user
    DOC
  filename = "../playbook/jenkins/inventory/cicd/hosts.yml"

  depends_on = [
    local_file.hosts
  ]
}