# allow private network to go to the outside
resource "aws_eip" "this" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.public_subnet_id
}

resource "aws_route_table" "allow-private-subnet-access-to-internet" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = local.cidr_blocks.all_ip_addresses
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "${var.app_name}-nat-route-table"
  }
}

resource "aws_route_table_association" "associate-private-subnet-to-nat-gateway" {
  count          = length(var.private_subnets_id)
  subnet_id      = var.private_subnets_id[count.index]
  route_table_id = aws_route_table.allow-private-subnet-access-to-internet.id
}

locals {
  cidr_blocks = {
    all_ip_addresses = "0.0.0.0/0"
  }
}
