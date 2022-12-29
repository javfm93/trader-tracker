resource "aws_iam_role" "this" {
  name               = "assumed-by-ec2-role"
  assume_role_policy = file("${path.module}/assumed-by-ec2-role.json")
}

resource "aws_iam_instance_profile" "this" {
  name = "assumed-by-ec2-role"
  role = aws_iam_role.this.name
}

output "role_id" {
  value = aws_iam_role.this.id
}

output "role_name" {
  value = aws_iam_role.this.name
}

output "instance_profile_id" {
  value = aws_iam_instance_profile.this.id
}
