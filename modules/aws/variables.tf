variable "cidr_public_subnet_1" {
  type    = string
  default = "10.0.11.0/24"
}

variable "cidr_public_subnet_2" {
  type    = string
  default = "10.0.12.0/24"
}

variable "cidr_vpc" {
  type = string
  default = "10.0.0.0/16"
}

variable "name" {
  type = string
}

variable "tfuser" {
  type = string
}

