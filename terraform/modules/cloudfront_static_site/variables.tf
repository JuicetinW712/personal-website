variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the CloudFront distribution to respond to"
  type        = string
}

variable "origin_path" {
  description = "Path within the S3 bucket to serve from"
  type        = string
  default     = "/"
}

variable "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate. Must be located in us-east-1 region"
  type        = string
}

variable "tags" {
  description = "Additional tags (i.e Purpose)"
  type        = map(string)
  default     = {}
}