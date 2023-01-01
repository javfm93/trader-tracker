resource "aws_ssm_parameter" "this" {
  name  = var.name
  type  = "SecureString"
  value = var.value

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

output "name" {
  value = aws_ssm_parameter.this.name
}

output "arn" {
  value = aws_ssm_parameter.this.arn
}


