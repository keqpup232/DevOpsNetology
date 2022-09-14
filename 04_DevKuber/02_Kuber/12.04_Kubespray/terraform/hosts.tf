resource "local_file" "hosts" {
  content = <<-DOC
    all:
      hosts:
        master01:
          ansible_host: ${yandex_compute_instance.vm_for_each["master01.kuber.netology.yc"].network_interface.0.ip_address}
          ip: ${yandex_compute_instance.vm_for_each["master01.kuber.netology.yc"].network_interface.0.ip_address}
          access_ip: ${yandex_compute_instance.vm_for_each["master01.kuber.netology.yc"].network_interface.0.ip_address}
        worker01:
          ansible_host: ${yandex_compute_instance.vm_for_each["worker01.kuber.netology.yc"].network_interface.0.ip_address}
          ip: ${yandex_compute_instance.vm_for_each["worker01.kuber.netology.yc"].network_interface.0.ip_address}
          access_ip: ${yandex_compute_instance.vm_for_each["worker01.kuber.netology.yc"].network_interface.0.ip_address}
        worker02:
          ansible_host: ${yandex_compute_instance.vm_for_each["worker02.kuber.netology.yc"].network_interface.0.ip_address}
          ip: ${yandex_compute_instance.vm_for_each["worker02.kuber.netology.yc"].network_interface.0.ip_address}
          access_ip: ${yandex_compute_instance.vm_for_each["worker02.kuber.netology.yc"].network_interface.0.ip_address}
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
  filename = "../playbook/inventory/hosts.yaml"

  depends_on = [
    local_file.inventory
  ]
}