// here we need to receive the state of the pieces that are common, vpc, subnets, elb, cluster_name
// also, we can do the same but with ssm parameters, better idea!!

data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket = "trader-tracker"
    key    = "infrastructure/core.tfstate"
    region = "eu-west-1"
  }
}

#+   source = "git::https://github.com/your-org/terraform-modules.git//path/to/module?ref=master"


module "create-new-backend" {
  source         = "git@github.com:javfm93/trader-tracker-infrastructure.git//src/use-cases/create-new-backend"
  app_name       = var.app_name
  app_port       = var.app_port
  cluster_id     = data.terraform_remote_state.core.outputs.cluster_id
  desired_tasks  = 1
  elb_name       = data.terraform_remote_state.core.outputs.elb_name
  region         = var.region
  ssm_parameters = local.parameters
  vpc_id         = data.terraform_remote_state.core.outputs.vpc_id
}

module "create-new-frontend" {
  source   = "git@github.com:javfm93/trader-tracker-infrastructure.git//src/use-cases/create-new-frontend"
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
