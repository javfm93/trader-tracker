variable "app_name" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets_id" {
  type = list(string)
}
