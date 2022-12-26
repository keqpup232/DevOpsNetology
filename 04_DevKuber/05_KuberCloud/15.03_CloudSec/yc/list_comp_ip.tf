resource "null_resource" "get-list" {
  provisioner "local-exec" {
    command = "yc compute instances list --folder-id b1g7evdi2gkc7jqre2af"
  }

  depends_on = [
    yandex_compute_instance_group.group-vm,
    yandex_lb_network_load_balancer.load_balancer
  ]
}