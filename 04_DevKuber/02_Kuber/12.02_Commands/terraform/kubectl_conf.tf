resource "local_file" "kubectl_conf" {
  content = <<-DOC
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: {{ SSL.stdout }}
        server: {{ IP.stdout }}
      name: minikube

    contexts:
    - context:
        cluster: minikube
        namespace: app-namespace
        user: jane
      name: app-namespace

    current-context: app-namespace
    kind: Config
    preferences: {}
    users:
    - name: jane
      user:
        token: {{ TOKEN.stdout }}
        client-key-data: {{ SSL.stdout }}
    DOC
  filename = "../playbook/kubectl/config.j2"

  depends_on = [
    local_file.inventory
  ]
}