module "ec2-role" {
  source = "../../modules/iam-ec2-role-with-instance-profile"
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = module.ec2-role.role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

output "instance_profile_id" {
  value = module.ec2-role.instance_profile_id
}
