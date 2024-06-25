resource "yandex_compute_instance" "instance_one" {
  name        = var.instance_one_name
  hostname    = "web-server-one"
  zone        = var.az_zone
  platform_id = "standard-v2"
  allow_stopping_for_update = true
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
  boot_disk {
    auto_delete = true
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
      size     = 25
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.external.id
    nat            = true
    ip_address     = local.gateway_ip
    security_group_ids = [yandex_vpc_security_group.sg.id]
  }
  scheduling_policy {
    preemptible = false
  }
  
  metadata = {
    serial-port-enable = 1
    user-data = templatefile("./cloudinit.yml", {
      vars = {
        welcome_msg = "${var.welcome}"
      }
    })
  }
  labels = local.common_labels
}

data "yandex_compute_image" "os" {
  family = var.instance_one_os
}