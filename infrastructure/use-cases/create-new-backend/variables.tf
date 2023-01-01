variable "region" {}

variable "ecs-ami" {}

variable "instance_type" {}

variable "app_name" {}

variable "app_port" {}

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

variable "cidr_blocks" {
  type = map(string)
}

variable "parameters" {
  type = list(object({ name = string, valueFrom = string }))
}
