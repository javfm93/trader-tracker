resource "aws_subnet" "this" {
  count                   = length(var.vpc_subnets)
  vpc_id                  = var.vpc_id
  cidr_block              = var.vpc_subnets[count.index].cidr
  availability_zone       = "${var.region}${var.vpc_subnets[count.index].availability_zone}"
  map_public_ip_on_launch = var.is_public
  tags                    = {
    Name = "main-subnet-${var.is_public ? "public" : "private"}-${count.index}"
  }
}

output "ids" {
  value = aws_subnet.this.*.id
}
