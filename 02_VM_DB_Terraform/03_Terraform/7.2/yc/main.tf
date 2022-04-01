provider "yandex" {
  service_account_key_file = "key.json"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "my_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone       = "ru-central1-a"
  network_id = "${yandex_vpc_network.foo.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}

resource "yandex_compute_instance" "vm" {
  name = "vm-ubuntu-2004"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.foo.id}"
    nat        = true
    ip_address = "192.168.101.16"
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

}

data "yandex_client_config" "client" {}
