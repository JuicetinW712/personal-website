output "website_url" {
  description = "URL of the website"
  value       = "https://${var.domain_name}"
}

output "www_website_url" {
  description = "URL of the www subdomain"
  value       = "https://www.${var.domain_name}"
}

# output "cloudfront_distribution_id" {
#   description = "CloudFront distribution ID"
#   value       = aws_cloudfront_distribution.s3.id
# }

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.cloudfront_domain_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = module.route53.zone_id
}

# output "route53_name_servers" {
#   description = "Route 53 name servers"
#   value       = aws_route53_zone.main.name_servers
# }

# output "acm_certificate_arn" {
#   description = "ARN of the ACM certificate"
#   value       = module.acm.certificate_arn
# }