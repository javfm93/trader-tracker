variable "app_name" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "description" {
  type = string
}

variable "ingress_configurations" {
  type = list(object({
    description     = string
    from_port       = number
    protocol        = string
    to_port         = number
    security_groups = list(string)
    cidr_blocks     = list(string)
  }))
}
