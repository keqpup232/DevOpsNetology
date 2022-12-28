resource "yandex_mdb_mysql_cluster" "foo" {
  name        = "cluster_db"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.net.id
  version     = "8.0"
  deletion_protection = true

  backup_window_start {
    hours   = 23
    minutes = 59
  }

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = "ru-central1-a"
    name      = "na-1"
    subnet_id = yandex_vpc_subnet.subnet-private-a.id
  }
  host {
    zone                    = "ru-central1-b"
    name                    = "nb-1"
    replication_source_name = "na-1"
    subnet_id               = yandex_vpc_subnet.subnet-private-b.id
  }
  host {
    zone                    = "ru-central1-b"
    name                    = "nb-2"
    replication_source_name = "nb-1"
    subnet_id               = yandex_vpc_subnet.subnet-private-b.id
  }
}

resource "yandex_mdb_mysql_database" "foo" {
  cluster_id = yandex_mdb_mysql_cluster.foo.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "root" {
  cluster_id = yandex_mdb_mysql_cluster.foo.id
  name       = "keqpup"
  password   = "password"
  permission {
    database_name = yandex_mdb_mysql_database.foo.name
    roles         = ["ALL"]
  }
}