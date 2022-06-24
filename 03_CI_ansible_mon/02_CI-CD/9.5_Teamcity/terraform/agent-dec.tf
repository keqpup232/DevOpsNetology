resource "local_file" "agent" {
  content = <<-DOC
  spec:
    containers:
    - command:
      env:
      - name: SERVER_URL
        value: http://${yandex_compute_instance.vm_for_each["teamcity-master.netology.yc"].network_interface.0.nat_ip_address}:8111
      image: jetbrains/teamcity-agent
      securityContext:
        privileged: false
      stdin: false
      tty: false
  DOC
  filename = "terraform_agent/declaration-agent.yaml"

  depends_on = [
    null_resource.ansible
  ]
}

resource "null_resource" "agent-dec" {
  provisioner "local-exec" {
    command = "cd terraform_agent && terraform apply -auto-approve"
  }

  depends_on = [
    local_file.agent
  ]
}