resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 40"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../infrastructure/inventory/cicd/hosts.yml ../infrastructure/site.yml"
  }

  depends_on = [
    null_resource.wait
  ]
}