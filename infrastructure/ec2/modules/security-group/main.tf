resource "aws_security_group" "this" {
  name        = "${var.app_name}-${var.name}-security_group"
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_configurations
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      protocol        = ingress.value.protocol
      to_port         = ingress.value.to_port
      security_groups = try(ingress.value.security_groups, null)
      cidr_blocks     = try(ingress.value.cidr_blocks, null)
    }
  }

  egress {
    description = "Allow everything"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [local.cidr_blocks.all_ip_addresses]
  }

  tags = {
    Name = "${var.app_name}-security_group"
  }
}

output "id" {
  value = aws_security_group.this.id
}

locals {
  cidr_blocks = {
    all_ip_addresses = "0.0.0.0/0"
  }
}
