variable "region" {
  type = string
}

variable "ami" {
  default = "ami-00ce328eb1ed0570d" #ecs amd ami
}

variable "instance_type" {
  default = "t2.micro" # free tier
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

variable "public_key_path" {
  type = string
}

variable "ec2_iam_instance_profile_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
