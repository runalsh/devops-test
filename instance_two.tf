resource "yandex_compute_instance" "instance_two" {
  name        = "instance-with-few-disks"
  hostname    = "web-server-two"
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
      image_id = var.instance_two_os
      size     = 25
    }
  }
  dynamic secondary_disk {
    for_each = "${yandex_compute_disk.disk.*.id}"

    content {
    disk_id     = yandex_compute_disk.disk["${secondary_disk.key}"].id
    auto_delete = true
    }

  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.external.id
    nat            = true
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

resource "yandex_compute_disk" "disk" {
  count      = var.instance_two_disk_number
  name       = "disk-${count.index}"
  type       = "network-hdd"
  zone       = var.az_zone
  size       = "1"
  labels = local.common_labels
}
