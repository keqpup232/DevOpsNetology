resource "yandex_vpc_route_table" "route_table" {
  network_id = "${yandex_vpc_network.net.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = "192.168.10.254"
  }
}