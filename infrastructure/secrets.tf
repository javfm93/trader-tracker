module "bitget-api-key-secret" {
  source = "git::https://@github.com:javfm93/infrastructure-aws-terraform.git//src/storage/use-cases/create-secure-parameter"
  name   = "/${var.app_name}/external/bitget/api-key"
  value  = "to define"
}

module "bitget-secret-key-secret" {
  source = "git::https://@github.com:javfm93/infrastructure-aws-terraform.git//src/storage/use-cases/create-secure-parameter"
  name   = "/${var.app_name}/external/bitget/secret"
  value  = "to define"
}

module "bitget-password-secret" {
  source = "git::https://@github.com:javfm93/infrastructure-aws-terraform.git//src/storage/use-cases/create-secure-parameter"
  name   = "/${var.app_name}/external/bitget/password"
  value  = "to define"
}

module "cloudfront-id-parameter" {
  source = "git::https://@github.com:javfm93/infrastructure-aws-terraform.git//src/storage/use-cases/create-parameter"
  name   = "/${var.app_name}/infrastructure/cloudfront/id"
  value  = module.create-new-frontend.cloudfront_id
}

module "ecr-repository-name-parameter" {
  source = "git::https://@github.com:javfm93/infrastructure-aws-terraform.git//src/storage/use-cases/create-parameter"
  name   = "/${var.app_name}/infrastructure/ecr/repository-name"
  value  = module.create-new-backend.ecr-repository
}
