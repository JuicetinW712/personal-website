resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

module "s3" {
  source        = "./modules/s3"
  bucket_name   = "${var.project_name}-bucket-${random_string.bucket_suffix.result}"
  bucket_policy = data.aws_iam_policy_document.read_access.json

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = {
    Project = var.project_name
    Domain  = var.domain_name
  }
}

module "cloudfront" {
  source = "./modules/cloudfront_static_site"

  project_name                = var.project_name
  domain_name                 = var.domain_name
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  certificate_arn             = aws_acm_certificate_validation.cert_validation.certificate_arn

  tags = {
    Project = var.project_name
    Domain  = var.domain_name
  }
}

resource "aws_acm_certificate" "this" {
  provider                  = aws.us-east-1
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Project = var.project_name
    Domain  = var.domain_name
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}

resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Project = var.project_name
    Domain  = var.domain_name
  }
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}

resource "aws_route53_record" "apex" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3.domain_name
    zone_id                = aws_cloudfront_distribution.s3.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3.domain_name
    zone_id                = aws_cloudfront_distribution.s3.hosted_zone_id
    evaluate_target_health = false
  }
}



