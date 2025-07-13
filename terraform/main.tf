resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-bucket"

  tags = {
    Project = var.project_name
    Domain = var.domain_name
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  routing_rule {
    condition {
      http_error_code_returned_equals = "404"
    }
    redirect {
      replace_key_with = "index.html"
    }
  }
}

locals {
  s3_origin_id = "${var.project_name}-origin"
  s3_domain_name = "${var.project_name}.s3-website-${var.region}.amazonaws.com"
}

resource "aws_cloudfront_distribution" "s3" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.this.website_endpoint
    origin_id = local.s3_origin_id
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = local.s3_origin_id
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 3600
    default_ttl = 86400 # 1 day
    max_ttl = 31536000  # 1 year
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = "PriceClass_100"
}


