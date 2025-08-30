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

module "acm" {
  source = "./modules/acm"

  domain_name             = var.domain_name
  validation_record_fqdns = module.route53.validation_record_fqdns

  providers = {
    aws = aws.us-east-1
  }
}

module "route53" {
  source = "./modules/route53"

  project_name              = var.project_name
  domain_name               = var.domain_name
  domain_validation_options = module.acm.certificate_validation_options
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id

  tags = {
    Project = var.project_name
    Domain  = var.domain_name
  }
}

