module "ec2-role" {
  source = "../../modules/iam-ec2-role-with-instance-profile"
}

resource "aws_iam_role_policy" "add-ecs-ecr-access-to-ec2" {
  name   = "ecs-ecr-access-policy"
  policy = file("${path.module}/ecs-ecr-access-policy.json")
  role   = module.ec2-role.role_name
}

output "instance_profile_id" {
  value = module.ec2-role.instance_profile_id
}
