data "aws_default_tags" "default" {}

resource "aws_cloudfront_origin_access_control" "s3_access" {
  name                              = "${var.project_name}-oac"
  description                       = "OAC for CloudFront access to S3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3" {
  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_id                = "${var.project_name}-origin"
    origin_path              = var.origin_path
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_access.id
  }

  aliases = [var.domain_name, "www.${var.domain_name}"]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  default_cache_behavior {
    target_origin_id       = "${var.project_name}-origin"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = merge(var.tags, data.aws_default_tags.default.tags)
}