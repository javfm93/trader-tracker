resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  default_root_object = var.default_root_object #"latest/index.html"
  price_class         = "PriceClass_100"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.app_name}-origin"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  custom_error_response {
    error_caching_min_ttl = 3000
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }
  origin {
    domain_name = var.bucket_domain_name # aws_s3_bucket.this.bucket_regional_domain_name
    origin_id   = "${var.app_name}-origin"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for S3 frontend"
}

output "dns" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "id" {
  value = aws_cloudfront_distribution.this.id
}

output "origin_iam_arn" {
  value = aws_cloudfront_origin_access_identity.this.iam_arn
}
