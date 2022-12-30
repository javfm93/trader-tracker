resource "aws_s3_bucket" "this" {
  bucket = "${var.app_name}-frontend"
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket
  index_document {
    suffix = "index.html"
  }
  routing_rule {
    redirect {
      replace_key_with = "index.html"
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]
    principals {
      identifiers = [var.cloudfront_origin_iam_arn]
      type        = "AWS"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3600
  }
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}
