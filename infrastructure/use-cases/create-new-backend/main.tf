module "networking" {
  source              = "../../networking/use-cases/create-networking-with-external-communication"
  app_name            = var.app_name
  region              = var.region
  vpc_cidr_block      = var.vpc_cidr_block
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets
}

module "create-ec2-for-ecs" {
  source                      = "../../ec2/use-cases/create-ec2-for-ecs"
  app_name                    = var.app_name
  app_port                    = var.app_port
  ec2_iam_instance_profile_id = module.ec2-role.instance_profile_id
  public_key_path             = ".ssh/${var.app_name}-key_pair.pub"
  vpc_id                      = module.networking.vpc_id
  region                      = var.region
  public_subnets_id           = module.networking.public_subnets_ids
}

module "ec2-role" {
  source = "../../iam/use-cases/create-ec2-for-ecs-role"
}

module "ecs-cluster-with-service-and-task" {
  source             = "../../ecs/modules/cluster-with-service-and-task"
  app_name           = var.app_name
  app_port           = var.app_port
  ecr_repository_url = module.ecr-repository.ecr_repository_url
  ecs_iam_role_arn   = module.ecs-role.arn
  elb_name           = module.create-ec2-for-ecs.elb_name
  region             = var.region
}

module "ecr-repository" {
  source   = "../../ecr/modules/repository"
  app_name = var.app_name
}

module "ecs-role" {
  source = "../../iam/use-cases/create-ecs-role-with-container-management"
}

module "cloudwatch" {
  source   = "../../cloudwatch/modules/log-group"
  app_name = var.app_name
}

output "elb" {
  value = module.create-ec2-for-ecs.elb_dns_name
}

output "ecr-repository" {
  value = module.ecr-repository.ecr_repository_url
}

