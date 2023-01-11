variable "region" {
  default = "eu-west-1"
}

variable "app_name" {
  default = "trader-tracker"
}

variable "app_port" {
  default = 5000
}

variable "app_target_group" {
  type = object({
    port              = number
    protocol          = string
    path_pattern      = list(string)
    health_check_path = string
    priority          = number
  })

  default = {
    port              = 5000
    protocol          = "HTTP"
    path_pattern      = ["/trader-tracker-backend/*"]
    health_check_path = "/health"
    priority          = 1
  }
}