resource "yandex_vpc_subnet" "subnet-public-a" {
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  name = "public-a"
  route_table_id = yandex_vpc_route_table.route_table.id
}

resource "yandex_vpc_subnet" "subnet-public-b" {
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.11.0/24"]
  name = "public-b"
  route_table_id = yandex_vpc_route_table.route_table.id
}

resource "yandex_vpc_subnet" "subnet-public-c" {
  zone       = "ru-central1-c"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.12.0/24"]
  name = "public-c"
  route_table_id = yandex_vpc_route_table.route_table.id
}

resource "yandex_vpc_subnet" "subnet-private-a" {
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  name = "private-a"
}

resource "yandex_vpc_subnet" "subnet-private-b" {
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.21.0/24"]
  name = "private-b"
}

resource "yandex_vpc_subnet" "subnet-private-c" {
  zone       = "ru-central1-c"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.22.0/24"]
  name = "private-c"
}