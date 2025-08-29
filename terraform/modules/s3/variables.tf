variable "bucket_name" {
  description = "(Required) Name of the S3 bucket. Must be unique"
  type        = string
}

variable "bucket_policy" {
  description = "(Optional) Bucket policy string in JSON format"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "(Optional) Whether to block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "(Optional) Whether to block public policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "(Optional) Whether to ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "(Optional) Whether to restrict public buckets"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags (i.e Purpose)"
  type        = map(string)
  default     = {}
}