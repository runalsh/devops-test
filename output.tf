output "external_url_one" {
  value = format("http://%s", yandex_compute_instance.instance_one.network_interface.0.nat_ip_address)
}

output "external_url_two" {
  value = format("http://%s", yandex_compute_instance.instance_two.network_interface.0.nat_ip_address)
}