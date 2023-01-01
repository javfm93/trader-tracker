resource "aws_ecr_repository" "this" {
  name = "${var.app_name}-repository"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
}
