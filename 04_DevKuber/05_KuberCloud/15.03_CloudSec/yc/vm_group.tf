resource "yandex_compute_instance_group" "group-vm" {
  name                = "test-group"
  folder_id           = var.folder_id
  service_account_id  = var.service_account_id
  instance_template {
    platform_id = "standard-v1"
    name = "group-{instance.index}"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.net.id}"
      subnet_ids = ["${yandex_vpc_subnet.subnet-public.id}"]
      nat        = true
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = file("index.yaml")
    }

    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }

  health_check {
  interval            = 10
  timeout             = 3
  healthy_threshold   = 2
  unhealthy_threshold = 6
    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name        = "target-group-1"
    target_group_description = "load balancer target group"
  }

}