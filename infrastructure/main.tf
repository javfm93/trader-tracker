module "create-new-backend" {
  source              = "git::git@github.com:javfm93/infrastructure-aws-terraform.git//src/use-cases/create-new-backend"
  app_name            = var.app_name
  app_port            = var.app_port
  cidr_blocks         = var.cidr_blocks
  ecs-ami             = var.ecs-ami
  instance_type       = var.instance_type
  region              = var.region
  vpc_cidr_block      = var.vpc_cidr_block
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets
  parameters          = local.parameters
}

module "create-new-frontend" {
  source   = "git::git@github.com:javfm93/infrastructure-aws-terraform.git//src/use-cases/create-new-frontend"
  app_name = var.app_name
}

locals {
  parameters = [
    {
      name      = "BITGET_API_KEY"
      valueFrom = module.bitget-api-key-secret.arn
    },
    {
      name      = "BITGET_SECRET_KEY"
      valueFrom = module.bitget-secret-key-secret.arn
    },
    {
      name      = "BITGET_PASSWORD"
      valueFrom = module.bitget-password-secret.arn
    }
  ]
}
