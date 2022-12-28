resource "yandex_vpc_route_table" "route_table" {
  network_id = "${yandex_vpc_network.net.id}"
}