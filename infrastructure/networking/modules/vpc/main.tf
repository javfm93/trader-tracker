# one vpc per region, can have multiple servers per region (in different available zones)
# lb in the public subnet and the servers in the private
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = {
    Name = "${var.app_name}-vpc"
  }
}

output "id" {
  value = aws_vpc.this.id
}
