variable "region" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_port" {
  type = number
}

variable "ecs_iam_role_arn" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "elb_name" {
  type = string
}
