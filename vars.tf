variable "cidr-int" {
  type    = list(string)
  default = ["10.10.0.0/24"]
}
variable "cidr-ext" {
  type    = list(string)
  default = ["10.20.0.0/24"]
}
locals {
  gateway_ip = cidrhost(var.cidr-ext[0], 10)
}

variable "instance_two_disk_number" {
    default = 2
}

variable "welcome" {
  default = "who are you?"
  type    = string
}

variable "external_subnet" {
  default = "ext"
  type    = string
}
variable "internal_subnet" {
  default = "int"
  type    = string
}

variable "instance_one_name" {
  default = "instance-one-disk"
  type    = string
}

variable "instance_one_os" {
  default = "ubuntu-2004-lts"
  type    = string
}

variable "instance_two_os" {
  default = "fd8a28k7fnc9u68s45g5"
  type    = string
}