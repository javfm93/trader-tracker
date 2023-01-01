resource "aws_iam_role" "this" {
  name               = "ECS-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume-ecs-tasks.json
}

resource "aws_iam_role_policy" "this" {
  policy = data.aws_iam_policy_document.access-to-parameter-store.json
  role   = aws_iam_role.this.id
}

resource "aws_iam_policy_attachment" "ec2-container-management-to-ecs-role" {
  name       = "ecs-service-attachment"
  roles      = [aws_iam_role.this.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

output "arn" {
  value = aws_iam_role.this.arn
}
