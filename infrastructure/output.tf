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

output "cloudfront-dns" {
  value = module.create-new-frontend.cloudfront_dns
}
