# allow external ips to contact with public subnet
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags   = {
    Name = "${var.app_name}-internet-gateway"
  }
}

resource "aws_route_table" "allow-internet-access-to-public-subnet" {
  vpc_id = var.vpc_id
  route {
    cidr_block = local.cidr_blocks.all_ip_addresses
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.app_name}-internet-gateway-route-table"
  }
}

resource "aws_route_table_association" "associate-public-subnet-to-internet-gateway" {
  count          = length(var.public_subnets_id)
  subnet_id      = var.public_subnets_id[count.index]
  route_table_id = aws_route_table.allow-internet-access-to-public-subnet.id
}

locals {
  cidr_blocks = {
    all_ip_addresses = "0.0.0.0/0"
  }
}
