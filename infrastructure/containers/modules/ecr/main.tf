resource "aws_ecr_repository" "this" {
  name = "${var.app_name}-repository"

  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
}
