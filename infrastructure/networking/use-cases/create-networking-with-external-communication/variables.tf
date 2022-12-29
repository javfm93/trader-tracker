variable "app_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr_block" {}

variable "vpc_public_subnets" {
  type = list(object({
    cidr              = string
    availability_zone = string
  }))
}

variable "vpc_private_subnets" {
  type = list(object({
    cidr              = string
    availability_zone = string
  }))
}
