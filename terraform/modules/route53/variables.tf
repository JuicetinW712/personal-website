variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the Route 53 zone"
  type        = string
}

variable "domain_validation_options" {
  description = "Domain validation options for ACM certificate"
  type        = any
}

variable "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "The hosted zone ID of the CloudFront distribution"
  type        = string
}

variable "tags" {
  description = "Additional tags (i.e Purpose)"
  type        = map(string)
  default     = {}
}