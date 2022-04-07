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
  network_id = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["192.168.101.0/24"]
}

resource "yandex_compute_instance" "vm" {

  count = local.web_instance_count_map[terraform.workspace]
  name = "vm-${count.index}"
  platform_id = local.web_instance_type_map[terraform.workspace]
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
    subnet_id = yandex_vpc_subnet.foo.id
    nat        = true
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

}

resource "yandex_compute_instance" "vm_for_each" {

  for_each = local.web_instance_each_map[terraform.workspace]

  platform_id = each.value
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
    subnet_id = yandex_vpc_subnet.foo.id
    nat        = true
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }


}

data "yandex_client_config" "client" {}
