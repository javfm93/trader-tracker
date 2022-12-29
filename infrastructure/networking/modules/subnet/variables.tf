variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "is_public" {
  type = bool
}

variable "vpc_subnets" {
  type = list(object({
    cidr              = string
    availability_zone = string
  }))
}


