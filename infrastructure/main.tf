module "crete-new-backend" {
  source              = "./use-cases/create-new-backend"
  app_name            = var.app_name
  app_port            = var.app_port
  cidr_blocks         = var.cidr_blocks
  ecs-ami             = var.ecs-ami
  instance_type       = var.instance_type
  region              = var.region
  vpc_cidr_block      = var.vpc_cidr_block
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets
}
