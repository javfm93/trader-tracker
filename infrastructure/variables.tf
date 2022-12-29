variable "region" {
  default = "eu-west-1"
}

variable "ecs-ami" {
  default = "ami-00ce328eb1ed0570d" #amd ami
}

variable "instance_type" {
  default = "t2.micro"
}

variable "app_name" {
  default = "trader-tracker"
}

variable "app_port" {
  default = 5000
}


variable "vpc_cidr_block" {
  default = "10.0.0.0/16" # 10.0.0.0/16 --> 10.0.X.X, 0 < x < 255 (vpc)
}

variable "vpc_public_subnets" {
  type = list(object({
    cidr              = string
    availability_zone = string
  }))

  default = [
    {
      cidr              = "10.0.1.0/24" # 10.0.1.0/24 --> 10.0.0.X (subnet)
      availability_zone = "a"
    },
    {
      cidr              = "10.0.2.0/24"
      availability_zone = "b"
    }
  ]
}


variable "vpc_private_subnets" {
  type = list(object({
    cidr              = string
    availability_zone = string
  }))

  default = [
    {
      cidr              = "10.0.4.0/24"
      availability_zone = "a"
    },
    {
      cidr              = "10.0.5.0/24"
      availability_zone = "b"
    }
  ]
}

variable "cidr_blocks" {
  type = map(string)
  default = {
    all_ip_addresses = "0.0.0.0/0"
  }
}
