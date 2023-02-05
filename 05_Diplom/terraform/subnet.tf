resource "yandex_vpc_subnet" "subnet-public-a" {
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.1.1.0/24"]
  name = "public-a"
}

resource "yandex_vpc_subnet" "subnet-public-b" {
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.1.2.0/24"]
  name = "public-b"
}

resource "yandex_vpc_subnet" "subnet-public-c" {
  zone       = "ru-central1-c"
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.1.3.0/24"]
  name = "public-c"
}

resource "yandex_vpc_subnet" "subnet-private-a" {
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.2.1.0/24"]
  name = "private-a"
}

resource "yandex_vpc_subnet" "subnet-private-b" {
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.2.2.0/24"]
  name = "private-b"
}

resource "yandex_vpc_subnet" "subnet-private-c" {
  zone       = "ru-central1-c"
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.2.3.0/24"]
  name = "private-c"
}