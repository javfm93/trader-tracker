module "elb-security-group" {
  source                 = "../../modules/security-group"
  name                   = "elb"
  description            = "elb security group"
  app_name               = var.app_name
  ingress_configurations = local.elb_ingress_configurations
  vpc_id                 = var.vpc_id
}

module "app-security-group" {
  source                 = "../../modules/security-group"
  name                   = "app"
  description            = "app security group"
  app_name               = var.app_name
  ingress_configurations = local.allow_ssh_and_elb_ingress_configurations
  vpc_id                 = var.vpc_id
}

module "key-pair" {
  source          = "../../modules/key_pairs"
  app_name        = var.app_name
  public_key_path = var.public_key_path
}

module "autoscaling" {
  source                  = "../../modules/autoscaling"
  app_name                = var.app_name
  app_port                = var.app_port
  iam_instance_profile_id = var.ec2_iam_instance_profile_id
  key_pair_name           = module.key-pair.name
  security_groups_id      = [module.app-security-group.id]
  ami                     = var.ami
  instance_type           = var.instance_type
  region                  = var.region
  public_subnets_id       = var.public_subnets_id
  load_balancers_name     = [module.elb.name]
}

module "elb" {
  source            = "../../modules/elb"
  app_name          = var.app_name
  app_port          = var.app_port
  security_group_id = module.elb-security-group.id
  public_subnets_id = var.public_subnets_id
}
