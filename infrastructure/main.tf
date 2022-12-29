module "create-new-backend" {
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

module "create-new-frontend" {
  source   = "./use-cases/create-new-frontend"
  app_name = var.app_name
}

output "elb" {
  value = module.create-new-backend.elb
}

output "ecr-repository" {
  value = module.create-new-backend.ecr-repository
}

output "frontend-bucket-name" {
  value = module.create-new-frontend.bucket_name
}


output "cloudfront-id" {
  value = module.create-new-frontend.cloudfront_id
}

output cloudfront-dns {
  value = module.create-new-frontend.cloudfront_dns
}
