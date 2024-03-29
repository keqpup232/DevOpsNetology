provider "yandex" {
  service_account_key_file = "key.json"
  zone      = "ru-central1-a"
  folder_id = "b1g7evdi2gkc7jqre2af"
}

data "yandex_compute_image" "my_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "foo" {
}

resource "yandex_vpc_subnet" "foo" {
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["192.168.101.0/24"]
}

resource "yandex_compute_instance" "vm_for_each" {

  for_each = local.web_instance_each_map[terraform.workspace]

  name = each.value
  hostname = each.key
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size = "50"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.foo.id
    nat        = true
  }

  metadata = {
    ssh-keys = sensitive("ubuntu:${file("~/.ssh/id_rsa.pub")}")
  }
}