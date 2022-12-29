# ssh-keygen -f ["${var.app_name}-key_pair"]
resource "aws_key_pair" "this" {
  key_name   = "${var.app_name}-key_pair"
  public_key = file(var.public_key_path)
}

output "name" {
  value = aws_key_pair.this.key_name
}
