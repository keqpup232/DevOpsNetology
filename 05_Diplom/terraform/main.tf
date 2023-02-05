provider "yandex" {
  zone  = "ru-central1-a"
}

resource "yandex_compute_instance" "vm_for_each" {

  for_each = local.web_instance_each_map[terraform.workspace]
  hostname = each.key
  zone = each.value.zone
  name = each.value.name

  resources {
    cores  = each.value.cores
    memory = each.value.memory
  }

  boot_disk {
    initialize_params {
      image_id = each.value.image_id
      size = each.value.size
    }
  }

  network_interface {
    subnet_id = each.value.subnet_id
    nat        = true
  }

  metadata = {
    ssh-keys = sensitive("${each.value.user}:${file("~/.ssh/id_rsa.pub")}")
  }
}