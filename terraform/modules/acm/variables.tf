variable "domain_name" {
  description = "The domain name for the certificate"
  type        = string
}

variable "validation_record_fqdns" {
  description = "List of FQDNs for certificate validation"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags (i.e Purpose)"
  type        = map(string)
  default     = {}
}