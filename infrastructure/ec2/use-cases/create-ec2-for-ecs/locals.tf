# todo: security groups are not being created
locals {
  allow_ssh_and_elb_ingress_configurations = [
    {
      description     = "Communication with app"
      from_port       = var.app_port
      protocol        = "tcp"
      to_port         = var.app_port
      cidr_blocks     = null
      security_groups = [module.elb-security-group.id]
    },
    {
      description     = "ssh, TODO: only allow my ip as cidr"
      from_port       = local.ports.ssh
      protocol        = "tcp"
      to_port         = local.ports.ssh
      cidr_blocks     = [local.cidr_blocks.all_ip_addresses]
      security_groups = null
    }
  ]

  elb_ingress_configurations = [
    {
      description     = "From anywhere to elb port"
      from_port       = 80
      protocol        = "tcp"
      to_port         = 80
      cidr_blocks     = [local.cidr_blocks.all_ip_addresses]
      security_groups = null
    }
  ]

  cidr_blocks = {
    all_ip_addresses = "0.0.0.0/0"
  }

  ports = {
    ssh = 22
  }
}
