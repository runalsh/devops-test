resource "yandex_vpc_network" "vpc" {
  name  = "vpc"
  labels = local.common_labels
}

resource "yandex_vpc_subnet" "internal" {
  name           = var.internal_subnet
  v4_cidr_blocks = var.cidr-int
  network_id     = yandex_vpc_network.vpc.id
  route_table_id = yandex_vpc_route_table.nat.id
  labels = local.common_labels
}

resource "yandex_vpc_subnet" "external" {
  name           = var.external_subnet
  v4_cidr_blocks = var.cidr-ext
  network_id     = yandex_vpc_network.vpc.id
  labels = local.common_labels
}

resource "yandex_vpc_route_table" "nat" {
  name       = "nat"
  network_id = yandex_vpc_network.vpc.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = local.gateway_ip
  }
  labels = local.common_labels
}


resource "yandex_vpc_security_group" "sg" {
  name        = "security group"
  description = "allow 80 http"
  network_id  = "${yandex_vpc_network.vpc.id}"

  labels = local.common_labels

  ingress {
    protocol       = "TCP"
      description    = "allow incoming 80"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
  }

  egress {
    protocol       = "TCP"
      description    = "allow outgoing all"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
  }
}