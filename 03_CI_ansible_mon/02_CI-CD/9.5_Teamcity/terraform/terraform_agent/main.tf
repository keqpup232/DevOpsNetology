provider "yandex" {
  service_account_key_file = "key.json"
  zone      = "ru-central1-a"
  folder_id = "b1g7evdi2gkc7jqre2af"
}

data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

data "yandex_vpc_subnet" "foo" {
  name = "test"
}


resource "yandex_compute_instance" "agent" {

  name = "node-teamcity-agent"
  hostname = "teamcity-agent.netology.yc"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.foo.id
    nat        = true
  }

  metadata = {
    docker-container-declaration = file("${path.module}/declaration-agent.yaml")
    ssh-keys = sensitive("centos:${file("~/.ssh/id_rsa.pub")}")
  }

}
