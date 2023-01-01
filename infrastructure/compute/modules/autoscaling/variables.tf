variable "region" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_port" {
  type = number
}

variable "public_subnets_id" {
  type = list(string)
}

variable "key_pair_name" {
  type = string
}

variable "iam_instance_profile_id" {
  type = string
}

variable "security_groups_id" {
  type = list(string)
}

variable "load_balancers_name" {
  type = list(string)
}
