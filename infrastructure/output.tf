output "public_alb" {
  value = data.terraform_remote_state.core.outputs.public_alb.dns
}

output "ecr_repository" {
  value = module.create-new-backend.ecr-repository
}

output "frontend_bucket_name" {
  value = module.create-new-frontend.bucket_name
}

output "cloudfront_id" {
  value = module.create-new-frontend.cloudfront_id
}

output "cloudfront_dns" {
  value = module.create-new-frontend.cloudfront_dns
}

output "parameters_to_define_in_ssm" {
  value = [
    module.bitget-api-key-secret.name,
    module.bitget-secret-key-secret.name,
    module.bitget-password-secret.name
  ]
}
