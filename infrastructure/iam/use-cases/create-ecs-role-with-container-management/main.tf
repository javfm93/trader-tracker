resource "aws_iam_role" "this" {
  name               = "assumed-by-ecs-role"
  assume_role_policy = file("${path.module}/assumed-by-ecs-role.json")
  description        = "Allows ECS to create and manage AWS resources on your behalf."
}

resource "aws_iam_policy_attachment" "ec2-container-management-to-ecs-role" {
  name       = "ecs-service-attachment"
  roles      = [aws_iam_role.this.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

output "arn" {
  value = aws_iam_role.this.arn
}
