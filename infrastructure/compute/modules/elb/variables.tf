variable "app_name" {
  type = string
}

variable "app_port" {
  type = string
}

variable "public_subnets_id" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
