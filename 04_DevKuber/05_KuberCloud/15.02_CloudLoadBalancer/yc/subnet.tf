resource "yandex_vpc_subnet" "subnet-public" {
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  name = "public"
}

resource "yandex_vpc_subnet" "subnet-private" {
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  name = "private"
  route_table_id = yandex_vpc_route_table.route_table.id
}