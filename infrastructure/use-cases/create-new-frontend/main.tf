module "s3-website" {
  source                    = "../../storage/use-cases/create-bucket-website"
  app_name                  = var.app_name
  cloudfront_origin_iam_arn = module.cloudfront.origin_iam_arn
}

module "cloudfront" {
  source              = "../../networking/modules/cloudfront"
  app_name            = var.app_name
  bucket_domain_name  = module.s3-website.bucket_domain_name
  default_root_object = "latest/index.html"
}

output "bucket_name" {
  value = module.s3-website.bucket_name
}

output cloudfront_dns {
  value = module.cloudfront.dns
}

output "cloudfront_id" {
  value = module.cloudfront.id
}
