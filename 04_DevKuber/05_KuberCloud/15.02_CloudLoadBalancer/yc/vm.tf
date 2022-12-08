data "yandex_compute_image" "my_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-public" {
  name        = "vm-public"
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
    subnet_id = yandex_vpc_subnet.subnet-public.id
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vm-private" {
  name        = "vm-private"
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
    subnet_id = yandex_vpc_subnet.subnet-private.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}