resource "aws_ssm_parameter" "this" {
  name  = var.name
  type  = "String"
  value = var.value
}

output "arn" {
  value = aws_ssm_parameter.this.arn
}


