resource "aws_ecr_repository" "this" {
  name = "${var.app_name}-repository"

  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
}

# docker build -t [aws_ecr_url] .
# `aws ecr get-login-password`
# docker push [aws_ecr_url]
