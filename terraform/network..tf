resource "yandex_vpc_network" "HW_Netology" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public_a" {
  name           = var.public_subnet_a
  zone           = var.default_zone_a
  network_id     = yandex_vpc_network.HW_Netology.id
  v4_cidr_blocks = var.public_cidr_a
}

resource "yandex_vpc_subnet" "private_a" {
  name           = var.private_subnet_a
  zone           = var.default_zone_a
  network_id     = yandex_vpc_network.HW_Netology.id
  v4_cidr_blocks = var.private_cidr_a
}

resource "yandex_vpc_subnet" "public_b" {
  name           = var.public_subnet_b
  zone           = var.default_zone_b
  network_id     = yandex_vpc_network.HW_Netology.id
  v4_cidr_blocks = var.public_cidr_b
}

resource "yandex_vpc_subnet" "private_b" {
  name           = var.private_subnet_b
  zone           = var.default_zone_b
  network_id     = yandex_vpc_network.HW_Netology.id
  v4_cidr_blocks = var.private_cidr_b
}

resource "yandex_vpc_subnet" "public_d" {
  name           = var.public_subnet_d
  zone           = var.default_zone_d
  network_id     = yandex_vpc_network.HW_Netology.id
  v4_cidr_blocks = var.public_cidr_d
}

resource "yandex_vpc_subnet" "private_d" {
  name           = var.private_subnet_d
  zone           = var.default_zone_d
  network_id     = yandex_vpc_network.HW_Netology.id
  v4_cidr_blocks = var.private_cidr_d
}